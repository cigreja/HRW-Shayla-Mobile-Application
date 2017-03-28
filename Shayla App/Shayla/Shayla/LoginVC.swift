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

class LoginVC: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var facebookLoginButton: UIStackView!
    @IBOutlet weak var twitterLoginButton: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        UIApplication.shared.statusBarStyle = .lightContent
        
        showFacebookButton()
        showTwitterButton()
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
            })
        }
    }
    
    // Facebook Logout
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        print("User Logged Out")
    }
        
    // Twitter Button
    func showTwitterButton() {
        
        let twitterLogInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                
                let alert = UIAlertController(title: "Logged In", message: "User \(unwrappedSession.userName) has logged in", preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // Change where the log in button is positioned in your view
        twitterLoginButton.insertArrangedSubview(twitterLogInButton, at: 0)
        twitterLoginButton.center = self.view.center
    }
}

