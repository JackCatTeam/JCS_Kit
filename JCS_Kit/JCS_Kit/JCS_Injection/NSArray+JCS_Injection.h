//
//  NSArray+JCS_Injection.h
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JCS_Injection)

/// 根据data进行参数注入
+ (NSArray*)jcs_injectParams:(NSArray*)paramsArray data:(id)data;
- (NSArray*)jcs_injectParamsWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
