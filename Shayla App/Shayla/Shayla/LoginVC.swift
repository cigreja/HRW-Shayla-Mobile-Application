//
//  ViewController.swift
//  Shayla
//
//  Created by Yu Chen on 3/26/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit
import TwitterKit
import GoogleSignIn
import Google
import FirebaseAuth
import FBSDKLoginKit

class LoginVC: UIViewController, LoginButtonDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var facebookLoginButton: UIStackView!
    @IBOutlet weak var twitterLoginButton: UIStackView!
    @IBOutlet weak var googleLoginButton: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signIn()
        
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        UIApplication.shared.statusBarStyle = .lightContent
        
        showFacebookButton()
        showTwitterButton()
        showGoogleButton()
        
        
    }
    
    // Facebook Button
    func showFacebookButton() {

        let fbLoginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        facebookLoginButton.center = self.view.center
        fbLoginButton.delegate = self
        facebookLoginButton.insertArrangedSubview(fbLoginButton, at: 0)
    }
    
    // Facebook Login
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        switch result {
            
        case .failed(let error):
            print(error)
            
        case .cancelled:
            print("User cancelled login.")
            
        case .success:
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                
                if (error == nil) {
                    
                    if let userDict = result as? NSDictionary {
                        
                        print(userDict)
                        print(FBSDKAccessToken.current())
                    }
                }
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                }
            })
        }
    }
    
    // Facebook Logout
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        print("User Logged Out")
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
        
    // Twitter Button
    func showTwitterButton() {
        
        let twitterLogInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                
                let twtCredential = FIRTwitterAuthProvider.credential(withToken: authToken!, secret: authTokenSecret!)
                
                FIRAuth.auth()?.signIn(with: twtCredential) { (user, error) in
                    
                    if error != nil {
                        print(error!)
                        return
                    } else {
                        
                       FIRAuth.auth()?.currentUser?.updateEmail("cvaghela@gmail.com") { (error) in
                 
                       }
                    }
                }
            }
        })
        
        twitterLogInButton.loginMethods = [.webBased]
        
        // Change where the log in button is positioned in your view
        twitterLoginButton.insertArrangedSubview(twitterLogInButton, at: 0)
        twitterLoginButton.center = self.view.center
    }
    
    //Google Button
    func showGoogleButton() {
        
        let googleSignIn = GIDSignInButton()
        
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        
        if error != nil {
            
            print(error!)
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        googleLoginButton.insertArrangedSubview(googleSignIn, at: 0)
        googleLoginButton.center = self.view.center
    }
}

