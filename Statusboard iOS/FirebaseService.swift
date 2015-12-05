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

    func createUserObservable(email: String, password: String) -> Observable<(String, String, String)> {
        return create { observer in
            self.ref.createUser(email, password: password, withValueCompletionBlock: { error, userData in
                if error != nil {
                    observer.on(.Error(error))
                } else {
                    if let uid = userData["uid"] as? String {
                        observer.on(.Next((uid, email, password)))
                        observer.on(.Completed)
                    } else {
                        observer.on(.Error(NSError(domain: "create.user", code: 0, userInfo: nil)))
                    }
                }
            })
            
            return NopDisposable.instance
        }
    }

    func authUser(email: String, password: String) -> Observable<FAuthData> {
        return create { observer in
            self.ref.authUser(email, password: password) { error, authData in
                if error != nil {
                    observer.on(.Error(error))
                } else {
                    observer.on(.Next(authData))
                    observer.on(.Completed)
                }
            }
            
            return NopDisposable.instance
        }
    }
    
    func updateUser(uid: String, user: Dictionary<String, String>) {
        self.ref.childByAppendingPath("users")
                .childByAppendingPath(uid).setValue(user)
    }
    
}