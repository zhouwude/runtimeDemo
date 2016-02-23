//
//  Person.h
//  background
//
//  Created by zhouwude on 16/2/22.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
- (Person* (^)())runBlock;
- (Person* (^)())studyBlock;
@end
