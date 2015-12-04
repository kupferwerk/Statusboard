//
//  AuthViewController.swift
//  Statusboard
//
//  Created by Bernhard Loibl on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    let ref = Firebase(url:"https://shining-heat-4070.firebaseio.com")

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func createAccount(sender: UIButton) {
        
        ref.createUser(emailTextField.text, password: passwordTextField.text, withValueCompletionBlock: {
            error, userData in
            if (error != nil) {
                print(error)
            }
            
            if (userData != nil) {
                print(userData)
            }
        })
        
        ref.authUser(emailTextField.text, password: passwordTextField.text) { error, authData in
            if error != nil {
                
            }
            else {
                print(authData.token)
                print(authData.uid)
                
                guard let email = authData.providerData["email"] as? String else { return }
                
                let newUser = [
                    "email": email
                ]
                
                self.ref.childByAppendingPath("users")
                        .childByAppendingPath(authData.uid).setValue(newUser)
            }
        }
    }
}
