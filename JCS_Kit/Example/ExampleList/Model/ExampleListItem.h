//
//  ExampleListItem.h
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ExampleListItem(__TITLE__,__CLAZZ__) [ExampleListItem itemWithTitle:__TITLE__ jumpClass:__CLAZZ__]

NS_ASSUME_NONNULL_BEGIN

@interface ExampleListItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *jumpClass;

+ (instancetype)itemWithTitle:(NSString*)title jumpClass:(NSString*)jumpClass;

@end

NS_ASSUME_NONNULL_END
