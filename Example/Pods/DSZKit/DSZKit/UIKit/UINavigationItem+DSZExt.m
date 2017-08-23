//
//  UINavigationItem+DSZExt.m
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "UINavigationItem+DSZExt.h"
#import "DSZKitMacro.h"
#import <objc/runtime.h>

@interface UINavigationItem ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UILabel *titleLabel;

@end

NSString const *UINavigationItem_DSZBgViewKey               = @"UINavigationItem_DSZBgViewKey";
NSString const *UINavigationItem_DSZActivityIndicatorKey    = @"UINavigationItem_DSZActivityIndicatorKey";
NSString const *UINavigationItem_DSZTitleStrKey             = @"UINavigationItem_DSZTitleStrKey";
NSString const *UINavigationItem_DSZTitleLabelKey           = @"UINavigationItem_DSZTitleLabelKey";
@implementation UINavigationItem (DSZExt)


+ (void)setBackButtonNil:(UIViewController*)vc {
    vc.navigationItem.leftBarButtonItem = nil;
}


+ (void)setRightButtonNil:(UIViewController*)vc {
    vc.navigationItem.rightBarButtonItem = nil;
}

// 设置左侧按钮不显示
+ (void)setNoneLeftButton:(UIViewController *)vc {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 42)];
    btn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    vc.navigationItem.leftBarButtonItem = backBtn;
}


+ (void)setLeftButtonOn:(UIViewController *)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel {
    
    UIImage *image = DSZBaseImageName(@"ic_back.png");
    
    [self setLeftButtonOn:vc target:theTarget callbackSelector:sel image:image];
}


+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  image:(UIImage *)image {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, 44)];
//    btn.showsTouchWhenHighlighted = YES;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.leftBarButtonItem = backBtn;
}



+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  image:(UIImage *)image
              highImage:(UIImage *)highImage {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width+10, 40)];
//    btn.showsTouchWhenHighlighted = YES;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    vc.navigationItem.leftBarButtonItem = backBtn;
}



+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    btn.showsTouchWhenHighlighted = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.minimumScaleFactor = 10.f;
    [btn setTitleColor:kNavigationBarTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];

    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.leftBarButtonItem = leftButton;
}



// 设置右侧的按钮
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   image:(UIImage *)image {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width+10, 40)];
//    btn.showsTouchWhenHighlighted = YES;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.rightBarButtonItem = rightBtn;
}


+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    btn.showsTouchWhenHighlighted = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.minimumScaleFactor = 10.f;
    [btn sizeToFit];
    [btn setTitleColor:kNavigationBarTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];

    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    vc.navigationItem.rightBarButtonItem = rightBtn;
}

+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   title:(NSString *)title
                 BGColor:(UIColor*)bgColor {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 22)];
//    btn.showsTouchWhenHighlighted = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kNavigationBarTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    btn.layer.borderColor = [kNavigationBarTitleColor CGColor];
    btn.layer.borderWidth = 1.5f;
    btn.layer.cornerRadius = 4.0f;
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.rightBarButtonItem = rightBtn;
}


// 设置右侧的按钮
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   image:(UIImage *)image
               highImage:(UIImage *)highImage {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width+10, 40)];
//    btn.showsTouchWhenHighlighted = YES;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    vc.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)setTitle:(NSString *)title {
    
    UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
    
    CGSize textSize = [self autoCalculateRectWithTitle:title font:17.0f size:CGSizeMake(DSZScreenWidth, 9999)];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 10.f;

    label.backgroundColor = [UIColor clearColor];
    label.font = font;

    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kNavigationBarTitleColor;
    label.text = title;
    self.titleView = label;
    
    self.titleStr = title;
    
}


- (CGSize)autoCalculateRectWithTitle:(NSString*)title
                                font:(CGFloat)font
                                size:(CGSize)size
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

#pragma mark - 自定义方法

- (void)startAnimating:(NSString *)msg {
    
    //自定义title
    NSString *titleMsg = msg ? msg : self.titleStr;
    
    //计算titleLabel宽度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,nil];
    CGSize actualsize = [titleMsg boundingRectWithSize:CGSizeMake(280,40) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    
    //自定义titleView
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, actualsize.width + 25, 40)];
    self.titleView = titleBgView;
    
    self.bgView.frame = CGRectMake(0, 0, actualsize.width + 25, 40);
    self.bgView.center = titleBgView.center;
    [titleBgView addSubview:self.bgView];
    
    //菊花开始旋转
    [self.activityIndicator startAnimating];
    
    //设置标题label
    self.titleLabel.frame = CGRectMake(25, 0, actualsize.width, 40);
    self.titleLabel.text = titleMsg;
    [self.bgView addSubview:self.titleLabel];
    
}

- (void)stopAnimating {
    
    kWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //菊花停止旋转
        [weakSelf.activityIndicator stopAnimating];
        
        CGPoint point = weakSelf.bgView.center;
        
        //计算titleLabel宽度
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,nil];
        CGSize actualsize = [weakSelf.titleStr boundingRectWithSize:CGSizeMake(280,40) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
        weakSelf.bgView.frame = CGRectMake(0, 0, actualsize.width, 40);
        weakSelf.bgView.center = point;
        weakSelf.titleLabel.text = weakSelf.titleStr;
        weakSelf.titleLabel.frame = CGRectMake(0, 0, actualsize.width, 40);
    });
}

#pragma mark - setters/getters

- (UIView *)bgView {
    UIView *bgView = objc_getAssociatedObject(self, &UINavigationItem_DSZBgViewKey);
    if(!bgView) {
        bgView = [[UIView alloc] init];
        [self setBgView:bgView];
    }
    return bgView;
}

- (void)setBgView:(UIView *)bgView {
    objc_setAssociatedObject(self, &UINavigationItem_DSZBgViewKey, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)activityIndicator {
    UIActivityIndicatorView *activityIndicator = objc_getAssociatedObject(self, &UINavigationItem_DSZActivityIndicatorKey);
    if(!activityIndicator) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.center = CGPointMake(10.0f, 20.0f);
        activityIndicator.color = [UIColor whiteColor];
        [self.bgView addSubview:activityIndicator];
        [self setActivityIndicator:activityIndicator];
    }
    return activityIndicator;
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    objc_setAssociatedObject(self, &UINavigationItem_DSZActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)titleStr {
    NSString *titleStr = objc_getAssociatedObject(self, &UINavigationItem_DSZTitleStrKey);
    if (!titleStr) {
        titleStr = self.title;
        [self setTitleStr:titleStr];
    }
    return titleStr;
}

- (void)setTitleStr:(NSString *)titleStr {
    objc_setAssociatedObject(self, &UINavigationItem_DSZTitleStrKey, titleStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)titleLabel {
    UILabel *titleLabel = objc_getAssociatedObject(self, &UINavigationItem_DSZTitleLabelKey);
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleLabel:titleLabel];
    }
    return titleLabel;
}

- (void)setTitleLabel:(UILabel *)titleLabel {
    objc_setAssociatedObject(self, &UINavigationItem_DSZTitleLabelKey, titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
