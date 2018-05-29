//
//  AppDelegate.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flow: RootFlowController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppStyle.applyGlobalAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        flow = RootFlowController(window: window)
        flow?.start()
        
        return true
    }
}

