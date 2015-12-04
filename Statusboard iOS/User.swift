//
//  User.swift
//  Statusboard
//
//  Created by Bernhard Loibl on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import Foundation
import Locksmith

struct User {
    let email, firstname, lastname, department, office: String
    let available: Bool
    let lastCheckIn: NSDate
    let imageURL: NSURL
}

struct FirebaseAccount: ReadableSecureStorable,
                        CreateableSecureStorable,
                        DeleteableSecureStorable,
                        GenericPasswordSecureStorable {
    let uid, token: String

    let service = "Firebase"
    var account: String { return uid }
    
    var data: [String: AnyObject] {
        return ["token": token]
    }
}