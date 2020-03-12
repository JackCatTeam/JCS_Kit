//
//  NSString+JCS_MathParser.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JCS_MathParser)

/// 计算数学表达式
+ (NSString *)jcs_caculate:(NSString *)formulaString;
- (NSString *)jcs_caculate;

@end

NS_ASSUME_NONNULL_END
