//
//  AppDelegate.swift
//  Statusboard iOS
//
//  Created by Mathias Nagler on 04.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit
import CoreLocation
import Locksmith
import Firebase
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let usersRef = Firebase(url: "https://shining-heat-4070.firebaseio.com/users")
    let firebaseService = FirebaseService()
    var disposeBag = DisposeBag()

    var window: UIWindow?
    
    let locationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Start Region Monitoring
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        OfficeLocations.allValues.forEach { locationManager.startMonitoringForRegion($0.region) }
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        window?.makeKeyAndVisible()
        
        firebaseService.ref.observeAuthEventWithBlock{ authData in
            if authData != nil {
                self.showProfileViewControllerWithUid(authData.uid)
            }
            else {
                self.showAuthViewController()
            }
        }
        
        usersRef.observeEventType(.Value, withBlock: { [unowned self] snapshot in
            print("snapshot: \(snapshot)")
            
            self.usersRef.removeAllObservers()
        })

        return true
    }
    
    func showAuthViewController() -> Void {
        let storyboard = UIStoryboard(name: "AuthLogin", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("Auth")
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
    
    func showProfileViewControllerWithUid(uid: String) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        window?.rootViewController = viewController
    }

}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
}
