//
//  PostSignInViewController.swift
//  Shayla
//
//  Created by Nakul Desai on 4/21/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import Firebase

class PostSignInViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "MySegue", sender: self)
        
    }
    @IBAction func logoutAction(_ sender: Any) {
        
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PostSignInViewController.swipeLeft(_:)))
        recognizer.direction = .left
        self.view .addGestureRecognizer(recognizer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
