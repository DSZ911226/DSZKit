//
//  UITableViewCell+BWTExt.h
//  BWT
//
//  Created by HuHao on 15/11/4.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BWTExt)

/**
 设置cell分割线，分割线高度默认为1
 
 @param tableView tableView
 @param indexPath indexPath
 @param left 距离左边的距离
 */
- (void)addCellBottomLineWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath left:(CGFloat)left;

/**
 设置cell分割线,可自定义分割线高度

 @param tableView tableView
 @param indexPath indexPath
 @param left 距离左边距离
 @param heigh 分割线高度
 */
- (void)addCellBottomLineWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath left:(CGFloat)left heigh:(CGFloat)heigh;


@end
