//
//  UILabel+DSZExt
//
//  Created by LYB on 16/7/1.
//  Copyright © 2016年 zjwist. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSZAttributeTapActionDelegate <NSObject>
@optional
/**
 *  DSZAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)DSZ_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface YBAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end



@interface UILabel (DSZExt)

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)DSZ_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)DSZ_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <DSZAttributeTapActionDelegate> )delegate;

/**
 *  @brief  同意Label显示不同颜色不同大小字的处理
 *  @category
 *	@param 	wholeString         整体字符串
 *	@param 	targetString        要改变颜色的字符串
 *	@param 	color               要设置的颜色
 *	@param 	font                字号
 **/
+ (NSMutableAttributedString *)wholeString:(NSString *)wholeString
                              targetString:(NSString *)targetString
                                     color:(UIColor *)color
                                      font:(UIFont *)font;

@end

