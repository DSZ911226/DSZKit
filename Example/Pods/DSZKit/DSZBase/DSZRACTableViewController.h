//
//  DSZRACTableViewController.h
//  MSX 基于RAC的基础类列表视图
//
//  Created by 胡浩 on 2017/6/23.
//  Copyright © 2017年 DSZ. All rights reserved.
//

#import "DSZBaseViewController.h"
#import "DSZArrayDataSource.h"
#import "UITableView+FDTemplateLayoutCell.h"

@class DSZTableViewModel;

@interface DSZRACTableViewController : DSZBaseViewController


/**
 列表视图样式
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;


/**
 列表视图
 */
@property (nonatomic, strong) UITableView *tableView;


/**
 无数据时显示的视图
 */
@property (nonatomic, strong) UIView *emptyView;

/**
 开启自动加载数据 YES-开启 NO-关闭 默认开启
 */
@property (nonatomic, assign) BOOL autoLoad;


/**
 关闭上/下拉刷新 YES-关闭 NO-开启 默认开启
 */
@property (assign, nonatomic) BOOL closeRefresh;


/**
 设置头部下拉刷新组件是否隐藏

 @param visible YES-设置可见 NO-设置不可见
 */
- (void)headerRefreshViewVisible:(BOOL)visible;


/**
 设置尾部上拉刷新组件是否隐藏

 @param visible YES-设置可见 NO-设置不可见
 */
- (void)footerRefreshViewVisible:(BOOL)visible;



/**
 重新刷新表格
 */
- (void)reloadTableView;


/**
 *  开始刷新视图
 */
- (void)beginRefreshing;


/**
 *  结束刷新视图, 下拉刷新/上拉分页 都可调用此方法
 */
- (void)endRefreshing;



/**
 配置TableView相关数据

 @param dataSource 数据源代理
 @param viewModel viewModel
 @param nibs 需要注册cell的xib
 */
- (void)configTableView:(DSZArrayDataSource *)dataSource
              viewModel:(DSZTableViewModel *)viewModel
                   nibs:(NSArray *)nibs;


/**
 配置TableView相关数据
 
 @param dataSource 数据源代理
 @param viewModel viewModel
 @param cells 需要注册cell的view
 */
- (void)configTableView:(DSZArrayDataSource *)dataSource
              viewModel:(DSZTableViewModel *)viewModel
                  cells:(NSArray *)cells;




#pragma mark - 以下方法子类需要重写


/**
 *  配置TableView的数据源
 */
- (void)configTableViewSource;


/**
 处理异常状态

 @param error 异常类
 */
- (void)handlerError:(NSError *)error;


/**
 选中单个cell时回调的方法

 @param indexPath indexPath
 */
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
