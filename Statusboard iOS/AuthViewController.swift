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
    
    let firebaseService = FirebaseService()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        combineLatest(emailTextField.rx_text, passwordTextField.rx_text) { ($0, $1) }
            .sampleLatest(createButton.rx_tap)
            .map { (email, password) in
                return self.firebaseService.createUserObservable(email, password: password)
            }
            .switchLatest()
            .subscribe(onNext: { (next) -> Void in
                    print(next)
                },
                onError: { (error) -> Void in
                    print(error)
                })
            .addDisposableTo(disposeBag)
    }
}
