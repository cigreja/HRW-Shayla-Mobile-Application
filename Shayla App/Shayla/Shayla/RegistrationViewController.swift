//
//  RegistrationViewController.swift
//  Shayla
//
//  Created by Yu Chen on 3/26/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import Firebase



class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectPhoto: UIImageView!
    //@IBOutlet weak var register: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    //@IBOutlet weak var registerButton: UIButton!
    
    
    
    
   
    
    
    //Action for the REGISTER button
   @IBAction func register(_ sender: Any) {
        
        guard let emailText = email.text, let passwordText = password.text, let name = userName.text
            else {
                print("Form is invalid")
                return
        }
        
        //Authorizes the user for account creation
      
        FIRAuth.auth()?.createUser(withEmail: emailText, password: passwordText,completion: {(user: FIRUser?, error) in
                        
            guard let uid = user?.uid else {
                return
            }
            //successfully authenticated
            
            //Creating unique strings for profile images
            let imageName = NSUUID().uuidString
            
            //Creating storage references with child references to create different root in the database structure
            let storageRef = FIRStorage.storage().reference().child("Profile_Images").child("\(imageName).png")
            
            //Uplading user credentials to the firebase
            if let uploadData = UIImagePNGRepresentation(self.selectPhoto.image!){
                storageRef.put(uploadData, metadata: nil, completion: {(metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                     let values = ["name": name, "email": emailText, "profileImageUrl":profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        print(metadata!)
                    }
                })
            }
        })
    }
    
    
    //Function that registers users to firebase with unique IDS
    private func registerUserIntoDatabaseWithUID (uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference(fromURL: "https://shayla-90e22.firebaseio.com/")
        let childRef = ref.child("Users").child((uid))
        
        
        
        childRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            self.dismiss(animated: true, completion: nil)
        })

        
    }
    
    
    //Tentative select button function that brings the picker for image selection from photo library
    @IBAction func selectImage(sender: AnyObject) {
        let myPickerControlller = UIImagePickerController()
        myPickerControlller.delegate = self;
        myPickerControlller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerControlller, animated: true, completion: nil)
        myPickerControlller.allowsEditing = true
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel button pressed")
        dismiss(animated: true, completion: nil)
    }
    
    //Function to assign image to the image view once selected in the picker view

     @nonobjc public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
          selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            selectPhoto.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
     
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
   

   
}
