//
//  ViewController.m
//  Demo
//
//  Created by zhilvmac on 2017/8/23.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableVIewController.h"
#import <DSZKitMacro.h>
#import <DSZRACPhotoTools.h>
#import "Firstmodel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(id)sender {
    
    //
    FirstTableVIewController *VC = [FirstTableVIewController new];
    [self presentViewController:VC animated:YES completion:nil];
    
}


@end
