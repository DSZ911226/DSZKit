//
//  DSZTabBarController.m
//  DSZ
//  Created by HuHao on 15/4/29.
//  Copyright (c) 2015年 DSZon. All rights reserved.
//

#import "DSZTabBarController.h"

#define kIndex 2        // 未读下标

@interface DSZTabBarController ()

@property (nonatomic, strong) UIImageView *dotImageView;

@end

@implementation DSZTabBarController


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)loadView
{
    [super loadView];
    [self addDotImageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    
    [self checkUnReadCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - 自定义方法

- (void)setDotImageHidden:(BOOL)isHidden
{
    self.dotImageView.hidden = isHidden;
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initData
{
    
}

- (void)checkUnReadCount
{
    BOOL isHas = YES;
    [self setDotImageHidden:!isHas];
}

- (void)addDotImageView
{
    UIView *view = [self.tabBar subviews][kIndex];
    [view addSubview:self.dotImageView];
}

#pragma mark - getting/setting

- (UIImageView *)dotImageView
{
    if (!_dotImageView) {

        float x = 52;
        float scale = [UIScreen mainScreen].scale;
        if (scale == 3) {
            x = 60;
        }

        _dotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 6, 6, 6)];
        _dotImageView.backgroundColor = [UIColor redColor];
        _dotImageView.layer.cornerRadius = 3;
        _dotImageView.hidden = YES;
        _dotImageView.layer.masksToBounds = YES;
    }

    return _dotImageView;
}



@end
