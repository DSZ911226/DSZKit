//
//  DSZTextField.m
//  Pods
//
//  Created by 徐结兵 on 2017/7/15.
//
//

#import "DSZTextField.h"

@implementation DSZTextField

- (void)deleteBackward {
    [super deleteBackward];
    if ([self.delegate respondsToSelector:@selector(deleteBackward:)]) {
        [self.delegate deleteBackward:self];
    }
}

@end
