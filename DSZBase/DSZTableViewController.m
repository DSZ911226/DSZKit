//
//  DSZTableViewController.m
//  DSZ
//
//  Created by HuHao on 15/10/4.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZTableViewController.h"
#import "DSZArrayDataSource.h"
#import "MJRefresh.h"
#import "DSZKitMacro.h"
#import "UITableView+DSZExt.h"
#import "UIView+DSZExt.h"

@interface DSZTableViewController () <UITableViewDelegate>

@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) NSMutableArray *arrayData;    // 所有数据

@property (nonatomic, assign) NSUInteger currentPage;       // 当前页
@property (nonatomic, assign) NSUInteger pageCount;         // 每次请求的条数
@property (nonatomic, assign) NSUInteger totalPage;         // 总页数(用于判断是否需要分页)
@property (nonatomic, assign) NSUInteger totalCount;        // 总条数
@property (nonatomic, copy) NSString *emptyTitle;           // 为空内容提示
@property (nonatomic, strong) UIImageView *footImgView ;    // 底部广告图片

@end

@implementation DSZTableViewController


#pragma mark - 生命周期方法

- (void)dealloc {

    // 移除监听
    if (_tableView) {
        [_tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    }

    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentPage = 1;
        _pageCount = kPageSize;
        _totalPage = 0;
        _totalCount = 0;
        _autoLoad = YES;
        _closeRefresh = NO;
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _currentPage = 1;
        _pageCount = kPageSize;
        _totalPage = 0;
        _totalCount = 0;
        _autoLoad = YES;
        _closeRefresh = NO;
        _tableViewStyle = UITableViewStylePlain;
    }

    return self;
}


- (void)setAutoLoad:(BOOL)autoLoad {
    _autoLoad = autoLoad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 监听方法

//监听的处理
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // 判断tableView内容高度
        CGFloat tabelVeiwContentHeight = self.tableView.contentSize.height;
        if (DSZViewHeight - tabelVeiwContentHeight > 24) {
            CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
            kWeakSelf
            if (DSZViewHeight - tabelVeiwContentHeight + offset.y > 24) {
                [UIView animateWithDuration:1 animations:^{
                    weakSelf.footImgView.alpha = 1;
                }];
            } else {
                [UIView animateWithDuration:1 animations:^{
                    weakSelf.footImgView.alpha = 0;
                }];
            }
        }
    }
}

#pragma mark - 自定义方法


- (void)addItems:(NSArray *)items {
    
    BOOL isClear = (self.currentPage == 1);
    if (isClear) {
        [self.arrayData removeAllObjects];
    }

    if (items.count == 0) {
        return;
    }
    
    [self.arrayData addObjectsFromArray:items];
}

- (void)addItems:(NSArray *)items refresh:(BOOL)refresh {
    [self addItems:items];
    if (refresh) {
        [self reloadTableView];
    }
}


- (void)reloadTableView {

    // 添加为空时显示的View
    if (self.arrayData.count == 0) {
        [self.tableView addSubview:self.emptyView];
        self.emptyView.hidden = NO;
    } else {
        [self.emptyView removeFromSuperview];
        self.emptyView.hidden = YES;
    }

    // 判断隐藏底部刷新控件
    [self p_footerViewVisible:!self.hasNextPage];
    
    [self.tableView reloadData];
    
    [self isHiddenFooterImgView];
}

- (void)isHiddenFooterImgView {
    //判断tableView内容高度
    CGFloat tabelVeiwContentHeight = self.tableView.contentSize.height;
    kWeakSelf
    if (DSZViewHeight - tabelVeiwContentHeight > 24) {
        [UIView animateWithDuration:1 animations:^{
            weakSelf.footImgView.alpha = 1;
        }];
    }else {
        [UIView animateWithDuration:1 animations:^{
            weakSelf.footImgView.alpha = 0;
        }];
    }
}

- (void)changePageCount:(NSUInteger)count {
    self.pageCount = count;
}


- (void)beginRefreshing {
    self.currentPage = 1;
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefreshing {
    if (self.currentPage > 1) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.arrayData.count == 0) {
        [self reloadTableView];
    }
}


- (void)changeEmptyView:(UIView *)view {
    _emptyView = view;
    [self.tableView reloadData];
}

- (void)resetEmptyViewFrame:(CGRect)frame {
    self.emptyView.frame = frame;
}

- (void)setEmptyViewHidden {
    self.emptyView.hidden = YES;
}

- (void)calculateTotalPage:(NSUInteger)totalCount {
    NSInteger totalPage = (totalCount + self.pageCount - 1) / self.pageCount;
    _totalPage = totalPage;
}


- (void)configTableView:(DSZArrayDataSource *)dataSource cells:(NSArray *)cells {
    self.tableView.dataSource = dataSource;
    kWeakSelf
    [cells enumerateObjectsUsingBlock:^(NSString *cellName, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(cellName);
        [weakSelf.tableView registerClass:class forCellReuseIdentifier:cellName];
    }];
}

- (void)configTableView:(DSZArrayDataSource *)dataSource nibs:(NSArray *)nibs {
    self.tableView.dataSource = dataSource;

    kWeakSelf
    [nibs enumerateObjectsUsingBlock:^(NSString *nibName, NSUInteger idx, BOOL * _Nonnull stop) {
        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
        [weakSelf.tableView registerNib:nib forCellReuseIdentifier:nibName];
    }];
}


