//
//  DSZTableViewController.h
//  DSZ
//
//  Created by HuHao on 15/10/4.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZBaseViewController.h"
#import "DSZArrayDataSource.h"
#import "UITableView+FDTemplateLayoutCell.h"

#define kPageSize 10    // 每页显示分页数

@interface DSZTableViewController : DSZBaseViewController

@property (assign, nonatomic) UITableViewStyle tableViewStyle;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) BOOL hasNextPage; // 是否有下一页

// 自动加载数据 YES-开启 NO-关闭 默认开启
@property (assign, nonatomic) BOOL autoLoad;

// 关闭上/下拉刷新 YES-关闭 NO-开启 默认开启
@property (assign, nonatomic) BOOL closeRefresh;
@property (strong, nonatomic, readonly) NSMutableArray *arrayData;
@property (strong, nonatomic) DSZArrayDataSource *dataSource;


/**
 *  添加数据 第一页时会先清空原有数据
 *  @param items 新数据
 */
- (void)addItems:(NSArray *)items;

/**
 *  添加数据 第一页时会先清空原有数据
 *  @param items 新数据
 *  @param refresh 刷新数据 YES, 数据添加完立即刷新视图 NO 不刷新视图
 */
- (void)addItems:(NSArray *)items refresh:(BOOL)refresh;

/**
 *  隐藏下拉刷新
 *
 *  @param visible
 */
- (void)headerViewVisible:(BOOL)visible;

/**
 *  隐藏上拉加载更多
 *
 *  @param visible 
 */
- (void)hideFooterView:(BOOL)hidden;

/**
 *  重新刷新表格
 */
- (void)reloadTableView;


/**
 *  替换无数据时显示的View
 *
 *  @param view 自定义View
 */
- (void)changeEmptyView:(UIView *)view;

/**
 *  设置无数据时显示的Viewframe
 */
- (void)resetEmptyViewFrame:(CGRect)frame;

/**
 *  设置无数据时显示的Viewframe
 */
- (void)setEmptyViewHidden;

/**
 *  开始刷新视图
 */
- (void)beginRefreshing;


/**
 *  结束刷新视图, 下拉刷新/上拉分页 都可调用此方法
 */
- (void)endRefreshing;


/**
 *  根据总条数计算出总页数
 *
 *  @param totalCount 总条数
 */
- (void)calculateTotalPage:(NSUInteger)totalCount;


/**
 *  设置UITableView的数据源、注册Nib
 *
 *  @param dataSource 数据源
 *  @param nibs       自定义cell 数组
 */
- (void)configTableView:(DSZArrayDataSource *)dataSource nibs:(NSArray *)nibs;


/**
 *  设置UITableView的数据源、注册CellClass
 *
 *  @param dataSource 数据源
 *  @param nibs       自定义cell 数组
 */
- (void)configTableView:(DSZArrayDataSource *)dataSource cells:(NSArray *)cells;

/**
 *  设置表视图的frame
 *
 *  @param rect frame
 */
- (void)updateTableViewFrame:(CGRect)frame;


/**
 *  更改每页显示数
 *
 *  @param count 条数
 */
- (void)changePageCount:(NSUInteger)count;


/**
 * 设置内容
 */
- (void)setEmptyTitle:(NSString *)emptyTitle;


#pragma mark - 以下方法子类需要重写

/**
 *  网络请求方法
 *
 *  @param currentPage 当前页
 *  @param count       每页显示数
 */
- (void)requestData:(NSUInteger)currentPage pageCount:(NSUInteger)count;

/**
 *  配置TableView的数据源
 */
- (void)configTableViewSource;

/**
 *  选中单个cell时回调的方法
 *
 *  @param indexPath
 */
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
