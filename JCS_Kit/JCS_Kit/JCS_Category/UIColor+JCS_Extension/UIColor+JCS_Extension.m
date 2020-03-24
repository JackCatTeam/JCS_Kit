//
//  UIColor+JCS_Extension.m
//  StarCard
//
//  Created by 永平 on 2020/1/16.
//  Copyright © 2020 youye. All rights reserved.
//

#import "UIColor+JCS_Extension.h"

@implementation UIColor (JCS_Extension)

+ (UIColor*)jcs_randomColor{
    NSInteger aRedValue = arc4random() %255;
    NSInteger aGreenValue = arc4random() %255;
    NSInteger aBlueValue = arc4random() %255;
    return [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];
}

+ (UIColor*)jcs_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor*)jcs_colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha{
    NSInteger hexValue = 0;
    if([hex hasPrefix:@"0x"]){
        hexValue = strtoul([hex UTF8String],0,16);
    } else {
        hexValue = strtoul([[NSString stringWithFormat:@"0x%@",hex] UTF8String],0,16);
    }
    return [self jcs_colorWithHex:hexValue alpha:alpha];
}

@end
