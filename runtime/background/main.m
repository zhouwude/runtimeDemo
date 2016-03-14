//
//  main.m
//  background
//
//  Created by zhouwude on 16/1/13.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyClass.h"
#import <objc/message.h>
#import "MySubClass.h"
#import <objc/runtime.h>
#import "MySubClass.h"
typedef  void (*setter)(id, SEL, BOOL);
void imp_submethod1(id self ,SEL _cmd){
    
    
    NSLog(@"------imp_submethod1---------");
    
    
}
void _IMPMethod (id self,SEL _cmd);
void _IMPMethod (id self,SEL _cmd){
    
    NSLog(@"  -----set implement-----");
    
}
int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSString *text = @"(1,(2,3),(4,(5,6)7))";
//        NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
//        
//        NSString *result = [NSString stringWithFormat:@"(%@)",[[text componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""]];
//        
//        
//        NSLog(@"%@",result);
        
    //CFRunLoopRef
        
//        
        MyClass *myClass = [[MyClass alloc] init];
        MySubClass *mySubClass = [MySubClass new];
//        setter _imp = (setter)[MyClass instanceMethodForSelector:@selector(method3:)];
//        _imp(myClass,@selector(method3:),YES);
        //method_setImplementation函数，注意该函数返回值是方法之前的实现。
        IMP zhouwude =  method_setImplementation(class_getInstanceMethod([myClass class], @selector(method1)),(IMP)_IMPMethod);
        //class_replaceMethod函数，该函数的行为可以分为两种：如果类中不存在name指定的方法，则类似于class_addMethod函数一样会添加方法；如果类中已存在name指定的方法，则类似于method_setImplementation一样替代原方法的实现。注意替换实现的时候 参数得保持一致 增加或减少 都会照成 崩溃。
      
        
        [myClass method1];
        // typedef 直接可以使用别名 否则 要是用 struct name 才能定义
       // Ivar
//        unsigned int outCount = 0;
        
//
//        Class cls = [myClass class];
//        // 类名
//        NSLog(@"class name: %s", class_getName(cls));
//        
//        NSLog(@"==========================================================");
//        // 父类
//        NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
//        NSLog(@"==========================================================");
//        
//        // 是否是元类
//        NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
//        NSLog(@"==========================================================");
//        
        Class meta_class = objc_getMetaClass(class_getName(object_getClass(myClass)));
        NSLog(@"%s's meta-class is %s", class_getName(object_getClass(myClass)), class_getName(meta_class));
        NSLog(@"==========================================================");
        
//        // 变量实例大小
//        NSLog(@"instance size: %zu", class_getInstanceSize(cls));
//        NSLog(@"==========================================================");
//
//        // 成员变量
//        Ivar *ivars = class_copyIvarList(cls, &outCount);
//        for (int i = 0; i < outCount; i++) {
//            Ivar ivar = ivars[i];
//            NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
//        }
//        
//        free(ivars);
//        
//        Ivar string = class_getInstanceVariable(cls, "_string");
//        if (string != NULL) {
//            NSLog(@"instace variable %s", ivar_getName(string));
//        }
//        
//        NSLog(@"==========================================================");
//        
//        // 属性操作
//        objc_property_t * properties = class_copyPropertyList(cls, &outCount);
//        for (int i = 0; i < outCount; i++) {
//            objc_property_t property = properties[i];
//            NSLog(@"property's name: %s", property_getName(property));
//        }
//        
//        free(properties);
//        
//        objc_property_t array = class_getProperty(cls, "array");
//        if (array != NULL) {
//            NSLog(@"property %s", property_getName(array));
//        }
        
//        
//        NSLog(@"==========================================================");
//        
        // 方法操作
