//
//  NotificationConverter.swift
//  ReactNativeSwift
//
//  Created by Stephen Wong on 1/3/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

final class NotificationConverter {
  let notification: UILocalNotification
  
  init(notification: UILocalNotification) {
    self.notification =  notification
  }
  
  var dictionary: [String: Any] {
    var data = [String: Any]()
    data["hasAction"] = notification.hasAction
    
    data["alertBody"] = notification.alertBody
    data["fireDate"] = notification.fireDate?.timeIntervalSince1970
    data["userInfo"] = notification.userInfo
    data["alertAction"] = notification.alertAction
    data["alertTitle"] = notification.alertTitle
    
    return data
  }
}
