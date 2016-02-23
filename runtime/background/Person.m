//
//  Person.m
//  background
//
//  Created by zhouwude on 16/2/22.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import "Person.h"

@implementation Person
- (Person *(^)())runBlock {
    Person* (^block)() = ^() {
        NSLog(@"run");
        return self;
    };
    return block;
}
- (Person*(^)())studyBlock {
    Person* (^block)() = ^()  {
        NSLog(@"study");
        return self;
    };
    return block;
}

@end
