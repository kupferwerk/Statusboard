//
//  OfficeLocations.swift
//  Statusboard
//
//  Created by Mathias Nagler on 04.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import Foundation
import CoreLocation

public enum OfficeLocations {
    case Ratisbon, Munich
    
    var name: String {
        switch self {
        case .Ratisbon: return "Regensburg"
        case .Munich: return "München"
        }
    }
    
    var geolocation: CLLocationCoordinate2D {
        switch self {
        case .Ratisbon: return CLLocationCoordinate2D(latitude: 49.01700599999999, longitude: 12.121948299999985)
        case .Munich: return CLLocationCoordinate2D(latitude: 48.1524523, longitude: 11.59670779999999)
        }
    }
}