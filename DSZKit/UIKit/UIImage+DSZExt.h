//
//  UIImage+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DSZExt)


/**
 Decompress this image, so when the image is displayed on screen, the main
 thread won't be blocked by additional decode. It will cost more memory.
 If the image is already decoded, or fail to decode, it just return itself.
 
 @return a image decoded, or just return itself if no needed.
 
 @see isImageDecoded
 */
- (UIImage *)imageByDecoded;

/**
 Wherher the image can be display on screen without additional decode.
 
 @see imageByDecoded
 
 @warning It just a hint for your code, change it has no other effect.
 */
@property (nonatomic, assign) BOOL isImageDecoded;


/**
 *  pdf转换成图片
 *
 *  @param dataOrPath 输入pdf 路径
 *
 *  @return 图片
 */
+ (UIImage *)imageWithPDF:(id)dataOrPath;

/**
 *  颜色转换成图片
 *
 *  @param color 颜色值
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 *  根据颜色 跟 图片大小 转换对应的图片
 *
 *  @param color 颜色值
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  根据CGRect、contentMode 画对应的图片
 *
 *  @param rect
 *  @param contentMode
 */
- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;



/**
 Returns a rotated image (relative to the center).
 
 @param radians   Rotated radians in counterclockwise.⟲
 
 @param fitSize   YES: new image's size is extend to fit all content.
 NO: image's size will not change, content may be clipped.
 */
- (UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

/**
 Returns a image rotated counterclockwise by a quarter‑turn (90°). ⤺
 The width and height will be exchanged.
 */
- (UIImage *)imageByRotateLeft90;

/**
 Returns a image rotated clockwise by a quarter‑turn (90°). ⤼
 The width and height will be exchanged.
 */
- (UIImage *)imageByRotateRight90;

/**
 Returns a image rotated 180° . ↻
 */
- (UIImage *)imageByRotate180;

/**
 Returns a vertically flipped image. ⥯
 */
- (UIImage *)imageByFlipVertical;

/**
 Returns a horizontally flipped image. ⇋
 */
- (UIImage *)imageByFlipHorizontal;



#pragma mark - Image Effect
///=============================================================================
/// @name Image Effect
///=============================================================================

/**
 Tint the image in alpha channel with the given color.
 
 @param color  The color.
 */
- (UIImage *)imageByTintColor:(UIColor *)color;

/**
 Returns a grayscaled image.
 */
- (UIImage *)imageByGrayscale;

/**
 Applies a blur effect to this image. Suitable for blur any content.
 */
- (UIImage *)imageByBlurSoft;

/**
 Applies a blur effect to this image. Suitable for blur any content except pure white.
 */
- (UIImage *)imageByBlurLight;

/**
 Applies a blur effect to this image. Suitable for displaying black text.
 */
- (UIImage *)imageByBlurExtraLight;

/**
 Applies a blur effect to this image. Suitable for displaying white text.
 */
- (UIImage *)imageByBlurDark;

/**
 Applies a blur and tint color to this image.
 
 @param tintColor  The tint color.
 */
- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor;


/**
 *  修正图片旋转
 *
 *  @return 修正后的图片
 */
- (UIImage *)fixOrientation;


/**
 *  生成一张圆角图片
 *
 *  @param rect 图片显示的大小
 *  @param radius  圆角弧度
 *
 *  @return 圆角图片
 */
- (UIImage *)roundedImageWithFrame:(CGRect *)rect
                            radius:(NSInteger)radius;


/**
 *  根据指定大小生成图片
 *
 *  @param size 指定大小
 *
 *  @return 图片
 */
- (UIImage *)scaleToSize:(CGSize)size;


/**
 *
 *  图片等比缩放 如果目标 width 大于图片 width, 则以图片 width 为准
 *  如果目标 width 小于图片 width 则以目标 width 为准，height等比缩放
 *  @param width 宽度
 *
 *  @return 图片
 */
- (UIImage *)compressImage:(CGFloat)width;


/**
 图片压缩到指定大小

 @param targetSize 图片尺寸
 @return image
 */
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;


@end
