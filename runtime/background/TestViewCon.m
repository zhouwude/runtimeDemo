//
//  TestViewCon.m
//  background
//
//  Created by zhouwude on 16/1/26.
//  Copyright © 2016年 zhouwude. All rights reserved.
//

#import "TestViewCon.h"
#import <objc/runtime.h>
@implementation TestViewCon

-(void)dealloc{
 
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    //// 创建并返回一个指向所有已注册类的指针列表
   unsigned int classCount;
    Class *myClass;
    myClass =   objc_copyClassList(&classCount);
    for (int i =0; i<classCount; i++) {
        NSLog(@"++++++++++++++++++%s++++++++",class_getName(myClass[i]));
    }
    
    
 
//   // class_addProperty(<#__unsafe_unretained Class cls#>, <#const char *name#>, <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
//    objc_property_attribute_t att[];
//    objc_property_attribute_t att1 ;
////    att1.value =
    //获取已注册的类定义的列表
    int numClasses;
    Class * classes = NULL;
    
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        classes = (Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        NSLog(@"number of classes: %d", numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            
            Class cls = classes[i];
            NSLog(@"class name: %s", class_getName(cls));
        }
        
        free(classes);
    }
    
    
    //动态创建对象
    //class_createInstance函数：创建实例时，会在默认的内存区域为类分配内存。extraBytes参数表示分配的额外字节数。这些额外的字节可用于存储在类定义中所定义的实例变量之外的实例变量。该函数在ARC环境下无法使用。
    
   // 调用class_createInstance的效果与+alloc方法类似。不过在使用class_createInstance时，我们需要确切的知道我们要用它来做什么。在下面的例子中，我们用NSString来测试一下该函数的实际效果：
   // id myObject = class_createInstance(NSString.class, sizeof(unsigned));
    
    //// 创建一个新类和元类
  //  Class objc_allocateClassPair ( Class superclass, const char *name, size_t extraBytes );
    
    // 销毁一个类及其相关联的类
  //  void objc_disposeClassPair ( Class cls );
    
    // 在应用中注册由objc_allocateClassPair创建的类
   // void objc_registerClassPair ( Class cls );
    
    /*objc_allocateClassPair函数：如果我们要创建一个根类，则superclass指定为Nil。extraBytes通常指定为0，该参数是分配给类和元类对象尾部的索引ivars的字节数。
     为了创建一个新类，我们需要调用objc_allocateClassPair。然后使用诸如class_addMethod，class_addIvar等函数来为新创建的类添加方法、实例变量和属性等。完成这些后，我们需要调用objc_registerClassPair函数来注册类，之后这个新类就可以在程序中使用了。
     
     实例方法和实例变量应该添加到类自身上，而类方法应该添加到类的元类上。
     
     objc_disposeClassPair函数用于销毁一个类，不过需要注意的是，如果程序运行中还存在类或其子类的实例，则不能调用针对类调用该方法。
     在前面介绍元类时，我们已经有接触到这几个函数了，在此我们再举个实例来看看这几个函数的使用。*/
//    Class cls = objc_allocateClassPair(NSObject.class, "MySubClass111", 0);
//    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
//    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
//    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
//    
//    objc_property_attribute_t type = {"T", "@\"NSString\""};
//    objc_property_attribute_t ownership = { "C", "" };
//    objc_property_attribute_t backingivar = { "V", "_ivar1"};
//    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
//    
//    class_addProperty(cls, "property2", attrs, 3);
//    objc_registerClassPair(cls);
//    
//    id instance = [[cls alloc] init];
//    [instance performSelector:@selector(submethod1)];
//    [instance performSelector:@selector(method1)];
    //meta-class之所以重要，是因为它存储着一个类的所有类方法。每个类都会有一个单独的meta-class，因为每个类的类方法基本不可能完全相同。
    
    
}
//void imp_submethod1(id self ,SEL _cmd){
//    
//    
//    NSLog(@"------imp_submethod1---------");
//    
//    
//}
@end
