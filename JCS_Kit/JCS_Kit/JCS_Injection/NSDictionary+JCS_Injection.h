//
//  NSDictionary+JCS_Injection.h
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JCS_Injection)

/// 根据data进行参数注入
+ (NSMutableDictionary*)jcs_injectParams:(NSDictionary*)paramsDictionary data:(id)data;
- (NSMutableDictionary*)jcs_injectParamsWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
