//
//  DSZViewTools.m
//  DSZ  view的工具类
//
//  Created by 小广 on 15/10/26.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZViewTools.h"
#import "UIAlertView+DSZExt.h"
#import "DSZKitMacro.h"
#import "DSZTools.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow

@interface DSZViewTools ()<UIActionSheetDelegate>

@end
@implementation DSZViewTools

+ (DSZViewTools *)shareInstance {
    static DSZViewTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[super allocWithZone:NULL] init];
    });
    return tools;
}

// 显示弹出的警告框
+ (void)showAlertShow:(NSString *)title
              content:(NSString *)content
       viewController:(UIViewController *)viewController
              confirm:(void(^)())confirm {
    [self showAlertShow:title
                content:content
           confirmTitle:@"确定"
         viewController:viewController confirm:^{
        if (confirm) {
            confirm();
        }
    }];
}

/**
 *  显示弹出的警告框
 *  @param title   标题
 *  @param content 内容
 *  @param confirmTitle 确认按钮Title
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertShow:(NSString *)title
              content:(NSString *)content
         confirmTitle:(NSString *)confirmTitle
       viewController:(UIViewController *)viewController
              confirm:(void(^)())confirm {
    [self showAlertView:title content:content confirmTitle:confirmTitle isOne:NO confirm:^{
        if (confirm) {
            confirm();
        }
    }];
//    return;
//    
//    // 外部无传进viewController
//    if (!viewController) {
//        [self showAlertView:title content:content confirmTitle:confirmTitle isOne:NO confirm:^{
//            if (confirm) {
//                confirm();
//            }
//        }];
//        return;
//    }
//    
//    // 外部传进viewController
//    
//    if (IOS7) {
//        
//        [self showAlertView:title content:content confirmTitle:confirmTitle isOne:NO confirm:^{
//            if (confirm) {
//                confirm();
//            }
//        }];
//        
//    }else {
//        
//        [self showAlertController:title
//                          content:content
//                     confirmTitle:confirmTitle
//                            isOne:NO
//                   viewController:viewController
//                          confirm:^{
//                              
//                              if (confirm) {
//                                  confirm();
//                              }
//                          }];
//    }
}

/**
 *  显示弹出的警告框(只有一个确定按钮)
 *  @param title   标题
 *  @param content 内容
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertOneChose:(NSString *)title
                  content:(NSString *)content
           viewController:(UIViewController *)viewController
                  confirm:(void(^)())confirm {
    
    // 外部无传进viewController
    if (!viewController) {
        [self showAlertView:title content:content confirmTitle:@"确定" isOne:YES confirm:^{
            if (confirm) {
                confirm();
            }
        }];
        return;
    }
    
    // 外部传进viewController
    
    if (IOS7) {
        
        [self showAlertView:title content:content confirmTitle:@"确定" isOne:YES confirm:^{
            if (confirm) {
                confirm();
            }
        }];
        
    }else {
        
        [self showAlertController:title content:content confirmTitle:@"确定" isOne:YES
                   viewController:viewController
                          confirm:^{
                              
                              if (confirm) {
                                  confirm();
                              }
                          }];
    }

    
}


/**
 *  显示弹出的警告框(只有一个确定按钮)
 *  @param title   标题
 *  @param content 内容
 *  @param viewController 显示alert的控制器(iOS8及其以上会用到)
 */
+ (void)showAlertOneChose:(NSString *)title
                  content:(NSString *)content
              buttonTitle:(NSString *)buttonTitle
           viewController:(UIViewController *)viewController
                  confirm:(void(^)())confirm {
    
    if (!buttonTitle) {
        buttonTitle = @"确定";
    }
    
    // 外部无传进viewController
    if (!viewController) {
        [self showAlertView:title content:content confirmTitle:buttonTitle isOne:YES confirm:^{
            if (confirm) {
                confirm();
            }
        }];
        return;
    }
    
    // 外部传进viewController
    
    if (IOS7) {
        
        [self showAlertView:title content:content confirmTitle:buttonTitle isOne:YES confirm:^{
            if (confirm) {
                confirm();
            }
        }];
        
    }else {
        
        [self showAlertController:title content:content confirmTitle:buttonTitle isOne:YES
                   viewController:viewController
                          confirm:^{
                              
                              if (confirm) {
                                  confirm();
                              }
                          }];
    }
    
    
}



