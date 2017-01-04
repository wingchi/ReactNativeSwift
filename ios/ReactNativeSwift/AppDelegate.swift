//
//  AppDelegate.swift
//  ReactNativeSwift
//
//  Created by Stephen Wong on 1/3/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var bridge: RCTBridge!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
    let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index.ios", fallbackResource: nil)
    
    let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "ReactNativeSwift", initialProperties: nil, launchOptions: launchOptions)
    rootView?.backgroundColor = UIColor.blue
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    rootViewController.view = rootView
    
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
    RCTSharedApplication()?.cancelLocalNotification(notification)
    bridge.eventDispatcher().sendAppEvent(withName: "didReceiveLocalNotification", body: NotificationConverter(notification: notification).dictionary)
  }
}
