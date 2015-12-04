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
        case Ratisbon: return "Regensburg"
        case Munich: return "München"
        }
    }
    
    var geolocation: CLLocationCoordinate2D {
        switch self {
        case Ratisbon: return CLLocationCoordinate2D(latitude: 49.01705, longitude: 12.1218)
        case Munich: return CLLocationCoordinate2D(latitude: 48.1520, longitude: 11.5960)
        }
    }
    
    var region: CLCircularRegion {
        return CLCircularRegion(center: geolocation, radius: 75, identifier: name)
    }
    
    static let allValues = [Ratisbon, Munich]
}