//
//  ViewController.m
//  background
//
//  Created by zhouwude on 16/1/13.
//  Copyright © 2016年 zhouwude. All rights reserved.
//
struct{//offset length
    int a;// 0  4
    int b;// 4  4
    float c;//8   4
    char *d;//12 (12/8 不能整除 ＋ 4 ＝ 16 )  8
    // 16 + 8 = 24 (除8 整除)
    char e; // 24 1
    // 24 +1 =25 (+ 7) = 32;
}zhouwude1111;
#define MAC(A) #A
#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/objc.h>
@interface ViewController (){
    NSString *str1;
    NSArray *array1;
    NSString *str2;
    NSString *str3;
    NSArray *array2;
    NSString *str4;
    
}

@end
/*当我们向一个对象发送消息时，runtime会在这个对象所属的这个类的方法列表中查找方法；而向一个类发送消息时，会在这个类的meta-class的方法列表中查找。
 
 meta-class之所以重要，是因为它存储着一个类的所有类方法。每个类都会有一个单独的meta-class，因为每个类的类方法基本不可能完全相同。
 
 再深入一下，meta-class也是一个类，也可以向它发送一个消息，那么它的isa又是指向什么呢？为了不让这种结构无限延伸下去，Objective-C的设计者让所有的meta-class的isa指向基类的meta-class，以此作为它们的所属类。即，任何NSObject继承体系下的meta-class都使用NSObject的meta-class作为自己的所属类，而基类的meta-class的isa指针是指向它自己。这样就形成了一个完美的闭环。
 
 通过上面的描述，再加上对objc_class结构体中super_class指针的分析，我们就可以描绘出类及相应meta-class类的一个继承体系了，如下图所示：*/
@implementation ViewController
int function(int a,int b){
    fprintf(stdout, "%d",100);
    
    return 100;
}

- (IBAction)click:(id)sender {
    
    [self performSegueWithIdentifier:@"showDetail" sender:@"11111111111--------－－－－－－"];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"------%@------",sender);
}

- (void)viewDidLoad {
    [super viewDidLoad];
   float size =  sizeof(zhouwude1111);
    
    __typeof__(function) typefun;
    
    
    NSLog(@"%lu--%lu--%lu---%lu---NSString--%lu--View---%lu-----fun--%lu",sizeof(int),sizeof(int),sizeof(float),sizeof(char *),sizeof(NSString *),sizeof(UIView *),sizeof(typefun));
    str1 = @"1";
    
    str2 = @"2";
    str3 = @"3";
    str4 = @"4";
    
    
    NSLog(@"-----str----%lu",sizeof(typeof(str4)));
    array1 = @[@"",@""];
    
    
    array2 = @[@"",@""];
    
    NSLog(@"%s",MAC(100+200+300));
   
    //stderr 标准输出 就是输出在屏幕上 #将参数格式化成字符串相当于不计算参数的表达式 直接在上面加两个双引号
//    static
//    extern
    //上面两个为存储类型说明符
//    const
//    volatile
//    类型限定说明符
    fprintf(stderr, "%s",MAC(2=2=2=2));
    
    
    [self ex_registerClassPair];

    
    
 }