- (void)updateTableViewFrame:(CGRect)frame {
    self.tableView.frame = frame;
}

- (void)headerViewVisible:(BOOL)visible {
    [self p_headerViewVisible:visible];
}

- (void)hideFooterView:(BOOL)hidden {
    [self p_footerViewVisible:hidden];
}


#pragma mark - 对内方法

- (void)_initView {

    self.view.backgroundColor = UIColorFrom10RGB(237, 246, 255);
    [self.view addSubview:self.tableView];
    // 添加监听
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.footImgView];
    [self configTableViewSource];
    if (!self.closeRefresh) {
        [self p_addHeader];
        [self p_addFooter];
    }

}

- (void)p_addHeader {
    kWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf p_headerWithRefreshing];
    }];

    if (self.autoLoad) {
        [self.tableView.mj_header beginRefreshing];
    }
}


- (void)p_addFooter {
    kWeakSelf
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf p_footerWithRefreshing];
    }];
    self.tableView.mj_footer.automaticallyHidden = NO; // 关闭自动分页刷新
    self.tableView.mj_footer.hidden = YES;
}


- (void)p_headerWithRefreshing {
    self.currentPage = 1;
    [self requestData:self.currentPage pageCount:self.pageCount];
}


- (void)p_footerWithRefreshing {
    self.currentPage++;
    if (self.totalPage > 0 && self.totalPage < self.currentPage
        && self.currentPage > 1) {
        DSZLog(@"没有分页数据...");
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = YES;
        return;
    }

    [self requestData:self.currentPage pageCount:self.pageCount];
}

- (void)p_headerViewVisible:(BOOL)visible {
    self.tableView.mj_header.hidden = !visible;
}

- (void)p_footerViewVisible:(BOOL)visible {
    self.tableView.mj_footer.hidden = visible;
}


#pragma mark - 懒加载方法

- (UIImageView *)footImgView {
    if (!_footImgView) {
        _footImgView = [[UIImageView alloc] initWithFrame:CGRectMake((DSZScreenWidth - 126) / 2.f, DSZScreenHeight - 24 - 64, 126, 14)];
        _footImgView.image = DSZBaseImageName(@"bottomImage");
        
    }
    return _footImgView;
}

- (UITableView *)tableView {
    if (!_tableView) {

        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DSZScreenWidth, DSZViewHeight) style:_tableViewStyle];
        tableView.backgroundColor = UIColorFrom10RGB(237,246,255);
        tableView.backgroundView = nil;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.rowHeight = 70.f;
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        _tableView = tableView;
    }
    
    return _tableView;
}

/* 目前基本可以兼容有表头的tableView
 * 无表头的话  请在所使用的类里加上self.emptyView.frame = self.tableView.frame;
 */
- (UIView *)emptyView {
    if (!_emptyView) {
        
        CGFloat posY = self.tableView.tableHeaderView.frame.size.height;
        CGFloat height = 0.0;
        
//        if (self.tableView.frame.origin.y == 0.0 && posY == 0.0) {
//            posY = 64.0;
//        } else {
//            
//        }

        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            height = self.tableView.frame.size.height - self.tableView.tableHeaderView.frame.size.height;
        } else {
            height = self.tableView.frame.size.height;
        }

        _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0.0, posY, self.tableView.frame.size.width, height)];

        UIImage *image = DSZBaseImageName(@"list_empty");
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

        CGFloat centerY = 0.0;
        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            centerY = _emptyView.center.y - 120.0;
        } else {
            centerY = _emptyView.center.y - 90.0;
        }

        imageView.size = CGSizeMake(188, 165);
        imageView.center = CGPointMake(_emptyView.center.x, centerY);
        // imageView.center = view.center;
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = [UIColor clearColor];
        [_emptyView addSubview:imageView];

        UILabel *emptyLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, imageView.frame.origin.y + imageView.frame.size.height + 8, DSZScreenWidth-32, 30)];

        if (self.emptyTitle.length == 0) {
            self.emptyTitle = @"亲, 没有更多内容";
        }

        emptyLbl.text = self.emptyTitle;
        emptyLbl.textAlignment = NSTextAlignmentCenter;
        emptyLbl.font = [UIFont systemFontOfSize:16];
        emptyLbl.textColor = UIColorFrom16RGB(0x787878);
        [_emptyView addSubview:emptyLbl];

    }

    return _emptyView;
}

- (NSMutableArray *)arrayData {
    if (!_arrayData) {
        _arrayData = [NSMutableArray arrayWithCapacity:1];
    }

    return _arrayData;
}


- (void)setEmptyTitle:(NSString *)emptyTitle {
    _emptyTitle = emptyTitle;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectRowAtIndexPath:indexPath];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (self.arrayData.count == 0) {
//        return CGRectGetHeight(self.emptyView.frame);
//    } else {
//        return 0.01;
//    }
//}

#pragma mark - 以下方法子类需要重写

- (void)requestData:(NSUInteger)currentPage pageCount:(NSUInteger)count {
    DAssert(0)
}

/**
 *  配置TableView的数据源
 */
- (void)configTableViewSource {
    DAssert(0)
}

/**
 *  选中单个cell时回调的方法
 *
 *  @param indexPath
 */
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
