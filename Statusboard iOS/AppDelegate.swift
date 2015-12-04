//
//  AppDelegate.swift
//  Statusboard iOS
//
//  Created by Mathias Nagler on 04.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let locationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Start Region Monitoring
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        OfficeLocations.allValues.forEach { locationManager.startMonitoringForRegion($0.region) }
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        return true
    }

}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // TODO: Handle Region Event
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        // TODO: Handle Region Event
    }
}

