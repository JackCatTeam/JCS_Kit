//
//  UIFont+JCS_Extension.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/24.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UIFont+JCS_Extension.h"
#import "JCS_BaseLib.h"

@implementation UIFont (JCS_Extension)

+ (UIFont *)jcs_mediumFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"PingFangSC-Medium" fontSize:fontSize];
}
+ (UIFont *)jcs_lightFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"PingFangSC-Light" fontSize:fontSize];
}
+ (UIFont *)jcs_semiboldFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"PingFangSC-Semibold" fontSize:fontSize];
}
+ (UIFont *)jcs_thinFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"PingFangSC-Thin" fontSize:fontSize];
}
+ (UIFont *)jcs_regularFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"PingFangSC-Regular" fontSize:fontSize];
}
+ (UIFont *)jcs_stRegularFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"FZQingKeBenYueSongS-R-GB" fontSize:fontSize];
}
+ (UIFont *)jcs_politicaBoldFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"Politica-Bold" fontSize:fontSize];
}
+ (UIFont *)jcs_sfBoldFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@".HelveticaNeueDeskInterface-Bold" fontSize:fontSize];
}
+ (UIFont *)jcs_sfRegularFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@".HelveticaNeueDeskInterface-Regular" fontSize:fontSize];
}
+ (UIFont *)jcs_dinBoldFont:(CGFloat)fontSize {
    return [self jcs_FontFamilyName:@"DINAlternate-bold" fontSize:fontSize];
}
+ (UIFont *)jcs_FontFamilyName:(NSString*)familyName fontSize:(CGFloat)fontSize {
    if (JCS_iOS9Later) {
        UIFont *font = [UIFont fontWithName:familyName size:fontSize];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:fontSize];

}

@end
