//
//  DSZPhoto.h
//  DSZ 拍照控件
//
//  Created by HuHao on 15/10/15.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PhotoSizeType) {
    PhotoSizeTypeSquare,        // 正方形 300 * 300 ?(待定)
    PhotoSizeTypeRectangle      // 矩形   300 * 400 ?(待定)
};

typedef void (^TakePhotoCallBack)(UIImage *originalImage, NSData *imageData);

@interface DSZPhotoTools : NSObject

/**
 *  单例
 */
+ (DSZPhotoTools *)shareInstance;

/**
*  进行拍照/选照片操作
*
*  @param vc
*  @param sizeType  照片的size规格
*  @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
*  @param hasKuang  取景框(自定义,手持身份证用到)
*  @param block     拍完照后回调方法
*/
- (void)takePhotoWithVC:(UIViewController *)vc
          photoSizeType:(PhotoSizeType)sizeType
              isPresent:(BOOL)isPresent
               hasKuang:(BOOL)hasKuang
                  block:(TakePhotoCallBack)block;


/**
 *  从相册选照片操作
 *
 *  @param vc
 *  @param sizeType  照片的size规格
 *  @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 *  @param block 拍完照后回调方法
 */
- (void)takePhotoLibraryWithVC:(UIViewController *)vc
                 photoSizeType:(PhotoSizeType)sizeType
                     isPresent:(BOOL)isPresent
                         block:(TakePhotoCallBack)block;


@end
