//
//  DSZBaseViewController.m
//  DSZ
//  Created by HuHao on 15/3/19.
//  Copyright (c) 2015年 DSZ. All rights reserved.
//

#import "DSZBaseViewController.h"
#import "UINavigationItem+DSZExt.h"
#import "UINavigationController+DSZExt.h"
#import "DSZKitMacro.h"
#import "DSZKit.h"


@interface DSZBaseViewController ()

@end

@implementation DSZBaseViewController


#pragma mark - 生命周期方法


- (void)dealloc {
    DSZLog(@"%@对象已销毁", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.navigationController.viewControllers.count > 1) {
        [self addBackButton];
    }
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //用于日志记录
//    if (self.title.length == 0) {
//        DSZFileLog(@"%@", Page, ISNIL(self.logFileTitle));//(@"%@", ISNIL(self.logFileTitle));
//        return;
//    }
//    DSZFileLog(@"%@", Page, ISNIL(self.title));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    DSZLog(@"内存不足")
}


#pragma mark - 自定义方法

- (void)back:(id)sender {
    // 修复 模态页面push到新页面时 点击返回按钮的bug
    if(self.presentingViewController && self.DSZ_navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dismissBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}


- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image
             highImage:(UIImage *)highImage {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 image:image
                             highImage:highImage];
}


- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 image:image];
}


- (void)addRightButton:(SEL)selector
                 title:(NSString *)title {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 title:title];
}

- (void)addBackButton {
    [UINavigationItem setLeftButtonOn:self target:self callbackSelector:@selector(back:)];
}


- (void)addLeftButton:(SEL)selector
                title:(NSString *)title {
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector
                                title:title];
}

- (void)addLeftButton:(SEL)selector
                image:(UIImage *)image{
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector
                                image:image];
}

- (void)addLeftButton:(SEL)selector {
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector];
}

- (void)hideLeftButton {
    [UINavigationItem setNoneLeftButton:self];
}




@end
