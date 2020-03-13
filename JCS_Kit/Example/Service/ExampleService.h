//
//  ExampleService.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExampleListItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleService : NSObject

+ (void)requestDataWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize completion:(void(^)(NSArray<ExampleListItem*> *list))completion;

@end

NS_ASSUME_NONNULL_END
