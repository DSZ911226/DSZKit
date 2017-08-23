//
//  UIView+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 same as NSMakeRange()
 */
static inline NSRange NSRangeMake(NSUInteger location, NSUInteger length) {
    NSRange r;
    r.location = location;
    r.length = length;
    return r;
}

/**
 Ceil the rect (for string drawing calculate)
 */
static inline CGRect CGRectCeil(CGRect rect) {
    return CGRectMake(ceil(rect.origin.x), ceil(rect.origin.y), ceil(rect.size.width), ceil(rect.size.height));
}

/**
 Ceil the size (for string drawing calculate)
 */
static inline CGSize CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/**
 The Center of this rect.
 */
static inline CGPoint CGRectCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}


static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}


@interface UIView (DSZExt)


/**添加圆角*/
- (void)addCorners:(CGFloat)radius;

/**添加部分圆角*/
- (void)addCorners:(CGFloat)radius rectCorners:(UIRectCorner)rectCorners;

/**添加边框*/
- (void)addBorder:(CGFloat)width color:(UIColor *)color;


/**
 Create a snapshot image of the complete view hierarchy.
 This method should be called in main thread.
 */
- (UIImage *)snapshotImage;

/**
 Create a snapshot PDF of the complete view hierarchy.
 This method should be called in main thread.
 */
- (NSData *)snapshotPDF;

/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)removeAllSubviews;


/**
 * 给矩形view添加圆角
 * view           要改变的view
 * corners        要改变的圆角的位置(左上,左下,右上,右下,可用 | 多选)
 * cornerRadii    圆角的大小
 */
- (void)setRoundedRectWithView:(UIView *)view
               roundingCorners:(UIRectCorner)corners
                   cornerRadii:(CGSize)cornerRadii;

/**
 Returns the view's view controller (may be nil).
 */
@property (nonatomic, readonly) UIViewController *viewController;

@property (nonatomic) CGFloat left;    ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;     ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;   ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;  ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;   ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;  ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX; ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY; ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;  ///< Shortcut for frame.origin.
@property (nonatomic) CGSize size;     ///< Shortcut for frame.size.
@property (nonatomic, readonly) CGRect screenFrame; ///< View frame on the screen, taking into account scroll views.



/**
 *  获取当前 View 的 Nib
 *
 *  @return Nib
 */
+ (UINib *)loadNib;

/**
 *  根据 NibName 获取对应的 Nib
 *
 *  @param nibName
 *
 *  @return Nib
 */
+ (UINib *)loadNibNamed:(NSString*)nibName;

/**
 *  根据 NibName bundle 获取对应的 Nib
 *
 *  @param nibName
 *  @param bundle
 *
 *  @return Nib
 */
+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;


/**
 *  根据当前类同名的 Nib 获取 当前类实例
 *
 *  @return 当前类实例
 */
+ (instancetype)loadInstanceFromNib;


+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName;


+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;


+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName
                                      owner:(id)owner
                                     bundle:(NSBundle *)bundle;


@end