void TestMetaClass(id self, SEL _cmd) {
    
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    NSLog(@"Class is %p, super class is %p", [self class], [self superclass]);
    
    Class currentClass = [self class];
    Class stringClass = [NSString class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        NSLog(@"--------string-------Following the isa pointer %d times gives %p", i, stringClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
        
        
        stringClass = objc_getClass((__bridge void *)stringClass);
        //我们在for循环中，我们通过objc_getClass来获取对象的isa，并将其打印出来，依此一直回溯到NSObject的meta-class。分析打印结果，可以看到最后指针指向的地址是0x0，即NSObject的meta-class的类地址。
        
       // 这里需要注意的是：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已。
       // currentClass = object_getClass(self);
    }
   
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
    
}
//打印结果
/*0 22:57:07.352 mountain[1303:41490] This objcet is 0x7a6e22b0
 2014-10-20 22:57:07.353 mountain[1303:41490] Class is TestStringClass, super class is NSError
 2014-10-20 22:57:07.353 mountain[1303:41490] Following the isa pointer 0 times gives 0x7a6e21b0
 2014-10-20 22:57:07.353 mountain[1303:41490] Following the isa pointer 1 times gives 0x0
 2014-10-20 22:57:07.353 mountain[1303:41490] Following the isa pointer 2 times gives 0x0
 2014-10-20 22:57:07.353 mountain[1303:41490] Following the isa pointer 3 times gives 0x0
 2014-10-20 22:57:07.353 mountain[1303:41490] NSObject's class is 0xe10000
 2014-10-20 22:57:07.354 mountain[1303:41490] NSObject's meta class is 0x0
 我们在for循环中，我们通过objc_getClass来获取对象的isa，并将其打印出来，依此一直回溯到NSObject的meta-class。分析打印结果，可以看到最后指针指向的地址是0x0，即NSObject的meta-class的类地址。
 
 这里需要注意的是：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已。
 
 */
- (void)ex_registerClassPair {
    //这个例子是在运行时创建了一个NSError的子类TestClass，然后为这个子类添加一个方法testMetaClass，这个方法的实现是TestMetaClass函数。
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:@selector(testMetaClass)];
    
    //获得累的名陈 对于class_getName函数，如果传入的cls为Nil，则返回一个字字符串。
    
    const char *className  = class_getName([self class]) ;
    
    // 获取类的父类
   // Class class_getSuperclass ( Class cls );
    
    // 判断给定的Class是否是一个元类
   // BOOL class_isMetaClass ( Class cls );
    NSLog(@"-----className ---%s",className);
    //class_getSuperclass函数，当cls为Nil或者cls为根类时，返回Nil。不过通常我们可以使用NSObject类的superclass方法来达到同样的目的。
    
   // class_isMetaClass函数，如果是cls是元类，则返回YES；如果否或者传入的cls为Nil，则返回NO。
    
    //实例变量大小(instance_size)
    
    // 获取实例大小
    size_t a =  class_getInstanceSize ( [self class]);
    NSLog(@"--------a ------%@",@(a));
    
    
    //成员变量(ivars)及属性
   // 在objc_class中，所有的成员变量、属性的信息是放在链表ivars中的。ivars是一个数组，数组中每个元素是指向Ivar(变量信息)的指针。runtime提供了丰富的函数来操作这一字段。大体上可以分为以下几类：
    
   // 1.成员变量操作函数，主要包含以下函数：
    unsigned int count ;
    Ivar *vars =  class_copyIvarList([self class],&count);
    NSLog(@"------%@",@(count));
    
    NSLog(@"%s",(char *)vars[0]);
    free(vars);
    
    
    
    
    
}
//每一个函数默认会有两个 参数 一个 self 一个 selector
void run (id self,SEL _cmd){
  
    NSLog(@"---%@",NSStringFromSelector(_cmd));

}
//Obj-C的方法（method）就是一个至少需要两个参数（self，_cmd）的C语言函数，这个函数仅仅输出一句Hello。接下来在addMethod方法中，我们调用class_addMethod()为EmptyClass添加方法，class_addMethod()是这样定义的：
//BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
//其中types参数为"i@:@“，按顺序分别表示：
//i：返回值类型int，若是v则表示void

//@ ：参数id(self)

//: ：SEL(_cmd)

//@ ：id(str)
//
//这些表示方法都是定义好的(Type Encodings)，关于Type Encodings的其他类型定义请参考官方文档
//
//最后调用say:方法：
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(run)){
        
        class_addMethod(self, sel, (IMP)run,"v@:");
        
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*Table 6-1  Objective-C type encodings
 Code
 Meaning
 c
 A char
 i
 An int
 s
 A short
 l
 A long
 l is treated as a 32-bit quantity on 64-bit programs.
 q
 A long long
 C
 An unsigned char
 I
 An unsigned int
 S
 An unsigned short
 L
 An unsigned long
 Q
 An unsigned long long
 f
 A float
 d
 A double
 B
 A C++ bool or a C99 _Bool
 v
 A void
 *
 A character string (char *)
 @
 An object (whether statically typed or typed id)
 #
 A class object (Class)
 :
 A method selector (SEL)*/

@end
