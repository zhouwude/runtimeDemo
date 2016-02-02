//
//  MySubClass.m
//  background
//
//  Created by zhouwude on 16/1/17.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import "MySubClass.h"

@implementation MySubClass
- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    
    NSLog(@"mysubclass     arg1 : %ld, arg2 : %@", arg1, arg2);
}
@end
