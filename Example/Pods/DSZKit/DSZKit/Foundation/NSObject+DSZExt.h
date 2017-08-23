//
//  NSObject+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DSZ_TRY_BODY(__target) \
@try {\
{__target}\
}\
@catch (NSException *exception) {\
 NSLog(@"exception ===== %@", [exception description]);\
}\
@finally {\
\
}

typedef void(^DSZObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);


@interface NSObject (DSZExt)


/**
 Associate one object to `self`, as if it was a strong property (strong, nonatomic).
 
 @param value   The object to associate.
 @param key     The pointer to get value from `self`.
 */
- (void)setAssociateValue:(id)value withKey:(void *)key;

/**
 Associate one object to `self`, as if it was a weak property (week, nonatomic).
 
 @param value  The object to associate.
 @param key    The pointer to get value from `self`.
 */
- (void)setAssociateWeakValue:(id)value withKey:(void *)key;

/**
 Get the associated value from `self`.
 
 @param key The pointer to get value from `self`.
 */
- (id)getAssociatedValueForKey:(void *)key;

/**
 Remove all associated values.
 */
- (void)removeAssociatedValues;


/**
 Returns the class name in NSString.
 */
+ (NSString *)className;

/**
 *  判断对象是否是JSON对象
 *
 *  @return bool
 */
- (BOOL)isJSONObject;

/**
 Returns the class name in NSString.
 */
- (NSString *)className;




@end


@interface NSObject (Swizzle)

/**
 *  交换方法
 *
 *  @param srcSel 原有的方法
 *  @param tarSel 替换的方法
 */
+ (void)swizzleMethod:(SEL)srcSel tarSel:(SEL)tarSel;


/**
 *  交换方法
 *
 *  @param srcSel       原有的方法
 *  @param tarClassName 替换的类
 *  @param tarSel       替换的方法
 */
+ (void)swizzleMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel;


/**
 *  交换方法
 *
 *  @param srcClass 原有的类
 *  @param srcSel   原有的方法
 *  @param tarClass 替换的类
 *  @param tarSel   替换的方法
 */
+ (void)swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel;


@end



@interface NSObject (KVO)

- (void)DSZ_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(DSZObservingBlock)block;

- (void)DSZ_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
