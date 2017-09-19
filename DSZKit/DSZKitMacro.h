//
//  DSZKitMacro.h
//  DSZ
//
//  Created by DSZ on 15/10/1.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#ifndef DSZKitMacro_h
#define DSZKitMacro_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define DSZDEPRECATED(_version) __attribute__((deprecated))


#ifndef DSZ_MAX
#define DSZ_MAX(a, b)  (((a) > (b)) ? (a) : (b))
#endif

#ifndef DSZ_MIN
#define DSZ_MIN(a, b)  (((a) < (b)) ? (a) : (b))
#endif

#ifndef DSZ_ABS
#define DSZ_ABS(a)  (((a) < 0) ? -(a) : (a))
#endif

#ifndef DSZ_CLAMP
#define DSZ_CLAMP(x, low, high)  (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))
#endif

#ifndef DSZ_SWAP
#define DSZ_SWAP(a, b)  do { __typeof__(a) _tmp_ = (a); (a) = (b); (b) = _tmp_; } while (0)
#endif



#pragma mark - 机型获取

#define IS_IPHONE_4_OR_LESS (DSZScreenHeight < 568.000000)
#define IS_IPHONE_5 (DSZScreenHeight == 568.000000)
#define IS_IPHONE_6 (DSZScreenHeight == 667.000000)
#define IS_IPHONE_6P (DSZScreenHeight == 736.000000)


#pragma mark - 获取应用屏幕大小

#define DSZAppFrame [[UIScreen mainScreen] applicationFrame]
#define DSZScreenBounds [UIScreen mainScreen].bounds
#define DSZScreenWidth DSZScreenBounds.size.width
#define DSZScreenHeight DSZScreenBounds.size.height
#define DSZViewHeight CGRectGetHeight(DSZScreenBounds) - 44 - 20


#define UINavigationBarHidden [self.navigationController setNavigationBarHidden:YES animated:YES];
#define UINavigationBarShow [self.navigationController setNavigationBarHidden:NO animated:YES];

#pragma mark - iOS系统版本

#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0 && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
#define IOS8 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_x_Max)
#define IOS9 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_8_x_Max && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_9_x_Max)
#define IOS10 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_x_Max)
#define IOS7_0_2 [[[UIDevice currentDevice] systemVersion] isEqualToString:@"7.0.2"]



// 获取keyWindow
#define DSZKeyWindow [UIApplication  sharedApplication].keyWindow

// 根据16位RBG值转换成颜色，格式:UIColorFrom16RGB(0xFF0000)
#define UIColorFrom16RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFrom16RGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 根据10位RBG值转换成颜色, 格式:KLColorFrom10RBG(255,255,255)
#define UIColorFrom10RGB(RED, GREEN, BLUE) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:1.0]

#define UIColorFrom10RGBA(RED, GREEN, BLUE, Alpha) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:Alpha]
#define URL(url) [NSURL URLWithString:url]
#define string(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2]
#define s_str(str1) [NSString stringWithFormat:@"%@",str1]
#define s_Num(num1) [NSString stringWithFormat:@"%d",num1]
#define s_Integer(num1) [NSString stringWithFormat:@"%ld",num1]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 微软雅黑
#define YC_YAHEI_FONT(FONTSIZE) [UIFont fontWithName:@"MicrosoftYaHei" size:(FONTSIZE)]
// 英文 和 数字
#define YC_ENGLISH_FONT(FONTSIZE) [UIFont fontWithName:@"Helvetica Light" size:(FONTSIZE)]
#define kAppDelegate ((DSZAppDelegate *)[[UIApplication sharedApplication] delegate])

#pragma mark - 日志打印
#ifdef DEBUG
#define DSZLog(fmt, ...) NSLog((@"\n<---%@ line:%d--->\n %s\n" fmt), @__FILE__.lastPathComponent, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define DSZLog(...)
#endif
#define DSZErrorLog(fmt, ...) NSLog((@"\n<---Error !!!!!!!!%@ line:%d--->\n %s\n" fmt), @__FILE__.lastPathComponent, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);

#pragma mark - 断言宏
#ifdef DEBUG
#define	DAssert(x) if(!(x)) {int a=1; int b=0;int c=a/b; c++;}
#else
#define	DAssert(x) if(!(x)) {}
#endif

