//
//  NSObject+JCS_Extension.h
//  JCS_Category
//
//  Created by 永平 on 2020/3/4.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JCS_Extension)

/// 存储对象
- (void)jcs_saveWithKey:(NSString*)key;
/// 加载已存储对象
+ (instancetype)jcs_loadWithKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
