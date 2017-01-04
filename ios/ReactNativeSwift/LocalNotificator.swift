//
//  LocalNotificator.swift
//  ReactNativeSwift
//
//  Created by Stephen Wong on 1/4/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

@objc(LocalNotificator)
final class LocalNotitifcator: NSObject {
  @objc func requestPermissions() {
    guard !RCTRunningInAppExtension() else { return }
    
    let app = RCTSharedApplication()
    let types: UIUserNotificationType = [.badge, .alert, .sound]
    
    let category = UIMutableUserNotificationCategory()
    category.identifier = "SwiftReactNativeCategory"
    
    let settings = UIUserNotificationSettings(types: types, categories: [category])
    
    app?.registerUserNotificationSettings(settings)
    app?.registerForRemoteNotifications()
  }
  
  @objc func checkPermissions(callback: RCTResponseSenderBlock) {
    let defaultPermissions = [
      "alert": false,
      "badge": false,
      "sound": false
    ]
    
    guard let settings = RCTSharedApplication()?.currentUserNotificationSettings,
      UIApplication.instancesRespond(to: #selector(getter: RCTSharedApplication()?.currentUserNotificationSettings)),
      !RCTRunningInAppExtension()
      else {
      callback([defaultPermissions])
      return
    }
    
    let types = settings.types
    var permissions = [String: Bool]()
    permissions["alert"] = types.contains(.alert)
    permissions["badge"] = types.contains(.badge)
    permissions["sound"] = types.contains(.sound)
    
    callback([permissions])
  }
  
  @objc func scheduleLocalNotification(data: [String: Any], callback: RCTResponseSenderBlock) {
    guard let notification = createLocalNotification(data: data) else {
      callback([])
      return
    }
    RCTSharedApplication()?.scheduleLocalNotification(notification)
    callback([NotificationConverter(notification: notification).dictionary])
  }
  
  @objc func cancelLocalNotification(uuid: String) {
    let notificationsToCancel = RCTSharedApplication()?.scheduledLocalNotifications?.filter {
      $0.userInfo?["UUID"] as? String == uuid
    }
    
    notificationsToCancel?.forEach {
      RCTSharedApplication()?.cancelLocalNotification($0)
    }
  }
  
  private func createLocalNotification(data: [String: Any]) -> UILocalNotification? {
    guard let fireDate = data["fireDate"] else { return nil }
    
    let notification = UILocalNotification()
    notification.fireDate = RCTConvert.nsDate(fireDate)
    notification.soundName = UILocalNotificationDefaultSoundName
    notification.alertBody = data["alertBody"] as? String
    notification.alertAction = data["alertAction"] as? String
    notification.alertTitle = data["alertTitle"] as? String
    notification.category = "schedulerViewItemCategory"
    
    if let hasAction = data["hasAction"] as? Bool {
      notification.hasAction = hasAction
    }
    
    let uuid = UUID().uuidString
    if let userInfo = data["userInfo"] as? [AnyHashable: Any] {
      notification.userInfo = userInfo
      notification.userInfo?["UUID"] = uuid
    } else {
      notification.userInfo = ["UUID": uuid]
    }
    
    return notification
  }
}