#pragma mark - 对字符串做特殊的宏，即保证返回的值不为空

#define ISNIL(x) ((x) == nil ? @"" : (x))
#define ISNILDefault(x, y) ((x) == nil ? y : (x))
#define ISNULL(x) ((x) == nil || [(x) isEqualToString:@"(null)"] ? @"" : (x))
#define ISNSNull(x) ([(x) isKindOfClass:[NSNull class]] ? nil : (x))

#pragma mark - 对于block的弱引用
#define kWeakSelf __weak __typeof(self)weakSelf = self;
#define kStrongSelf __strong __typeof(weakSelf)strongSelf = weakSelf;
#define kBlockSelf __block __typeof(self)blockSelf = self;

#pragma mark - 快速的查看一段代码的执行时间
#define STARTTIME   NSDate *startTime = [NSDate date];
#define ENDTIME   NSLog(@"Time: %f s", -[startTime timeIntervalSinceNow]);
#define ENDTIMEC(x)   NSLog(@"%@: %f s", (x), -[startTime timeIntervalSinceNow]);

//定义UIImage对象
#define IMAGENAMED(_pointer) [UIImage imageNamed:_pointer]

//static void blockCleanUp(__strong void(^*block)(void)) {
//    (*block)();
//}

// 此方法类似于swift中defer
// 作用是可以在生命结束时，回调此方法。 http://blog.sunnyxx.com/2014/09/15/objc-attribute-cleanup/
#define onExit\
    __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^

/**
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) UIColor *myColor;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 SYNTH_DYNAMIC_PROPERTY_OBJ(myColor, setMyColor, RETAIN, UIColor *)
 @end
 */
#ifndef SYNTH_DYNAMIC_PROPERTY_OBJ
#define SYNTH_DYNAMIC_PROPERTY_OBJ(getter, setter, association, type) \
- (void)setter : (type)object { \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## association); \
} \
- (type)getter { \
return objc_getAssociatedObject(self, @selector(setter:)); \
}
#endif



/**
 Synthesize a sharedInstace.
 *******************************************************************************
 Example:
 - (MyManager *)sharedManager {
 SYNTH_SHARED_INSTANCE();
 }
 */
#ifndef SYNTH_SHARED_INSTANCE
#define SYNTH_SHARED_INSTANCE() \
static id sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance  = [[[self class] alloc] init]; \
}); \
return sharedInstance;
#endif






/**
 生成单例模式.
 *******************************************************************************
 Example:
 SINGLETON_m(TestClass)
 */

#define SINGLETON_H(classname) + (nonnull instancetype)shared##classname;

#define SINGLETON_M(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}


//#define kNavigationBarColor UIColorFrom10RGB(118, 172, 236)
//#define KNavigationBarLineColor UIColorFrom10RGB(118, 172, 236)
#define kNavigationBarTitleColor UIColorFrom16RGB(0xFFFFFF)
#define kNavigationLeftRightItemColor UIColorFrom16RGB(0xFFFFFF)
#define kNavigationLeftItemColor UIColorFrom10RGB(118, 172, 236)
#define kNavigationBackImageName @"ic_back"

#define kTokenError @"TokenError"       // token异常


#endif /* DSZKitMacro_h */

// 图片路径
#define DSZBaseSrcName(file) [@"DSZBase.bundle" stringByAppendingPathComponent:file]
#define DSZBaseFrameworkSrcName(file) [@"Frameworks/DSZKit.framework/DSZBase.bundle" stringByAppendingPathComponent:file]

#define DSZBaseImageName(file) [UIImage imageNamed:DSZBaseSrcName(file)] ?: [UIImage imageNamed:DSZBaseFrameworkSrcName(file)];


#define DSZMapSrcName(file) [@"DSZMap.bundle" stringByAppendingPathComponent:file]
#define DSZMapFrameworkSrcName(file) [@"Frameworks/DSZKit.framework/DSZMap.bundle" stringByAppendingPathComponent:file]

#define DSZMapImageName(file) [UIImage imageNamed:DSZMapSrcName(file)] ?: [UIImage imageNamed:DSZMapFrameworkSrcName(file)];



