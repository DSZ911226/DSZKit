//
//  FirstTableVIewController.m
//  Demo
//
//  Created by zhilvmac on 2017/8/28.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import "FirstTableVIewController.h"
#import "TableViewCell.h"
#import <MJExtension.h>
@interface FirstTableVIewController ()

@end

@implementation FirstTableVIewController

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self p_initData];
    [self p_initView];
}

#pragma mark - 懒加载方法



#pragma mark - 自定义方法

- (void)p_initData {
    
}

- (void)p_initView {
    self.title = @"失物招领";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 重写父类方法

- (void)requestData:(NSUInteger)currentPage pageCount:(NSUInteger)count {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"BusinessManage" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    id jsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    NSArray *array = jsonObject;
    if ([array count] > 0) {
        [self addItems:[Firstmodel mj_objectArrayWithKeyValuesArray:array]];
    }
    [self reloadTableView];
}
- (void)configTableViewSource {
    kWeakSelf
    self.dataSource = [[DSZArrayDataSource alloc] initWithItems:self.arrayData cellIdentifier:[TableViewCell className] configureCellBlock:^(TableViewCell *cell, id item, NSIndexPath *indexPath) {
        cell.model = weakSelf.arrayData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell addCellBottomLineWithTableView:weakSelf.tableView indexPath:indexPath left:0];
    }];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:[TableViewCell className]];
    [self configTableView:self.dataSource nibs:nil];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    BWTLostAndFoundModel *model = self.arrayData[indexPath.row];
//    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:FONT(15),NSFontAttributeName,nil];
//    CGSize actualsize = [model.found_msg boundingRectWithSize:CGSizeMake(AutomaticWidth(350),1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
//    CGFloat heigh = AutomaticHeight(70) + actualsize.height + 5;
    return 44;
}


@end
