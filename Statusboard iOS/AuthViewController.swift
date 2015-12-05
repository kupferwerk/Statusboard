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

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var officeTextField: UITextField!
    
    let firebaseService = FirebaseService()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let account = FirebaseAccount(uid: authData.uid, token: authData.token)
                try account.createInSecureStore()
                return authData
            })
        
        combineLatest(observable,
            firstnameTextField.rx_text,
            lastnameTextField.rx_text,
            departmentTextField.rx_text,
            officeTextField.rx_text
        ) { ($0, $1, $2, $3, $4) }
            .subscribeNext { (authData: FAuthData, firstname, lastname, department, office) -> Void in
                let user: Dictionary<String, String> = [
                    "firstname": firstname,
                    "lastname": lastname,
                    "department": department,
                    "office": office
                ]
                
                self.firebaseService.updateUser(authData.uid, user: user)
            }
            .addDisposableTo(disposeBag)
    }
}
