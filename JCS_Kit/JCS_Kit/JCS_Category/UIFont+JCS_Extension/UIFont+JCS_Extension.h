//
//  UIFont+JCS_Extension.h
//  JCS_Kit
//
//  Created by 永平 on 2020/3/24.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (JCS_Extension)

+ (UIFont *)jcs_mediumFont:(CGFloat)fontSize;
+ (UIFont *)jcs_lightFont:(CGFloat)fontSize;
+ (UIFont *)jcs_semiboldFont:(CGFloat)fontSize;
+ (UIFont *)jcs_thinFont:(CGFloat)fontSize;
+ (UIFont *)jcs_regularFont:(CGFloat)fontSize;
+ (UIFont *)jcs_stRegularFont:(CGFloat)fontSize;
+ (UIFont *)jcs_politicaBoldFont:(CGFloat)fontSize;
+ (UIFont *)jcs_sfBoldFont:(CGFloat)fontSize;
+ (UIFont *)jcs_sfRegularFont:(CGFloat)fontSize;
+ (UIFont *)jcs_dinBoldFont:(CGFloat)fontSize;
+ (UIFont *)jcs_FontFamilyName:(NSString*)familyName fontSize:(CGFloat)fontSize;


@end

NS_ASSUME_NONNULL_END
