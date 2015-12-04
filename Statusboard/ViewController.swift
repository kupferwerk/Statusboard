//
//  ViewController.swift
//  Statusboard
//
//  Created by Bernhard Loibl on 04/12/15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myRootRef = Firebase(url:"https://shining-heat-4070.firebaseio.com")
        myRootRef.setValue("Do you have data? You'll love Andy.")
    }

}

