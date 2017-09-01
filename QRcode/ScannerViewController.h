//
//  ScannerViewController.h
//  ZXingObjCTest
//
//  Created by 董禹 on 14-3-23.
//  Copyright (c) 2014年 董禹. All rights reserved.
//

#import <ZXingObjC.h>
#import <UIKit/UIKit.h>


// 图片路径
#define DSZQRSrcName(file) [@"QRCode.bundle" stringByAppendingPathComponent:file]
#define DSZQRFrameworkSrcName(file) [@"QRCode.bundle" stringByAppendingPathComponent:file]

#define DSZQRImageName(file) [UIImage imageNamed:DSZQRSrcName(file)] ?: [UIImage imageNamed:DSZQRFrameworkSrcName(file)];
@interface ScannerViewController : UIViewController<ZXCaptureDelegate>
@end
//Frameworks/BWTKit.framework/
