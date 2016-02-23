//
//  AppDelegate.m
//  background
//
//  Created by zhouwude on 16/1/13.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
#import "Person.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    void(^b2)() = ^(){
        
        
    };
    
    void(^b1)() = ^{
        
        dispatch_async(dispatch_get_main_queue(),b2);
        
    };
    
    dispatch_async(dispatch_get_global_queue(0,0),b1);

    int (^block)();
    block = ^{
        return 3;
    };
   // int a= block();
    Person*person = [[Person alloc]init];
    //person.runBlock 返回 一个 block 在后面加一个（）相当于调用这个block 在 block中返回一个对象 则又可以调用下一个 block
  person = person.runBlock().studyBlock().runBlock();
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
