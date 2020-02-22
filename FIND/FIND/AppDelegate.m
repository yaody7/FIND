//
//  AppDelegate.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "AppDelegate.h"
#import "FoundViewController.h"
#import "LostViewController.h"
#import "MeViewController.h"
#import "LoginViewController.h"
@interface AppDelegate ()
{
    UITabBarController *tabc;   //Main view
    UINavigationController *log_re; //Login & Register navigation
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    //tab[nav[found]]]
    tabc = [[UITabBarController alloc]init];
    FoundViewController *foundc = [[FoundViewController alloc]init];
    UINavigationController *navc1 = [[UINavigationController alloc]initWithRootViewController:foundc];
    [tabc addChildViewController:navc1];
    //tab[nav[lost]]]
    LostViewController *lostc = [[LostViewController alloc]init];
    UINavigationController *navc2 = [[UINavigationController alloc]initWithRootViewController:lostc];
    [tabc addChildViewController:navc2];
    //add meVC
    MeViewController *mec = [[MeViewController alloc]init];
    [tabc addChildViewController:mec];
    //init window
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //set rootVC
    if(self.user == nil){
        LoginViewController *loginc = [[LoginViewController alloc]init];
        log_re = [[UINavigationController alloc]initWithRootViewController:loginc];
        self.window.rootViewController = log_re;
    }
    else{
        self.window.rootViewController=tabc;
    }
 //   self.window.rootViewController = [[MeViewController alloc]init];
    //observe user
    [self addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"User change!");
    if(self.user!=nil){
        self.window.rootViewController=tabc;
    }
    else{
        self.window.rootViewController=log_re;
    }
}

@end
