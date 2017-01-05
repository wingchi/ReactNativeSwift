//
//  LocalNotificatorBridge.m
//  ReactNativeSwift
//
//  Created by Stephen Wong on 1/4/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(LocalNotificator, NSObject)

RCT_EXTERN_METHOD(requestPermissions)
RCT_EXTERN_METHOD(checkPermissionsWithCallback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(scheduleLocalNotificationWithData:(NSDictionary *)data callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(cancelLocalNotificationWithUuid:(NSString *)uuid)

@end
