//
//  DSZArrayDataSource.h
//  MSX 配置tableView的数据源
//
//  Created by huhao on 14-4-25.
//  Copyright (c) 2014年 DSZon. All rights reserved.
//

typedef void (^DSZTableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);
typedef void (^DSZTableViewCellEditingBlock)(NSIndexPath *indexPath);

@interface DSZArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, assign) NSUInteger sectionCount;  // 分组数


- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(DSZTableViewCellConfigureBlock)aConfigureCellBlock;


/**
 *  初始化数据源类，此方法初始化有分组的 tableview
 *
 *  @param items          数据
 *  @param cellIdentifier cell identifier
 *  @param block          回调block
 *  @param hasSection     是否有分组 yes-有 no-没有
 *  @param sectionCount   总共有多少组
 *
 *  @return 当前实例
 */
- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(DSZTableViewCellConfigureBlock)block
         hasSection:(BOOL)hasSection
       sectionCount:(NSInteger)sectionCount;

/**
 *  替换所有的数据
 *
 *  @param array 新数组
 */
- (void)changeItems:(NSArray *)array;




/**
 *  设置cell侧滑删除后回调的block
 *
 *  @param block
 */
- (void)configureCellEditBlock:(DSZTableViewCellEditingBlock)block;

/**
 *  根据 NSIndexPath 获取 对象
 *
 *  @param indexPath
 *
 *  @return 对象
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;


@end
