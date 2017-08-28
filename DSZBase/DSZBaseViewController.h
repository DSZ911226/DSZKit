//
//  DSZBaseViewController.h
//  DSZ
//  Created by HuHao on 15/3/19.
//  Copyright (c) 2015年 DSZon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZBaseViewController : UIViewController {
    
}

/**
 用于记录页面日志
 */
@property (nonatomic, copy) NSString *logFileTitle;

/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param image     显示的图片
 *  @param highImage 高亮显示的图片
 */
- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image
             highImage:(UIImage *)highImage;

/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param image     显示的图片
 */
- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image;


/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param title     按钮文字
 */
- (void)addRightButton:(SEL)selector
                 title:(NSString *)title;


/**
 *  添加导航栏标题
 *
 *  @param title 标题内容
 */
- (void)setNavigationTitle:(NSString *)title;


/**
 *  添加返回按钮
 */
- (void)addBackButton;


/**
 *  添加左侧带文字的按钮
 *
 *  @param selector 回调方法
 *  @param title    按钮上显示的文字
 */
- (void)addLeftButton:(SEL)selector
                title:(NSString *)title;

/**
 *  添加左侧带默认图片的按钮
 *
 *  @param selector 回调方法
 */
- (void)addLeftButton:(SEL)selector;

/**
 *  添加左侧带自定义图片的按钮
 *
 *  @param selector 回调方法
 *  @param image    自定义图片
 */
- (void)addLeftButton:(SEL)selector
                image:(UIImage *)image;


/**
 *  隐藏左侧按钮
 */
- (void)hideLeftButton;



@end
