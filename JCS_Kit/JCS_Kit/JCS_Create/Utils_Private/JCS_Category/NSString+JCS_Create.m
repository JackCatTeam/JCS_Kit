//
//  NSString+JCS_Create.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSString+JCS_Create.h"
#import "JCS_Category.h"

@implementation NSString (JCS_Create)

+ (CGSize)jcs_stringToSize:(NSString*)value {
    if(value.jcs_isValid && [value containsString:@","]){
        NSArray<NSString *> *comps = [value componentsSeparatedByString:@","];
        if(comps.count > 1 && comps[0].jcs_isValid && comps[1].jcs_isValid){
            CGFloat value1 = [NSString jcs_stringToFloat:comps[0]];
            CGFloat value2 = [NSString jcs_stringToFloat:comps[1]];
            return CGSizeMake(value1, value2);
        }
    }
    return CGSizeZero;
}
- (CGSize)jcs_toSize {
    return [[self class] jcs_stringToSize:self];
}

+ (NSInteger)jcs_stringToInteger:(NSString*)value {
    if(value.jcs_isValid){
        return [[NSString jcs_caculate:value] integerValue];
    }
    return 0;
}
- (NSInteger)jcs_toInteger {
    return [[self class] jcs_stringToInteger:self];
}

+ (NSInteger)jcs_stringToFloat:(NSString*)value {
    if(value.jcs_isValid){
        return [[NSString jcs_caculate:value] floatValue];
    }
    return 0;
}
- (NSInteger)jcs_toFloat {
    return [[self class] jcs_stringToFloat:self];
}

+ (UIEdgeInsets)jcs_stringToInsets:(NSString*)value {
    if(value.jcs_isValid && [value containsString:@","]){
        NSArray<NSString *> *comps = [value componentsSeparatedByString:@","];
        if(comps.count > 3 && comps[0].jcs_isValid && comps[1].jcs_isValid && comps[2].jcs_isValid && comps[3].jcs_isValid){
            CGFloat value1 = [NSString jcs_stringToFloat:comps[0]];
            CGFloat value2 = [NSString jcs_stringToFloat:comps[1]];
            CGFloat value3 = [NSString jcs_stringToFloat:comps[2]];
            CGFloat value4 = [NSString jcs_stringToFloat:comps[3]];
            return UIEdgeInsetsMake(value1, value2,value3, value4);
        }
    }
    return UIEdgeInsetsZero;
}
- (UIEdgeInsets)jcs_toInsets {
    return [[self class] jcs_stringToInsets:self];
}

@end
