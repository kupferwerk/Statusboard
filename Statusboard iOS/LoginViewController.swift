//
//  LoginViewController.swift
//  Statusboard
//
//  Created by Bernhard Loibl on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let ref = Firebase(url:"https://shining-heat-4070.firebaseio.com")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func login(sender: UIButton) {
        ref.authUser(emailTextField.text, password: passwordTextField.text) {
            error, authData in
            if error != nil {
            
            }
            else {
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
