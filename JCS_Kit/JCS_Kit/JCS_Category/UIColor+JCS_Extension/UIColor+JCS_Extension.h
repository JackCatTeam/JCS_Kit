//
//  UIColor+JCS_Extension.h
//  StarCard
//
//  Created by 永平 on 2020/1/16.
//  Copyright © 2020 youye. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JCS_Extension)

+ (UIColor*)jcs_randomColor;
+ (UIColor*)jcs_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor*)jcs_colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
