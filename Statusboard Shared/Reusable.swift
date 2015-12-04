//
//  Reusable.swift
//  Statusboard
//
//  Created by Mathias Nagler on 04.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit

public protocol Reusable {
    static var reuseId: String { get }
}

extension Reusable {
    public static var reuseId: String {
        return String(self).componentsSeparatedByString(".").last!
    }
}

extension UICollectionViewCell: Reusable { }
