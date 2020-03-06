//
//  AppDelegate.h
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *ServerIP;
@property (strong, nonatomic) NSString *QCloudIP;

@end

