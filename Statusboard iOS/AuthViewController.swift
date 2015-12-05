//
//  AuthViewController.swift
//  Statusboard
//
//  Created by Bernhard Loibl on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa
import Locksmith

class AuthViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var departmentTextField: UITextField!
    
    let firebaseService = FirebaseService()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        let observable = combineLatest(emailTextField.rx_text, passwordTextField.rx_text) { ($0, $1) }
            .sampleLatest(createButton.rx_tap)
            .map { (email, password) in
                return self.firebaseService.createUserObservable(email, password: password)
            }
            .switchLatest()
            .catchError { error in
                print(error) // TODO: show error
                return empty()
            }
            .flatMapLatest({ (uid, email, password) -> Observable<FAuthData> in
                return self.firebaseService.authUser(email, password: password)
            })
            .map({ (authData) -> FAuthData in
                
                return authData
            })
        
        combineLatest(observable,
            nameTextField.rx_text,
            departmentTextField.rx_text
        ) { ($0, $1, $2) }
            .subscribeNext { (authData: FAuthData, name, department) -> Void in
                let user: Dictionary<String, String> = [
                    "name": name,
                    "department": department,
                ]
                
                self.firebaseService.updateUser(authData.uid, user: user)
            }
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            UIView.animateWithDuration(0.2) {
                self.nameLabel.hidden = false
                self.nameTextField.hidden = false
                self.departmentLabel.hidden = false
                self.departmentTextField.hidden = false
            }
        case 1:
            UIView.animateWithDuration(0.2) {
                self.nameLabel.hidden = true
                self.nameTextField.hidden = true
                self.departmentLabel.hidden = true
                self.departmentTextField.hidden = true
            }
        default: break
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.scrollView.contentInset = UIEdgeInsetsZero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    

}
