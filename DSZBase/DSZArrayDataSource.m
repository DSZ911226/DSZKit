//
//  DSZArrayDataSource.m
//  MSX 配置tableView的数据源
//
//  Created by huhao on 14-4-25.
//  Copyright (c) 2014年 DSZon. All rights reserved.
//

#import "DSZArrayDataSource.h"

@interface DSZArrayDataSource () {

}

@property (nonatomic, assign) BOOL hasSection;              // 是否有分组
@property (nonatomic, assign) BOOL isCanEdit;               // cell是否可编辑

@property (nonatomic, copy) DSZTableViewCellEditingBlock editBlock;
@property (nonatomic, copy) DSZTableViewCellConfigureBlock configureCellBlock;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;

@end


@implementation DSZArrayDataSource

- (void)dealloc
{
    NSLog(@"DSZArrayDataSource dealloc");
}

- (id)init {
    return nil;
}

#pragma mark - 自定义方法

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(DSZTableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
        self.sectionCount = 1;
    }
    return self;
}


- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(DSZTableViewCellConfigureBlock)block
         hasSection:(BOOL)hasSection
       sectionCount:(NSInteger)sectionCount
{
    self = [super init];
    if (self) {
        self.items = items;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = block;
        self.hasSection = hasSection;
        self.sectionCount = sectionCount < 1 ? 1 : sectionCount;
    }
    return self;
}

- (void)changeItems:(NSArray *)array {
    if (!array) {
        return;
    }

    self.items = array;
}



- (void)configureCellEditBlock:(DSZTableViewCellEditingBlock)block {
    _editBlock = block;
    _isCanEdit = (block != nil);
}



- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionCount > 0 && self.hasSection) {
        return self.items[indexPath.section][indexPath.row];
    }
    return self.items[indexPath.row];
}


- (void)setSectionCount:(NSUInteger)count {
    _sectionCount = count < 1 ? 1 : count;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.items || self.items.count == 0) {
        return 0;
    }

    if (self.hasSection) {
        NSArray *array = self.items[section];
        if ([array isKindOfClass:[NSArray class]]) {
            return array.count;
        }
        return 0;
    }

    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    if(self.cellIdentifier) {
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                        forIndexPath:indexPath];
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isCanEdit;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.editBlock(indexPath);
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


#pragma mark - 懒加载方法

- (NSArray *)items {

    if (!_items) {
        _items = [[NSArray alloc] init];
    }

    return _items;
}


@end
