//
//  UITableViewCell+BWTExt.m
//  BWT 设置cell分割线的高度
//
//  Created by HuHao on 15/11/4.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import "UITableViewCell+BWTExt.h"
#import "BWTKitMacro.h"

@implementation UITableViewCell (BWTExt)

- (void)addCellBottomLineWithTableView:(UITableView *)tableView
                             indexPath:(NSIndexPath *)indexPath
                                  left:(CGFloat)left
{
    [self addCellBottomLineWithTableView:tableView indexPath:indexPath left:left heigh:1];
}

- (void)addCellBottomLineWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath left:(CGFloat)left heigh:(CGFloat)heigh {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (!tableView) {
        BWTLog(@"**********  tableView参数未传  **********");
        return;
    }
    if (!indexPath) {
        BWTLog(@"**********  indexPath参数未传  **********");
        return;
    }
    if (!left) {
        left = 0;
    }
    if (!heigh) {
        heigh = 1;
    }
    
    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, rect.size.height - heigh, BWTScreenWidth, heigh)];
    
    lineView.backgroundColor = UIColorFrom10RGB(237, 246, 255);
    
    [self addSubview:lineView];
}

@end
