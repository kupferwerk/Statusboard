//
//  ViewController.swift
//  Statusboard iOS
//
//  Created by Mathias Nagler on 04.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit

internal class ProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var departmentButton: UIButton!
    @IBOutlet weak var profilePictureView: ProfilePictureView!
    @IBOutlet weak var emailTextField: UITextField!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        userNameTextField.text = user?.name
//        emailTextField.text = user?.email
    }

    //MARK: - IBActions
    @IBAction func changeDepartment(sender: AnyObject) {
        print("Department")
    }
    
    @IBAction func switchEditMode(sender: AnyObject) {
        self.setEditing(!editing, animated: true)
    }

    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "switchEditMode:") , animated: true)
            userNameTextField.enabled = true
            userNameTextField.borderStyle = .RoundedRect
            departmentButton.enabled = true
            profilePictureView.isEditing = true
            emailTextField.enabled = true
            emailTextField.borderStyle = .RoundedRect
        } else {
            navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "switchEditMode:") , animated: true)
            userNameTextField.enabled = false
            userNameTextField.borderStyle = .None
            departmentButton.enabled = false
            profilePictureView.isEditing = false
            emailTextField.enabled = false
            emailTextField.borderStyle = .None
        }
    }
    
    
    
    @IBAction func unwindToProfile(sender: UIStoryboardSegue) {
        let sourceViewController = sender.sourceViewController
        // Pull any data from the view controller which initiated the unwind segue.
        
        print("bla")
    }
    
}

