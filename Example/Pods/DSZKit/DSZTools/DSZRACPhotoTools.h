//
//  DSZRACPhotoTools.h
//  Pods
//
//  Created by ccc's MacBook Pro on 2017/7/6.
//
//

#import <Foundation/Foundation.h>
#import "DSZKitMacro.h"
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, PhotoSize) {
    PhotoSizeSquare,        // 正方形 300 * 300 ?(待定)
    PhotoSizeRectangle      // 矩形   300 * 400 ?(待定)
};

@interface DSZRACPhotoTools : NSObject

SINGLETON_H(DSZRACPhotoTools)

/**
 拍照或选择完成后的图片
 */
@property (nonatomic, strong, readonly) UIImage * _Nullable originalImage;

/**
 拍照或选择完成后的图片的data格式
 */
@property (nonatomic, strong, readonly) NSData * _Nullable imageData;

/**
 进行拍照/选照片操作

 @param vc 控制器
 @param sizeType 照片的size规格
 @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 @param hasKuang 取景框(自定义,手持身份证用到)
 @return 信号类
 */
- (RACSignal *_Nullable)takePhotoWithVC:(UIViewController *_Nullable)vc
                 photoSizeType:(PhotoSize)sizeType
                     isPresent:(BOOL)isPresent
                      hasKuang:(BOOL)hasKuang;


/**
 从相册选取照片

 @param vc 控制器
 @param sizeType 照片的size规格
 @param isPresent 是否之前已经使用过模态(重复模态,会导致打开相册crash)
 @return 信号类
 */
- (RACSignal *_Nullable)takePhotoLibraryWithVC:(UIViewController *_Nullable)vc
                                 photoSizeType:(PhotoSize)sizeType
                                     isPresent:(BOOL)isPresent;

@end
