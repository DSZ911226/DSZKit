//
//  UIButton+DSZExt.h
//  DSZ 
//
//  Created by 小广 on 15/11/24.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TimerBlock) (dispatch_source_t timer, NSInteger time);

typedef void (^TimerCancel) (dispatch_source_t timer);

@interface UIButton (DSZExt)

- (void)setEnlargeEdge:(CGFloat)size;///< 设置按钮扩大响应区域的范围

/**
 * @brief 详细设置按钮扩大响应区域的范围
 *
 * @param top         按钮上方扩展的范围
 * @param right       按钮右方扩展的范围
 * @param bottom      按钮下方扩展的范围
 * @param left        按钮左方扩展的范围
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;

/**
 按钮禁用一段时间后 再启用,只返回timer

 @param time 时间单位s
 @param block 回调
 */
- (void)disableButton:(NSInteger)time block:(TimerCancel)block;

/**
 按钮禁用一段时间后 再启用,返回timer和秒数

 @param time 时间单位s
 @param block 回调
 */
- (void)disableButton:(NSInteger)time timeBlock:(TimerBlock)block;

@end


@interface UIButton (DSZBadge)

@property (strong, nonatomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;

@end
