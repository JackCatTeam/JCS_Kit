//
//  NSString+JCS_Injection.h
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JCS_Injection)

/// 根据data进行参数注入
+ (NSString*)jcs_injectParams:(NSString*)paramsString data:(id)data;
- (NSString*)jcs_injectParamsWithData:(id)data;

/// 根据data进行常量注入
+ (NSString*)jcs_injectConstants:(NSString*)constantsString data:(id)data;
- (NSString*)jcs_injectConstantsWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
