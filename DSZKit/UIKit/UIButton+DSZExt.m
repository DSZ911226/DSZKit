//
//  UIButton+DSZExt.m
//  DSZ
//
//  Created by 小广 on 15/11/24.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "UIButton+DSZExt.h"
#import <objc/runtime.h> // 必须导入

#define WeakSelf __weak __typeof(self)weakSelf = self;
#define StrongSelf __strong __typeof(weakSelf)strongSelf = weakSelf;



@implementation UIButton (DSZExt)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdge:(CGFloat)size{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

// 按钮禁用一段时间后 再启用
- (void)disableButton:(NSInteger)time block:(TimerCancel)block {
    __block NSInteger timeout = time; // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t p_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(p_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    WeakSelf
    dispatch_source_set_event_handler(p_timer, ^{
        // 倒计时结束，关闭
        if (timeout <= 0) {
            dispatch_source_cancel(p_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                weakSelf.userInteractionEnabled = YES;
                if (block) {
                    block(p_timer);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(p_timer);
}

- (void)disableButton:(NSInteger)time timeBlock:(TimerBlock)block {
    __block NSInteger timeout = time; // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t p_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(p_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    WeakSelf
    dispatch_source_set_event_handler(p_timer, ^{
        // 倒计时结束，关闭
        if (timeout <= 0) {
            dispatch_source_cancel(p_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                weakSelf.userInteractionEnabled = YES;
                if (block) {
                    block(p_timer,timeout);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.userInteractionEnabled = NO;
                if (block) {
                    block(p_timer,timeout);
                }
            });
            timeout--;
        }
    });
    
    dispatch_resume(p_timer);
}

@end

NSString const *UIButton_DSZBadgeKey = @"UIButton_DSZBadgeKey";

NSString const *UIButton_DSZBadgeBGColorKey = @"UIButton_DSZBadgeBGColorKey";
NSString const *UIButton_DSZBadgeTextColorKey = @"UIButton_DSZBadgeTextColorKey";
NSString const *UIButton_DSZBadgeFontKey = @"UIButton_DSZBadgeFontKey";
NSString const *UIButton_DSZBadgePaddingKey = @"UIButton_DSZBadgePaddingKey";
NSString const *UIButton_DSZBadgeMinSizeKey = @"UIButton_DSZBadgeMinSizeKey";
NSString const *UIButton_DSZBadgeOriginXKey = @"UIButton_DSZBadgeOriginXKey";
NSString const *UIButton_DSZBadgeOriginYKey = @"UIButton_DSZBadgeOriginYKey";
NSString const *UIButton_DSZShouldHideBadgeAtZeroKey = @"UIButton_DSZShouldHideBadgeAtZeroKey";
NSString const *UIButton_DSZShouldAnimateBadgeKey = @"UIButton_DSZShouldAnimateBadgeKey";
NSString const *UIButton_DSZBadgeValueKey = @"UIButton_DSZBadgeValueKey";

@implementation UIButton (DSZBadge)

@dynamic badgeValue, badgeBGColor, badgeTextColor, badgeFont;
@dynamic badgePadding, badgeMinSize, badgeOriginX, badgeOriginY;
@dynamic shouldHideBadgeAtZero, shouldAnimateBadge;

- (void)badgeInit
{
    // Default design initialization
    self.badgeBGColor   = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont      = [UIFont systemFontOfSize:12.0];
    self.badgePadding   = 6;
    self.badgeMinSize   = 8;
    self.badgeOriginX   = self.frame.size.width - self.badge.frame.size.width/2;
    self.badgeOriginY   = -4;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)refreshBadge
{
    // Change new attributes
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

- (CGSize) badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.badgeMinSize) ? self.badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.badge.layer.masksToBounds = YES;
}

// Handle the badge changing value
- (void)updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.badge.text = self.badgeValue;
    
    // Animate the size modification if needed
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*) badge {
    return objc_getAssociatedObject(self, &UIButton_DSZBadgeKey);
}
-(void)setBadge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &UIButton_DSZBadgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)badgeValue {
    return objc_getAssociatedObject(self, &UIButton_DSZBadgeValueKey);
}
-(void) setBadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &UIButton_DSZBadgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.badge) {
        // Create a new badge because not existing
        self.badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        self.badge.textColor            = self.badgeTextColor;
        self.badge.backgroundColor      = self.badgeBGColor;
        self.badge.font                 = self.badgeFont;
        self.badge.textAlignment        = NSTextAlignmentCenter;
        [self badgeInit];
        [self addSubview:self.badge];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &UIButton_DSZBadgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &UIButton_DSZBadgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

// Badge text color
-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &UIButton_DSZBadgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &UIButton_DSZBadgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

// Badge font
-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &UIButton_DSZBadgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &UIButton_DSZBadgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_DSZBadgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &UIButton_DSZBadgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_DSZBadgeMinSizeKey);
    return number.floatValue;
}
-(void) setBadgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &UIButton_DSZBadgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_DSZBadgeOriginXKey);
    return number.floatValue;
}
-(void) setBadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &UIButton_DSZBadgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_DSZBadgeOriginYKey);
    return number.floatValue;
}
-(void) setBadgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &UIButton_DSZBadgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_DSZShouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIButton_DSZShouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_DSZShouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIButton_DSZShouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
