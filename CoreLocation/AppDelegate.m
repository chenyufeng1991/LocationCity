//
//  AppDelegate.m
//  CoreLocation
//
//  Created by helmsmanmac on 15/8/16.
//  Copyright (c) 2015年 chenyufengweb. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController * viewController = [[ViewController alloc] init];
    [_window setRootViewController:viewController];
    [_window makeKeyAndVisible];
    return YES;
}

@end
