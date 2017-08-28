//
//  DSZTools.h
//  DSZ
//
//  Created by HuHao on 15/9/28.
//  Copyright © 2015年 DSZon. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kIPAddress @"kIPAddress"        // IP地址，如果空则取宏
#define kIPIdentification @"##%%"       // 识别切换IP的标识


static inline uint64_t CurrentTimeMillis() {
    return (uint64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

@interface DSZTools : NSObject


/**
 *  获取bundle ID
 *  __nullable表示 可以是NULL或nil，__nonnull表示对象不应该为空
 *  @return 设备唯一标识
 */
+ (nonnull NSString *)bundleID;



/**
 *  获取版本号(CFBundleVersion)
 *
 *  @return 版本号
 */
+ (NSInteger )bundleVersion;



/**
 *  软件当前版本号(CFBundleShortVersionString)
 *
 *  @return 版本号
 */
+ (nonnull NSString *)shortVersion;



/**
 *  获取应用名(获取 CFBundleDisplayName-项目显示名, 如果为空则获取 CFBundleName-项目名)
 *
 *  @return 应用名
 */
+ (nonnull NSString *)appName;

/**
 *  获取系统语言判断是否是中文
 *
 *  @return YES 中文 NO 非中文
 */
+ (BOOL)isZHLanguage;


/**
 *  获取当前网络的IP地址
 *
 *  @return IP地址
 */
+ (nullable NSString *)ipAddressWIFI;


/**
 *  截屏操作
 *
 *  @param destImg 截频后的截图
 */
+ (void)windowScreenShot:(UIImage *__nullable *__nullable)destImg;


/**
 *  拨号
 *
 *  @param phone 号码
 */
+ (void)callPhone:(nonnull NSString *)phone;


/**
 *  获取当前屏幕显示的viewcontroller
 *
 */
+ (nonnull UIViewController *)takeCurrentVC;



/**
 *  根据输入的值判断是否切换IP
 *
 *  @param value IP地址
 *
 *  @return YES 切换成功  NO不需要切换
 */
+ (BOOL)ipChange:(nonnull NSString *)value;


/**
 *  获取IP地址
 *
 *  @return IP地址
 */
+ (nonnull NSString *)ipAddress;


/**
 *  URL处理
 *
 *  @param url 其他App发起的URL
 */
+ (void)handleURL:(nullable NSString *)url;


///**
// *  修改JS端服务器IP
// *
// *  @param url URL地址
// */
//+ (void)changeServiceIP2JS:(NSString *)url;

/**
 *  根据文件名读取plist文件的内容
 *
 *  @param fileName 文件名
 *
 *  @return 返回字典类型的数据
 */
+ (nullable NSDictionary *)plistContentWithName:(nonnull NSString *)fileName;


/**
 *  设置 App 样式
 */
+ (void)settingAppStyle;


/**
 *  设置App 导航栏 样式
 *
 *  @param bgColor    导航栏背景色
 *  @param titleColor 导航栏字体颜色
 */
+ (void)settingAppStyle:(nonnull UIColor *)bgColor titleColor:(nonnull UIColor *)titleColor;


/**
 *  判断设备是否有摄像头
 *
 *  @return YES-有 NO-没有
 */
+ (BOOL)hasCamera;

@end


@interface DSZTools (DSZUserDefaults)

/**
 *  设置Key、Value到 NSUserDefaults （有加密）
 *
 *  @param value 值, 非空
 *  @param key   键, 非空
 */
+ (void)setValue:(nullable id)value forKey:(nonnull NSString *)key;


/**
 *  获取 NSUserDefaults 中的值
 *
 *  @param key 键 非空
 *
 *  @return 值 可空
 */
+ (nullable id)objectForKey:(nonnull NSString *)key;

@end


@interface DSZTools (ChannelTools)

/**
 *  分享的地址(文章 地址)
 *
 *  @return
 */
+ (nullable NSString *)shareToPlatFormURL;

/**
 *  App 程序 下载的地址
 *
 *  @return
 */
+ (nullable NSString *)shareAppURL;


/**
 *  渠道资源,用于关于我们页面
 *
 *  @return
 */
+ (nullable NSArray *)channel;

@end


@interface DSZTools (UIViewTools)

/**
 *  根据内容、字体大小、最大尺寸计算出 对应的View大小
 *
 *  @param title 内容
 *  @param font  字体大小
 *  @param size  最大尺寸
 *
 *  @return 显示内容所对应的大小
 */
+ (CGSize)autoCalculateRectWithTitle:(nonnull NSString *)title
                                font:(CGFloat)font
                                size:(CGSize)size;


/**
 *  根据内容、字体大小、最大尺寸、 计算出 对应的View大小
 *
 * NSLineBreakByCharWrapping; 以字符为显示单位显示，后面部分省略不显示。
 NSLineBreakByClipping; 剪切与文本宽度相同的内容长度，后半部分被删除。
 NSLineBreakByTruncatingHead; 前面部分文字以……方式省略，显示尾部文字内容。
 NSLineBreakByTruncatingMiddle; 中间的内容以……方式省略，显示头尾的文字内容。
 NSLineBreakByTruncatingTail; 结尾部分的内容以……方式省略，显示头的文字内容。
 NSLineBreakByWordWrapping; 以单词为显示单位显示，后面部分省略不显示。
 *
 *  @param title 内容
 *  @param font  字体大小
 *  @param size  最大尺寸
 *  @param mode  详见 NSLineBreakMode
 *
 *  @return 显示内容所对应的大小
 */
+ (CGSize)autoCalculateRectWithTitle:(nonnull NSString *)title
                                font:(CGFloat)font
                                size:(CGSize)size
                       lineBreakMode:(NSLineBreakMode)mode;

@end



