//
//  UISearchBar+DSZExt.m
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "UISearchBar+DSZExt.h"

@implementation UISearchBar (DSZExt)

- (void)regetCancelButtonFocus {
  for (UIView *view in self.subviews) {
    if ([view isKindOfClass:[UIButton class]]) {
      ((UIButton*)view).enabled = YES;
    }
    
    for (UIView *subView in view.subviews) {
      if ([subView isKindOfClass:[UIButton class]]) {
        ((UIButton*)subView).enabled = YES;
      }
    }
  }
}

- (void)textFileBackground:(UIColor *)color {
  for (UIView *view in self.subviews) {
    for (id subview in view.subviews) {
      if ([subview isKindOfClass:[UITextField class]] ){
        [(UITextField *)subview setBackgroundColor:color];
        break;
      }
    }
  }
}

- (void)setTextFieldTextcolor:(UIColor *)color {
    for (UIView *view in self.subviews) {
        for (id subview in view.subviews) {
            if ([subview isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subview;
                textField.textColor = color;
            }
        }
    }
}

- (void)setTextFieldTextFont:(CGFloat)font {
    for (UIView *view in self.subviews) {
        for (id subview in view.subviews) {
            if ([subview isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subview;
                textField.font = [UIFont systemFontOfSize:font];
            }
        }
    }
}

- (void)setTextFieldFocusColor:(UIColor *)color {
    [[[self.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:color];
}

- (void)setBarBackgroundColor:(UIColor *)backgroundColor {
  for (UIView *view in self.subviews) {
    for (UIView *subview in view.subviews) {
      if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
        [subview removeFromSuperview];
        
        UIView *bgview = [[UIView alloc] initWithFrame:self.frame];
        view.backgroundColor = backgroundColor;
        [subview.superview addSubview:bgview];
        break;
      }
    }
  }
}

@end
