//
//  DSZAnimationTools.h
//  DSZ
//
//  Created by ccc on 15/12/16.
//  Copyright © 2015年 HH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AnimationCompeletBlock)();

@interface DSZAnimationTools : NSObject
/**
 *  animatin
 *
 *  @param type     kCATransitionFade = 1,      //淡入淡出
                    kCATransitionPush,          //推挤
                    kCATransitionReveal,        //揭开
                    kCATransitionMoveIn,        //覆盖
                    cube,                       //立方体
                    suckEffect,                 //吮吸
                    oglFlip,                    //翻转
                    rippleEffect,               //波纹
                    pageCurl,                   //翻页
                    pageUnCurl,                 //反翻页
                    cameraIrisHollowOpen,       //开镜头
                    cameraIrisHollowClose,      //关镜头
                    curlDown,                   //下翻页
                    curlUp,                     //上翻页
                    flipFromLeft,               //左翻转
                    flipFromRight,              //右翻转
 *  @param subtype  kCATransitionFromLeft;      //从左
                    kCATransitionFromBottom;    //从下
                    kCATransitionFromRight;     //从右
                    kCATransitionFromTop;       //从上
 *  @param duration 历时
 *  @param view     执行动画的view
 */
+ (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype duration:(double)duration forView:(UIView *)view;

+ (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype duration:(double)duration forView:(UIView *)view complete:(AnimationCompeletBlock)completeBlock;

@end
