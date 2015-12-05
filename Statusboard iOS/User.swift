//
//  User.swift
//  Statusboard
//
//  Created by Bernhard Loibl on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    init?(snap: FDataSnapshot) {
        guard let json = snap.value as? Dictionary<String, AnyObject>,
//                email = json["email"] as? String,
                name = json["name"] as? String,
                department = json["department"] as? String
//                office = json["office"] as? String
            else { return nil }
        
//        self.email = email
        self.name = name
        self.department = department
//        self.office = office
    }
    
    let name, department: String
//    let available: Bool
//    let lastCheckIn: NSDate
//    let imageURL: NSURL
}
