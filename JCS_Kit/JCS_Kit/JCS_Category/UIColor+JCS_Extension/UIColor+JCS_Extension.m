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

@end
