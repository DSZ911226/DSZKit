//
//  QRCreatViewController.h
//  ls
//
//  Created by Alonezzz on 2017/6/19.
//  Copyright © 2017年 浙江智旅信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DSZQRSrcName(file) [@"QRCode.bundle" stringByAppendingPathComponent:file]
#define DSZQRFrameworkSrcName(file) [@"QRCode.bundle" stringByAppendingPathComponent:file]

#define DSZQRImageName(file) [UIImage imageNamed:DSZQRSrcName(file)] ?: [UIImage imageNamed:DSZQRFrameworkSrcName(file)];
@interface QRCreatViewController : UIViewController
@end
