//
//  AppDelegate.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    UIApplication.shared.statusBarStyle = .lightContent
    UINavigationBar.appearance().barTintColor = Constants.Colors.primaryColor
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 22.0)!, NSAttributedStringKey.foregroundColor: UIColor.white]
    UINavigationBar.appearance().tintColor = .white
    return true
  }
}

