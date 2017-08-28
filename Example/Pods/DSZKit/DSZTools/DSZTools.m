//
//  DSZTools.m
//  DSZ
//
//  Created by HuHao on 15/9/28.
//  Copyright © 2015年 DSZon. All rights reserved.
//

#import "DSZTools.h"
#import <CommonCrypto/CommonCryptor.h>
#import "UIDevice+DSZExt.h"
#import "DSZKitMacro.h"
#import "UIImage+DSZExt.h"
#import "UIViewController+DSZExt.h"
#import "DSZViewTools.h"

@interface DSZTools ()

@property (nonatomic, assign)BOOL callPhoneEnable;

@end

@implementation DSZTools

+ (DSZTools *)shareInstance {
    static DSZTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}

+ (NSString *)bundleID {
    NSString *identifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];

    if (identifier.length == 0) {
        return @"";
    }
    return identifier;
}



+ (NSInteger)bundleVersion {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return version.integerValue;
}


+ (NSString *)shortVersion {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return version;
}


+ (NSString *)appName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];

    if (!appName) {
        appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return appName;
}

+ (NSString *)ipAddressWIFI {
    return [[UIDevice currentDevice] ipAddressWIFI];
}


+ (BOOL)isZHLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];

    return [currentLanguage rangeOfString:@"zh"].length > 0;
}


+ (void)handleURL:(NSString *)url {
    NSString *ipIdentifi = @"connecttcpay:";
    
    if ([url hasPrefix:ipIdentifi]) {
        NSString *ipAddress = [url substringFromIndex:ipIdentifi.length];
        [self setValue:ipAddress forKey:kIPAddress];
    }
}

//// 修改JS端IP
//+ (void)changeServiceIP2JS:(NSString *)url {
//  NSString *ipIdentifi = @"connecttcpay:";
//  if ([url hasPrefix:ipIdentifi]) {
//    NSString *ipAddress = [url substringFromIndex:ipIdentifi.length];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeIP object:ipAddress];
//  }
//}

+ (BOOL)ipChange:(NSString *)value {
    NSString *userName = value;
    
    BOOL isChangeIP = [userName hasSuffix:kIPIdentification];
    if (isChangeIP) {
        userName = [userName stringByReplacingOccurrencesOfString:kIPIdentification withString:@""];
        [self setValue:userName forKey:kIPAddress];
        return YES;
    }
    
    return NO;
}

+ (NSString *)ipAddress {
    return [self ipAddress:nil];
}


+ (NSString *)ipAddress:(NSString *)predefineIP {
    NSString *ip = [self objectForKey:kIPAddress];
    if (ip.length == 0) {
        return predefineIP;
    }
    return ip;
}


+ (void)windowScreenShot:(UIImage **)destImg {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(window.frame.size, YES, 0.0);
    
    // 将cutView的图层渲染到上下文中
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    *destImg = UIGraphicsGetImageFromCurrentImageContext(); // 取出UIImage
    UIGraphicsEndImageContext();    // 千万记得,结束上下文
}


+ (NSDictionary *)plistContentWithName:(NSString *)fileName {
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:pathFile];
    return dic;
}


+ (void)settingAppStyle {
//  if (iOSVersion >= 8) {
//    [[UINavigationBar appearance] setTranslucent:NO];
//  }
//  
//  UIImage *image = [UIImage imageWithColor:kNavigationBarColor];
//  [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//  
//  NSDictionary *attributes = @{NSForegroundColorAttributeName:kNavigationBarTitleColor, NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]};
//  [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}


+ (void)settingAppStyle:(UIColor *)bgColor titleColor:(UIColor *)titleColor {
    if (iOSVersion >= 8) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }

    UIImage *image = [UIImage imageWithColor:bgColor];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:titleColor, NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}


+ (void)callPhone:(NSString *)phone {

    if (![UIApplication instancesRespondToSelector:@selector(canOpenURL:)]) {
        NSString *errorStr= [NSString stringWithFormat:@"无法拨号 %@", phone];
        DSZLog(@"%@", errorStr)
        return;
    }

    NSString *telNumber = [NSString stringWithFormat:@"tel:%@",phone];
    NSURL *aURL = [NSURL URLWithString:telNumber];

    if (![[UIApplication sharedApplication] canOpenURL:aURL]) {
        NSString *errorStr= [NSString stringWithFormat:@"无法拨号 %@", phone];
        DSZLog(@"%@", errorStr)
        return;
    }
    
    if (iOSVersion > 10.2) {
        if ([[DSZTools shareInstance] callPhoneEnable]) {
            return;
        }
        [DSZTools shareInstance].callPhoneEnable = YES;
        //[[UIApplication sharedApplication] openURL:aURL];
        [[UIApplication sharedApplication] openURL:aURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success) {
            [DSZTools shareInstance].callPhoneEnable = NO;;
        }];
    } else {
        [DSZViewTools showAlertShow:nil
                            content:phone
                       confirmTitle:@"呼叫"
                     viewController:[UIViewController lastViewController]
                            confirm:^{
                [[UIApplication sharedApplication] openURL:aURL];
        }];
    }

}


+ (UIViewController *)takeCurrentVC {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window.rootViewController;
}



+ (BOOL)hasCamera {
  return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

@end


@implementation DSZTools (DSZUserDefaults)

+ (void)setValue:(id)value forKey:(NSString *)key {
    if (!value || key.length == 0) {
        DSZLog(@"value or key is nil");
        DAssert(0);
        return;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (id)objectForKey:(NSString *)key {
    if (key.length == 0) {
        DSZLog(@"key is nil");
        DAssert(0);
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return ISNIL([defaults objectForKey:key]);
}



@end


@implementation DSZTools (ChannelTools)

#define kKLShareToPlatFormUrl @"KLShareToPlatFormUrl"
#define kKLShareNet @"KLShareNet"
#define kKLChannel @"KLChannel"

+ (NSString *) shareToPlatFormURL {
  NSString *url = nil;
  
  NSDictionary *dic = [self channelFile];
  if (dic) {
    url = dic[kKLShareToPlatFormUrl];
  }
  
  return url;
}

+ (NSString *)shareAppURL {
  NSString *url = nil;
  
  NSDictionary *dic = [self channelFile];
  if (dic) {
    url = dic[kKLShareNet];
  }
  
  return url;
}


+ (NSArray *)channel {
  NSDictionary *dic = [self channelFile];
  NSArray *channel = dic[kKLChannel];
  return channel;
}


+ (NSDictionary *)channelFile {
  NSDictionary *dic = [self plistContentWithName:@"channel"];
  return dic;
}

@end


@implementation DSZTools (UIViewTools)

+ (CGSize)autoCalculateRectWithTitle:(NSString*)title font:(CGFloat)font size:(CGSize)size;
{
  NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
  paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
  NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                               NSParagraphStyleAttributeName:paragraphStyle.copy};
  
  CGSize labelSize = [title boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
  labelSize.height = ceil(labelSize.height);
  labelSize.width = ceil(labelSize.width);
  return labelSize;
}


+ (CGSize)autoCalculateRectWithTitle:(NSString*)title
                                font:(CGFloat)font
                                size:(CGSize)size
                       lineBreakMode:(NSLineBreakMode)mode
{
  NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
  paragraphStyle.lineBreakMode = mode;
  NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                               NSParagraphStyleAttributeName:paragraphStyle.copy};
  
  CGSize labelSize = [title boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
  labelSize.height = ceil(labelSize.height);
  labelSize.width = ceil(labelSize.width);
  return labelSize;
}




@end

