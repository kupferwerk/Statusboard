//
//  FireService.swift
//  Statusboard
//
//  Created by Michael Kao on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class FirebaseService {
    let ref = Firebase(url:"https://shining-heat-4070.firebaseio.com")

    func createUserObservable(email: String, password: String) -> Observable<String> {
        return create { observer in
            self.ref.createUser(email, password: password, withValueCompletionBlock: { error, userData in
                if error != nil {
                    observer.on(.Error(error))
                } else {
                    if let uid = userData["uid"] as? String {
                        observer.on(.Next(uid))
                        observer.on(.Completed)
                    } else {
                        observer.on(.Error(NSError(domain: "create.user", code: 0, userInfo: nil)))
                    }
                }
            })
            
            return NopDisposable.instance
        }
    }

//    func authUser(email: String, password: String) -> Observable<> {
//        return create { observer in
//            self.ref.authUser(email, password: password) { error, authData in
//                if error != nil {
//                    observer.on(.Error(error))
//                } else {
//                    if let uid = userData["uid"] as? String {
//                        observer.on(.Next(uid))
//                        observer.on(.Completed)
//                    } else {
//                        observer.on(.Error(NSError(domain: "create.user", code: 0, userInfo: nil)))
//                    }
//                }
//            }
//            
//            return NopDisposable.instance
//        }
//
//        ref.authUser(emailTextField.text, password: passwordTextField.text) { error, authData in
//            if error != nil {
//                
//            }
//            else {
//                print(authData.token)
//                print(authData.uid)
//                
//                guard let email = authData.providerData["email"] as? String else { return }
//                
//                let newUser = [
//                    "email": email
//                ]
//                
//                self.ref.childByAppendingPath("users")
//                    .childByAppendingPath(authData.uid).setValue(newUser)
//            }
//        }
//    }

}