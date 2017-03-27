//
//  ViewController.swift
//  Shayla
//
//  Created by Yu Chen on 3/26/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    @IBOutlet weak var facebbookLoginButton: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        fbLoginButton.center = self.view.center
        facebbookLoginButton.insertArrangedSubview(fbLoginButton, at: 0)
        
    }
}

