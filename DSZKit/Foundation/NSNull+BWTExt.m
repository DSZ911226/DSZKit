//
//  NSNull+BWTExt.m
//  BWT
//
//  Created by HuHao on 12/14/15.
//  Copyright © 2015 BWT. All rights reserved.
//

#import "NSNull+BWTExt.h"
#import "BWTKitMacro.h"

@implementation NSNull (BWTExt)

- (BOOL)isEqualToString:(NSString *)aString {
    BWTErrorLog(@"[NSNull]没有[isEqualToString:]方法.");
    return NO;
}

- (NSUInteger)length {
    BWTErrorLog(@"[NSNull]没有[length]方法.");
    return 0;
}

- (float)floatValue {
    BWTErrorLog(@"[NSNull]没有[floatValue]方法.");
    return 0.00;
}

- (double)doubleValue {
    BWTErrorLog(@"[NSNull]没有[doubleValue]方法.");
    return 0.00;
}

- (NSInteger)integerValue {
    BWTErrorLog(@"[NSNull]没有[integerValue]方法.");
    return 0;
}

- (NSUInteger)count {
    BWTErrorLog(@"[NSNull]没有[count]方法.");
    return 0;
}

- (id)objectForKey:(id)aKey {
    BWTErrorLog(@"[NSNull]没有[objectForKey]方法.");
    return @"";
}

- (id)objectForKeyedSubscript:(id)key {
    BWTErrorLog(@"[NSNull]没有[objectForKeyedSubscript]方法.");
    return @"";
}

- (NSString *)substringFromIndex:(NSUInteger)from {
    BWTErrorLog(@"[NSNull]没有[substringFromIndex]方法.");
    return @"";
}
- (NSString *)substringToIndex:(NSUInteger)to {
    BWTErrorLog(@"[NSNull]没有[substringToIndex]方法.");
    return @"";
}


@end