//        Method *methods = class_copyMethodList(cls, &outCount);
//        for (int i = 0; i < outCount; i++) {
//            Method method = methods[i];
//            NSLog(@"method's signature: %@------%s",NSStringFromSelector(method_getName(method)),method_getTypeEncoding(method));
//        }
//        free(methods);
//        Method method1 = class_getInstanceMethod(cls, @selector(method1));
//        if (method1 != NULL) {
//            NSLog(@"method %s", method_getName(method1));
//        }
//        Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
//        if (classMethod != NULL) {
//            NSLog(@"class method : %s", method_getName(classMethod));
//        }
//        NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
//
        
        Method method = class_getInstanceMethod([myClass class], @selector(method1));
        class_replaceMethod([myClass class], @selector(method1), (IMP)(imp_submethod1),"v@:");
        objc_msgSend(myClass,@selector(method1));
        struct objc_super superObj;
        superObj.receiver = mySubClass;
        superObj.super_class = class_getSuperclass([mySubClass class]);
        objc_msgSend(mySubClass,@selector(method3WithArg1:arg2:),100,@"11111111");
        objc_msgSendSuper(&superObj, @selector(method3WithArg1:arg2:),100,@"zhouwude1");
        
        //获得项目所有的动态库名称；
       unsigned int count ;
       const char **name= objc_copyImageNames(&count);
        for (int i=0;i<count;i++){
            NSLog(@"---------%s______",name[i]);
        }
        free(name);
        
      NSLog(@"_______________%s______",class_getImageName(object_getClass(myClass)));
        
        //获得库下面所有的类
        const char **className = objc_copyClassNamesForImage(class_getImageName([UIView class]), &count);
        for (int i=0;i<count;i++){
            
            NSLog(@"---------%s______",className[i]);
        }

        // 测试代码
        IMP imp = imp_implementationWithBlock(^(id obj, NSString *str) {
            NSLog(@"%@", str);
        });
        
        class_addMethod(myClass.class, @selector(testBlock:), imp, "v@:@");
        
        MyClass *runtime = [[MyClass alloc] init];
        [runtime performSelector:@selector(testBlock:) withObject:@"hello world!"];
        //获得成员变量的值
       // object_getIvar(<#id obj#>, <#Ivar ivar#>)
        //设置成员变量的值
        //object_setIvar(<#id obj#>, <#Ivar ivar#>, <#id value#>)
       MyClass *cls = [[MyClass alloc] init];
        IMP imp11 = class_getMethodImplementation(object_getClass(cls), @selector(method1));
        imp11;
//
//        NSLog(@"================IMP==========================================");
//        
//        // 协议
//        Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
//        Protocol * protocol;
//        for (int i = 0; i < outCount; i++) {
//            protocol = protocols[i];
//            NSLog(@"protocol name: %s", protocol_getName(protocol));
//        }
//    
//        NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
//        
//        NSLog(@"==========================================================");
//    
//        static dispatch_once_t onceToken;
      
       /* 动态创建类和对象
        runtime的强大之处在于它能在运行时创建类和对象。
        
        动态创建类
        动态创建类涉及到以下几个函数：
        */
        
        // 创建一个新类和元类
       // Class objc_allocateClassPair ( Class superclass, const char *name, size_t extraBytes );
        
        // 销毁一个类及其相关联的类
       // void objc_disposeClassPair ( Class cls );
        
        // 在应用中注册由objc_allocateClassPair创建的类
       // void objc_registerClassPair ( Class cls );
//        Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
//        IMP myImp = (IMP)imp_submethod1;
//        class_addMethod(cls, @selector(submethod1), myImp, "v@:");
//        class_replaceMethod(cls, @selector(method1), myImp, "v@:");
//        class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
//        
//        objc_property_attribute_t type = {"T", "@\"NSString\""};
//        objc_property_attribute_t ownership = { "C", "" };
//        objc_property_attribute_t backingivar = { "V", "_ivar1"};
//        objc_property_attribute_t attrs[] = {type, ownership, backingivar};
//        
//        class_addProperty(cls, "property2", attrs, 3);
//        objc_registerClassPair(cls);
//        
//        id instance = [[cls alloc] init];
//        [instance performSelector:@selector(submethod1)];
//        [instance performSelector:@selector(method1)];
//
        //  iOS默认不支持对数组的KVO,因为普通方式监听的对象的地址的变化，而数组地址不变，而是里面的值发生了改变
     //地址1
        //NSObject
    myClass.string = @"zhouwude";
        
    NSString *str = myClass->zhouwude;
     //地址二
     myClass.string = @"zhouwude111";
       
       Ivar var=  class_getInstanceVariable(object_getClass(myClass), "zhouwude");
        object_setIvar(myClass, var, @"1111222333");
     id myObject =    object_getIvar(myClass, var);
        
        
        NSLog(@"--------------------------%@-------",myObject);
        return UIApplicationMain(argc, argv, nil, [NSString stringWithUTF8String:class_getName([AppDelegate class]) ]);
        
        
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
    
