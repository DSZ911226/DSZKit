//
//  NSNull+DSZExt.m
//  DSZ
//
//  Created by DSZ on 12/14/15.
//  Copyright © 2015 DSZ. All rights reserved.
//

#import "NSNull+DSZExt.h"
#import "DSZKitMacro.h"

@implementation NSNull (DSZExt)

- (BOOL)isEqualToString:(NSString *)aString {
    DSZErrorLog(@"[NSNull]没有[isEqualToString:]方法.");
    return NO;
}

- (NSUInteger)length {
    DSZErrorLog(@"[NSNull]没有[length]方法.");
    return 0;
}

- (float)floatValue {
    DSZErrorLog(@"[NSNull]没有[floatValue]方法.");
    return 0.00;
}

- (double)doubleValue {
    DSZErrorLog(@"[NSNull]没有[doubleValue]方法.");
    return 0.00;
}

- (NSInteger)integerValue {
    DSZErrorLog(@"[NSNull]没有[integerValue]方法.");
    return 0;
}

- (NSUInteger)count {
    DSZErrorLog(@"[NSNull]没有[count]方法.");
    return 0;
}

- (id)objectForKey:(id)aKey {
    DSZErrorLog(@"[NSNull]没有[objectForKey]方法.");
    return @"";
}

- (id)objectForKeyedSubscript:(id)key {
    DSZErrorLog(@"[NSNull]没有[objectForKeyedSubscript]方法.");
    return @"";
}

- (NSString *)substringFromIndex:(NSUInteger)from {
    DSZErrorLog(@"[NSNull]没有[substringFromIndex]方法.");
    return @"";
}
- (NSString *)substringToIndex:(NSUInteger)to {
    DSZErrorLog(@"[NSNull]没有[substringToIndex]方法.");
    return @"";
}


@end
