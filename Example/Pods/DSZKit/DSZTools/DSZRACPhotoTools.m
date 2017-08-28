//
//  DSZRACPhotoTools.m
//  Pods
//
//  Created by ccc's MacBook Pro on 2017/7/6.
//
//

#import "DSZRACPhotoTools.h"
#import "DSZPhotoTools.h"

@interface DSZRACPhotoTools ()

@property (nonatomic, strong, readwrite) UIImage * _Nullable originalImage;
@property (nonatomic, strong, readwrite) NSData * _Nullable imageData;

@end

@implementation DSZRACPhotoTools

SINGLETON_M(DSZRACPhotoTools)

- (RACSignal *_Nullable)takePhotoWithVC:(UIViewController *_Nullable)vc
                          photoSizeType:(PhotoSize)sizeType
                              isPresent:(BOOL)isPresent
                               hasKuang:(BOOL)hasKuang {
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [[DSZPhotoTools shareInstance] takePhotoWithVC:vc photoSizeType:(PhotoSizeType)sizeType isPresent:isPresent hasKuang:hasKuang block:^(UIImage *originalImage, NSData *imageData) {
            @strongify(self)
            self.originalImage = originalImage;
            self.imageData = imageData;
            [subscriber sendNext:RACTuplePack(originalImage, imageData)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return signal;
}

- (RACSignal *_Nullable)takePhotoLibraryWithVC:(UIViewController *_Nullable)vc
                                 photoSizeType:(PhotoSize)sizeType
                                     isPresent:(BOOL)isPresent {
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [[DSZPhotoTools shareInstance] takePhotoLibraryWithVC:vc photoSizeType:(PhotoSizeType)sizeType isPresent:isPresent block:^(UIImage *originalImage, NSData *imageData) {
            self.originalImage = originalImage;
            self.imageData = imageData;
            [subscriber sendNext:RACTuplePack(originalImage, imageData)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return signal;
}

@end
