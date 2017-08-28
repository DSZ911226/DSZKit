//
//  DSZPhoto.m
//  DSZ 拍照控件
//
//  Created by HuHao on 15/10/15.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZPhotoTools.h"
#import "DSZViewTools.h"
#import "DSZTools.h"
#import "DSZKitMacro.h"

@interface DSZPhotoTools () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, copy) TakePhotoCallBack   block;
@property (nonatomic, assign) BOOL              isPresent;
@property (nonatomic, assign) BOOL              hasKuang;
@property (nonatomic, assign) PhotoSizeType     sizeType;

@end

@implementation DSZPhotoTools

#pragma mark - 自定义方法

// 单例
+ (DSZPhotoTools *)shareInstance {
    
    static DSZPhotoTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[DSZPhotoTools alloc] init];
    });
    return tools;
}

- (void)takePhotoWithVC:(UIViewController *)vc
          photoSizeType:(PhotoSizeType)sizeType
              isPresent:(BOOL)isPresent
               hasKuang:(BOOL)hasKuang
                  block:(TakePhotoCallBack)block {
    
    self.viewController = vc;
    self.block = block;
    self.isPresent = isPresent;
    self.sizeType = sizeType;
    self.hasKuang = hasKuang;

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    //actionSheet.actionSheetStyle = UIBarStyleDefault;
    [actionSheet showInView:vc.view];
}



- (void)takePhotoLibraryWithVC:(UIViewController *)vc
                 photoSizeType:(PhotoSizeType)sizeType
                     isPresent:(BOOL)isPresent
                         block:(TakePhotoCallBack)block {
    self.viewController = vc;
    self.block = block;
    self.isPresent = isPresent;
    self.sizeType = sizeType;
    
    [self photo:UIImagePickerControllerSourceTypePhotoLibrary];
}


#pragma mark -- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0 && [DSZTools hasCamera]) {
        [self photo:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {
        [self photo:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void)photo:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = type;
    //picker.allowsEditing = YES; // 打开图像编辑功能
    picker.delegate = self;
    
    kWeakSelf
    [self.viewController presentViewController:picker animated:YES completion:^{
        if (weakSelf.hasKuang && type == UIImagePickerControllerSourceTypeCamera) {
            // 手持照片 加两个框
            UIImage *kuangImage = [UIImage imageNamed:@"手持身份证拍照"];
            UIImageView *kuangImageView = [[UIImageView alloc] initWithImage:kuangImage];
            kuangImageView.backgroundColor = [UIColor clearColor];
            kuangImageView.center = CGPointMake(picker.view.center.x, picker.view.center.y -40.0);
            [picker.view addSubview:kuangImageView];
        }
        
    }];
    
    if (!self.isPresent) {
        [self.viewController.view addSubview:picker.view];
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
    [self manageImage:info];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self manageImage:editingInfo];
}

- (void)manageImage:(NSDictionary *)info {
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *editImage = nil;
    
    CGFloat  width = 0.0;
    CGFloat  height = 0.0;
    if (self.sizeType == PhotoSizeTypeSquare) {
        width = 300;
        height = 300;
    }else {
        width = 400;
        height = 300;
    }
    
    editImage = originalImage;
    //CGRect rect = CGRectMake(0, 0, width, height);
    //editImage = [self scaleImage:originalImage toScale:rect];
    
    DSZLog(@"editImage width===== %f, editImage height ====== %f", editImage.size.width, editImage.size.height)
    
    NSData *data = nil;//
    if (UIImagePNGRepresentation(editImage)) {
        data = UIImagePNGRepresentation(editImage);
    } else {
        data = UIImageJPEGRepresentation(editImage, 1.0);
    }
    DSZLog(@"data===%@===",data);
    
    
    if(self.block) {
        self.block(originalImage, data);
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 压缩图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(CGRect)rect {
    
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


@end
