//
//  DSZViewTools.h
//  DSZ  view的工具类
//
//  Created by 小广 on 15/10/26.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSZViewTools : NSObject

+ (DSZViewTools *)shareInstance;

/**
 *  显示弹出的警告框
 *  @param title   标题
 *  @param content 内容
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertShow:(NSString *)title
              content:(NSString *)content
       viewController:(UIViewController *)viewController
              confirm:(void(^)())confirm;

/**
 *  显示弹出的警告框
 *  @param title   标题
 *  @param content 内容
 *  @param confirmTitle 确认按钮Title
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertShow:(NSString *)title
              content:(NSString *)content
         confirmTitle:(NSString *)confirmTitle
       viewController:(UIViewController *)viewController
              confirm:(void(^)())confirm;

/**
 *  显示弹出的警告框(一个)
 *  @param title   标题
 *  @param content 内容
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertOneChose:(NSString *)title
              content:(NSString *)content
       viewController:(UIViewController *)viewController
              confirm:(void(^)())confirm;


/**
 *  显示弹出的警告框(一个)
 *  @param title   标题
 *  @param content 内容
 *  @param buttonTitle 按钮文字
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertOneChose:(NSString *)title
                  content:(NSString *)content
              buttonTitle:(NSString *)buttonTitle
           viewController:(UIViewController *)viewController
                  confirm:(void(^)())confirm;


/**
 *  显示弹出的警告框(new)
 *  @param title   标题
 *  @param content 内容
 */
+ (void)showAlertShow:(NSString *)title
              content:(NSString *)content
              confirm:(void(^)())confirm;

/**
 *  拨号带弹出框
 *
 *  @param phone 号码
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)callPhoneHasAlert:(NSString *)phone viewController:(UIViewController *)viewController;

/**
 *  拨号带弹出框(new)
 *
 *  @param phone 号码
 */
+ (void)callPhoneHasAlert:(NSString *)phone;



@end
