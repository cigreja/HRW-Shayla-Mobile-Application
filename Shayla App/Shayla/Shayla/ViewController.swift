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

class ViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var facebbookLoginButton: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFacebookButton()
    }
    
    // Facebook Button
    func showFacebookButton() {
        
        let fbLoginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        fbLoginButton.center = self.view.center
        fbLoginButton.delegate = self
        facebbookLoginButton.insertArrangedSubview(fbLoginButton, at: 0)
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
                    }
                }
            })
        }
    }
    
    // Facebook Logout
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        print("User Logged Out")
    }
}

