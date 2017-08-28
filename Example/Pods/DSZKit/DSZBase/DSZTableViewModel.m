//
//  DSZTableViewModel.m
//  MSX
//
//  Created by 胡浩 on 2017/6/22.
//  Copyright © 2017年 DSZ. All rights reserved.
//

#import "DSZTableViewModel.h"
#import "DSZKit.h"

@interface DSZTableViewModel ()

@property (nonatomic, strong, readwrite) NSArray *items;
@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;
@property (nonatomic, strong, readwrite) NSArray *dataSource;

@end

@implementation DSZTableViewModel


#pragma mark - 重写父类方法

- (void)DSZ_init {

    self.currentPage = 1;
    self.pageSize = 10;

    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];

    [[self.requestRemoteDataCommand.executionSignals switchToLatest]
        subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self handlerResponse:x];
        }];

    [self.requestRemoteDataCommand.errors  subscribeNext:^(NSError *error) {
        @strongify(self)
        [self handlerError:error];
    }];

}

#pragma mark - 内部方法


- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

- (void)handlerResponse:(NSDictionary *)response {
    DAssert(0)
}


- (void)handlerError:(NSError *)error {
    DSZLog(@"error ===== %@", error);
}

- (void)addDataSource:(NSArray *)items {
    if (!items || items.count == 0) {
        return;
    }
    

    if (self.dataSource == nil) {
        self.dataSource = items;
        return;
    }

    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataSource];
    if (self.currentPage == 1) {
        [tempArray removeAllObjects];
    }
    [tempArray addObjectsFromArray:items];

    self.dataSource = tempArray;
}

- (void)clearDataSource {
    _dataSource = @[];
}

#pragma mark - 懒加载方法





@end


