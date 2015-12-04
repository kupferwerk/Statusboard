//
//  OfficeLocationManager.swift
//  Statusboard
//
//  Created by Mathias Nagler on 04.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import Foundation
import CoreLocation

let DeviceDidEnterRegionNotification = "DeviceDidEnterRegionNotification"
let DeviceDidLeaveRegionNotification = "DeviceDidLeaveRegionNotification"

public class OfficeLocationManager: NSObject {
    // MARK: Shared Instance
    
    static let sharedInstance = OfficeLocationManager()
    private override init() { }
    
    // MARK: Properties
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = 1
        locationManager.delegate = self
        return locationManager
    }()
    
    func addGeofenceForRegion(region: CLRegion) {
        locationManager.startMonitoringForRegion(region)
    }
    
    func removeGeofenceForRegion(region: CLRegion) {
        locationManager.stopMonitoringForRegion(region)
    }
    
    func setup() {
        locationManager.requestAlwaysAuthorization()
    }
    
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func forwardLocationManagerEvent(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        handleDidEnterRegion(region)
    }
    
    func forwardLocationManagerEvent(manager: CLLocationManager, didLeaveRegion region: CLRegion) {
        handleDidExitRegion(region)
    }
    
    private func handleDidEnterRegion(region: CLRegion) {
        NSNotificationCenter.defaultCenter().postNotificationName(DeviceDidEnterRegionNotification, object: self, userInfo: ["manager" : locationManager, "region" : region])
    }
    
    private func handleDidExitRegion(region: CLRegion) {
        NSNotificationCenter.defaultCenter().postNotificationName(DeviceDidLeaveRegionNotification, object: self, userInfo: ["manager" : locationManager, "region" : region])
    }

}


extension OfficeLocationManager: CLLocationManagerDelegate {
    public func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        handleDidEnterRegion(region)
    }
    
    public func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        handleDidExitRegion(region)
    }
}
