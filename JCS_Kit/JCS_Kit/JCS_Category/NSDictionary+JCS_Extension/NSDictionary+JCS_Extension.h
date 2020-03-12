//
//  NSDictionary+JCS_Extension.h
//  JCS_Category
//
//  Created by 永平 on 2020/2/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JCS_Extension)

/// 获取模型类型
- (Class)jcs_getModelClass;

/// bool key 是否为 true
- (BOOL)jcs_isBoolTrue:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
