//
//  NSArray+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/1.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DSZExt)

/**
 *  获取数组中的随机值
 *
 *  @return 随机值
 */
- (id)randomObject;

/**
 *  根据数组下标获取对象值，此方法避免数组越界导致的crach
 *  传入 index 大于数组的 count 时，程序返回 nil
 *  @param index 下标
 *
 *  @return object
 */
- (id)objectOrNilAtIndex:(NSUInteger)index;


/**
 *  将数组转换成json字符串，json字符串显示一整行
 *  格式错误时返回nil
 *
 *  @return json格式的字符串
 */
- (NSString *)jsonStringEncoded;


/**
 *  将数组转换成json字符串，字符串以json格式化输出
 *  格式错误时返回nil
 *  NSJSONWritingPrettyPrinted的意思是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行。
 *  @return json格式的字符串
 */
- (NSString *)jsonPrettyStringEncoded;


@end



@interface NSMutableArray (DSZExt)


/**
 *  移除数组中第一个对象，如果数组为空，则忽略此操作
 */
- (void)removeFirstObject;


/**
 *  移除数组中最后一个对象, 如果数组为空，则忽略此操作
 */
- (void)removeLastObject;


/**
 *  移除并返回第一个对象，数组如果为空则返回nil
 *
 *  @return 第一个对象，或者 nil
 */
- (id)popFirstObject;


/**
 *  移除并返回最后一个对象，数组为空则返回nil
 *
 *  @return 最后一个对象，或者 nil
 */
- (id)popLastObject;


/**
 *  将对象追加到数组最后, 如果数组为nil, 则追加失败
 *
 *  @param anObject 需要追加的对象
 */
- (void)appendObject:(id)anObject;


/**
 *  将对象添加到数组首位
 *
 *  @param anObject 需要添加的对象
 */
- (void)prependObject:(id)anObject;


/**
 *  将新数组追加到当前数组
 *  如果新数组为空，则忽略此操作
 *  @param objects 新数组对象
 */
- (void)appendObjects:(NSArray *)objects;

/**
 *  将新数组添加到当前数组首位
 *  如果新数组为空，则忽略此操作
 *  @param objects 新数组对象
 */
- (void)prependObjects:(NSArray *)objects;

/**
 *  根据下标插入新数组对象到当前数组
 *
 *  @param objects 数组对象
 *  @param index   指定下标
 */
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/**
 *  将数组反转
 */
- (void)reverse;

/**
 *  随机打乱数组
 */
- (void)shuffle;

@end