// 显示弹出的警告框 new
+ (void)showAlertShow:(NSString *)title
              content:(NSString *)content
              confirm:(void(^)())confirm {
    [self showAlertView:title content:content confirmTitle:@"确定" isOne:NO confirm:^{
        if (confirm) {
            confirm();
        }
    }];
    
    return;
    
    if (IOS7) {
        [self showAlertView:title content:content confirmTitle:@"确定" isOne:NO confirm:^{
            if (confirm) {
                confirm();
            }
        }];
        
    } else {
        
        [self showAlertController:title
                          content:content
                     confirmTitle:@"确定"
                            isOne:NO
                   viewController:[DSZTools takeCurrentVC]
                          confirm:^{
                              
                              if (confirm) {
                                  confirm();
                              }
                          }];
    }
    
}



// 拨号带弹出框
+ (void)callPhoneHasAlert:(NSString *)phone viewController:(UIViewController *)viewController {
    
    if (!viewController) {
        [self showAlertView:nil content:phone confirmTitle:@"呼叫" isOne:NO confirm:^{
            [DSZTools callPhone:phone];
        }];
        return;
    }
    
    if (IOS7) {
        
        [self showAlertView:nil content:phone confirmTitle:@"呼叫" isOne:NO confirm:^{
            [DSZTools callPhone:phone];
        }];
        
    }else {
        
        [self showAlertController:nil
                          content:phone
                     confirmTitle:@"呼叫"
                            isOne:NO
                   viewController:viewController
                          confirm:^{
                              
                              [DSZTools callPhone:phone];
                          }];
    }
}

// 拨号带弹出框 new
+ (void)callPhoneHasAlert:(NSString *)phone {

    [self showAlertView:nil
                content:phone
           confirmTitle:@"呼叫"
                  isOne:NO
                confirm:^{
        [DSZTools callPhone:phone];
    }];
    return;
    
    
//    if (IOS7) {
//        [self showAlertView:nil content:phone confirmTitle:@"呼叫" isOne:NO confirm:^{
//            [DSZTools callPhone:phone];
//        }];
//        
//    }else {
//        
//        [self showAlertController:nil
//                          content:phone
//                     confirmTitle:@"呼叫"
//                            isOne:NO
//                   viewController:[DSZTools takeCurrentVC]
//                          confirm:^{
//                              
//                              [DSZTools callPhone:phone];
//                          }];
//    }
}





#pragma mark- 工具类内部调用方法
// UIAlertView(iOS8之前版本)
+ (void)showAlertView:(NSString *)title
              content:(NSString *)content
         confirmTitle:(NSString *)confirmTitle
                isOne:(BOOL)isOne
              confirm:(void(^)())confirm {
    
    NSString  *cancelTitle = @"取消" ;
    if (isOne) {
        cancelTitle = nil;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:content
                                                  delegate:self
                                         cancelButtonTitle:cancelTitle
                                         otherButtonTitles:confirmTitle, nil];
    
    [alert setCompletionBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
        
        if (buttonIndex == alertView.cancelButtonIndex) {
            return ;
        }else {
            if (confirm) {
                confirm();
            }
        }
    }];
    
    [alert show];
}

//UIAlertController(iOS8及其以后)
+ (void)showAlertController:(NSString *)title
                    content:(NSString *)content
               confirmTitle:(NSString *)confirmTitle
                      isOne:(BOOL)isOne
             viewController:(UIViewController *)viewController
                    confirm:(void(^)())confirm {
    
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:content
                                                             preferredStyle:UIAlertControllerStyleAlert];
    if (!isOne) {
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleCancel
                                                              handler:nil];
        [alert addAction:cancelAction];
    }
    
    UIAlertAction  *confirmAction = [UIAlertAction actionWithTitle:confirmTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                               if (confirm) {
                                                                   confirm();
                                                               }
                                                           }];
    
    
    [alert addAction:confirmAction];
    [viewController presentViewController:alert animated:YES completion:nil];
    
}




@end
