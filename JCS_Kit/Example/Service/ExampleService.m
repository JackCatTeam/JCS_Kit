//
//  ExampleService.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleService.h"

@implementation ExampleService

+ (void)requestDataWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize completion:(void(^)(NSArray<ExampleListItem*> *list))completion {
    NSMutableArray *list = [NSMutableArray array];
    pageNum = MAX(1, pageNum);
    NSInteger start = (pageNum - 1) * pageSize;
    NSInteger end = start + pageSize;
    for(NSInteger index = start; index < end; index++) {
        ExampleListItem *item = [[ExampleListItem alloc] init];
        item.title = [NSString stringWithFormat:@"%zd",index];
        [list addObject:item];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(list);
    });
}

@end
