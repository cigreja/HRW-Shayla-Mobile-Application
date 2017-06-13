//
//  ResetPasswordViewController.swift
//  Shayla
//
//  Created by Nakul Desai on 4/21/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    

    @IBAction func resetAction(_ sender: Any) {
        if userName.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.sendPasswordReset(withEmail: userName.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success!"
                    message = "Password reset email sent."
                    self.userName.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(vc!, animated: true, completion: nil)*/
            })
        }

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

       

   
}
