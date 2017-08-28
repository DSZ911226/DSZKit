//
//  DSZAlertViewTools.m
//  DSZSH  提示框工具类
//
//  Created by 小广 on 16/1/11.
//  Copyright © 2016年 DSZ. All rights reserved.
//

#import "DSZAlertViewTools.h"
#import "DSZKitMacro.h"
#import "UIViewController+DSZExt.h"
#import "DSZTools.h"
#import "UIAlertView+DSZExt.h"

@interface DSZAlertViewTools ()<UIActionSheetDelegate>

@property (nonatomic, copy) AlertViewBlock block;

@end

@implementation DSZAlertViewTools

#pragma mark - 对外方法
+ (DSZAlertViewTools *)shareInstance {
    static DSZAlertViewTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}

/**
 *  创建提示框
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击确认按钮的回调
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm {
    
    if (IOS7) {
        [self p_showAlertView:title message:message cancelTitle:cancelTitle titleArray:titleArray confirm:^(NSInteger buttonTag) {
            if (confirm)confirm(buttonTag);
        }];
        return;
    }
    // iOS8及其之后
    if (!vc) vc = [UIViewController lastViewController];
    [self p_showAlertController:title message:message cancelTitle:cancelTitle titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
        if (confirm)confirm(buttonTag);
    }];
}


/**
 *  创建提示框(可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle= va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    // 弹出提示框
    
    if (IOS7) {
        [self p_showAlertView:title message:message cancelTitle:cancelTitle titleArray:titleArray confirm:^(NSInteger buttonTag) {
            if (confirm)confirm(buttonTag);
        }];
        return;
    }
    // iOS8及其之后
    if (!vc) vc = [UIViewController lastViewController];
    [self p_showAlertController:title message:message cancelTitle:cancelTitle titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
        if (confirm)confirm(buttonTag);
    }];
    
}


/**
 *  创建菜单(Sheet)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击确认按钮的回调
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm {
    
    if (!vc) vc = [UIViewController lastViewController];
    if (IOS7) {
        [self p_showSheet:title cancelTitle:cancelTitle
               titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                   if (confirm)confirm(buttonTag);
               }];
        return;
    }
    // iOS8及其之后
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
}

/**
 *  创建菜单(Sheet 可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle= va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    // 显示菜单提示框
    
    if (!vc) vc = [UIViewController lastViewController];
    if (IOS7) {
        [self p_showSheet:title cancelTitle:cancelTitle
               titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                   if (confirm)confirm(buttonTag);
               }];
        return;
    }
    // iOS8及其之后
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
    
}


// 拨号带弹出框
- (void)callPhoneHasAlert:(NSString *)phone {
    [self callPhoneHasAlert:phone viewController:nil];
    
}

// 拨号带弹出框
- (void)callPhoneHasAlert:(NSString *)phone viewController:(UIViewController *)vc {
    if (IOS7) {
        [self p_showAlertView:nil message:nil cancelTitle:nil
                   titleArray:@[@"呼叫"] confirm:^(NSInteger buttonTag) {
                       if (buttonTag == cancelIndex) return ;
                       [DSZTools callPhone:phone];
                   }];
        return;
    }
    
    // iOS8及其之后
    if (!vc) vc = [UIViewController lastViewController];
    [self p_showAlertController:nil message:nil cancelTitle:nil
                     titleArray:@[@"呼叫"] viewController:vc confirm:^(NSInteger buttonTag) {
                         if (buttonTag == cancelIndex) return ;
                         [DSZTools callPhone:phone];
                     }];
    
}

// 服务电话
- (void)callServicePhone:(UIViewController *)vc phone:(NSString *)phone {
    if (!vc) vc = [UIViewController lastViewController];
    NSString *servicePhone = [NSString stringWithFormat:@"客服电话:  %@",phone];
    NSString *serviceMobile = [NSString stringWithFormat:@"服务电话:  %@",phone];
    
    if (IOS7) {
        [self p_showSheet:@"联系我们" cancelTitle:@"取消" titleArray:@[servicePhone,serviceMobile]
           viewController:vc confirm:^(NSInteger buttonTag) {
               if (buttonTag == cancelIndex) return ;
               if (buttonTag == 0) {
                   [DSZTools callPhone:phone];
                   return ;
               }
               [DSZTools callPhone:phone];
               
           }];
        return;
    }
    // iOS8及其之后
    [self p_showSheetAlertController:@"联系我们"  message:nil cancelTitle:@"取消" titleArray:@[servicePhone,serviceMobile] viewController:vc confirm:^(NSInteger buttonTag) {
        if (buttonTag == cancelIndex) return ;
        if (buttonTag == 0) {
            [DSZTools callPhone:phone];
            return ;
        }
        [DSZTools callPhone:phone];
    }];
}


#pragma mark - ----------------内部方法------------------
// UIAlertView(iOS8之前版本)
- (void)p_showAlertView:(NSString *)title
                message:(NSString *)message
            cancelTitle:(NSString *)cancelTitle
             titleArray:(NSArray *)titleArray
                confirm:(AlertViewBlock)confirm {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:cancelTitle
                                         otherButtonTitles: nil];
    
    if (!titleArray || titleArray.count == 0) {
        [alert addButtonWithTitle:@"确定"];
    } else {
        for (NSInteger i = 0; i<titleArray.count; i++) {
            [alert addButtonWithTitle:titleArray[i]];
        }
    }
    
    [alert setCompletionBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
        if (buttonIndex == alertView.cancelButtonIndex) {
            if (confirm)confirm(cancelIndex);
            return ;
        }
        if (confirm)confirm(buttonIndex - 1);
    }];
    
    [alert show];
}

//UIAlertController(iOS8及其以后)
- (void)p_showAlertController:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   titleArray:(NSArray *)titleArray
               viewController:(UIViewController *)vc
                      confirm:(AlertViewBlock)confirm {
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle) {
        // 取消
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  if (confirm)confirm(cancelIndex);
                                                              }];
        [alert addAction:cancelAction];
    }
    // 确定操作
    if (!titleArray || titleArray.count == 0) {
        UIAlertAction  *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (confirm)confirm(0);
                                                               }];
        [alert addAction:confirmAction];
    } else {
        
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            [alert addAction:action];
        }
    }
    
    [vc presentViewController:alert animated:YES completion:nil];
}


// ActionSheet的封装
// ActionSheet(iOS8之前版本)
- (void)p_showSheet:(NSString *)title
        cancelTitle:(NSString *)cancelTitle
         titleArray:(NSArray *)titleArray
     viewController:(UIViewController *)vc
            confirm:(AlertViewBlock)confirm {
    self.block = confirm;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (titleArray.count > 0) {
        for (NSInteger i = 0; i<titleArray.count; i++) {
            [sheet addButtonWithTitle:titleArray[i]];
        }
    }
    if (!cancelTitle) cancelTitle = @"取消";
    [sheet addButtonWithTitle:cancelTitle]; // 取消按钮也是这会再加
    sheet.cancelButtonIndex = sheet.numberOfButtons - 1;  //注意这个地方
    [sheet showInView:vc.view];
}

// ActionSheet(iOS8及其以后)
- (void)p_showSheetAlertController:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        titleArray:(NSArray *)titleArray
                    viewController:(UIViewController *)vc
                           confirm:(AlertViewBlock)confirm {
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if (!cancelTitle) cancelTitle = @"取消";
    // 取消
    UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (confirm)confirm(cancelIndex);
                                                          }];
    [sheet addAction:cancelAction];
    
    if (titleArray.count > 0) {
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            [sheet addAction:action];
        }
    }
    
    [vc presentViewController:sheet animated:YES completion:nil];
}

#pragma mark - 代理方法
// ActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        if (self.block) {
            self.block(cancelIndex);
        }
        return;
    };
    if (self.block) {
        self.block(buttonIndex);
    }
}

@end
