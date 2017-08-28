//
//  DSZAnimationTools.m
//  DSZ
//
//  Created by ccc on 15/12/16.
//  Copyright © 2015年 HH. All rights reserved.
//

#import "DSZAnimationTools.h"

@implementation DSZAnimationTools

+ (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype duration:(double)duration forView:(UIView *)view {
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = duration;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

+ (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype duration:(double)duration forView:(UIView *)view complete:(AnimationCompeletBlock)completeBlock
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = duration;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completeBlock();
    });
}

@end
