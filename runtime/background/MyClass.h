//
//  MyClass.h
//  background
//
//  Created by zhouwude on 16/1/14.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject<NSCopying,NSCoding>{
    
 @public   NSString *zhouwude;
   
}
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *string;

- (void)method1;

- (void)method2;
//
//-(void)method3:(BOOL)is;
+ (void)classMethod1;

@end
