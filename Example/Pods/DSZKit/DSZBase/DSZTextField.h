//
//  DSZTextField.h
//  Pods
//
//  Created by 徐结兵 on 2017/7/15.
//
//

#import <UIKit/UIKit.h>

@class DSZTextField;

@protocol DSZTextFieldDelegate <NSObject>

/**
 textField删除键回调

 @param textField textField
 */
- (void)deleteBackward:(DSZTextField *)textField;

@end

@interface DSZTextField : UITextField

@property (nonatomic, assign) id<DSZTextFieldDelegate> delegate;

@end
