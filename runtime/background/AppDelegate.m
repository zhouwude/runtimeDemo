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
#import <mach/message.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //
    //第二种比第一个多一个Options，第二种方式是创建了一个内存映射文件，把内容放在虚拟内存中，只有读取操作的时候才会读到相对应页的物理内存页中。所以后者，对于大文件是很划算的，推荐使用第二种。对于可选的方式如下：
    [NSData dataWithContentsOfFile:@""];
    
    //NSDataReadingMapped
    [NSData dataWithContentsOfFile:@"" options:0 error:nil];
    
    
    
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
    
    
    NSLog(@"-----%@",b1);// 在mrc中block保存在栈上 函数返回后Block将无效 /需要手动copy 但在arc中 会自动copy到堆上。
    
    NSLog(@"-----%@",b2);//未引用外不变量的情况下 保存在全局区 （arc mrc 一样）
    //<__NSMallocBlock__: 0x7f9c30e07cd0>
   // 2016-02-23 14:14:56.461 background[15347:725408] -----<__NSGlobalBlock__: 0x1068a2230>
    //
  NSString *nonMutable = @"zhouwude";
    id string1 = [nonMutable copy];//指针拷贝 浅拷贝 相当于 retain
    id string2 = [nonMutable mutableCopy];//深拷贝 值的 拷贝
    NSMutableString *mutable = [[NSMutableString alloc] initWithString:@"zhouwude1"];
    id string3 = [mutable copy];//
    id string4 = [mutable mutableCopy];// 对不可变对象的 copy mutableCopy 都是深拷贝 值得拷贝
     NSLog(@"-----%@",string1);
     NSLog(@"-----%@",string2);
     NSLog(@"-----%@",string3);
     NSLog(@"-----%@",string4);
    
    
    
    
    
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
