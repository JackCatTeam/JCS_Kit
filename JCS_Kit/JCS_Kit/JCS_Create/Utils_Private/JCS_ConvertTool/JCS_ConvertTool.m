//
//  JCS_ConvertTool.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_ConvertTool.h"
#import "JCS_Category.h"

#import "NSString+JCS_Create.h"
#import "NSArray+JCS_Create.h"
#import "NSDictionary+JCS_Create.h"

@implementation JCS_ConvertTool

+ (CGSize)valueToSize:(id)value {
    if(value){
        if([value isKindOfClass:NSString.class]){ //字符串
            return [((NSString*)value) jcs_toSize];
        } else if([value isKindOfClass:NSArray.class]){ //数组
            return [NSArray jcs_arrayToSize:value];
        } else if([value isKindOfClass:NSDictionary.class]){ //字典
            return [NSDictionary jcs_dictionaryToSize:value];
        }
    }
    return CGSizeZero;
}

+ (NSInteger)valueToInteger:(id)value {
    if(value){
        if([value isKindOfClass:NSString.class]){ // 字符串
            return [NSString jcs_stringToInteger:value];
        } else if([value isKindOfClass:NSNumber.class]){ //数字
            return [value integerValue];
        }
    }
    return 0;
}
+ (CGFloat)valueToFloat:(id)value {
    if(value){
        if([value isKindOfClass:NSString.class]){ // 字符串
            return [NSString jcs_stringToFloat:value];
        } else if([value isKindOfClass:NSNumber.class]){ //数字
            return [value floatValue];
        }
    }
    return 0;
}

+ (UIEdgeInsets)valueToInsets:(id)value {
    if(value){
        if([value isKindOfClass:NSString.class]){ // 字符串
            return [NSString jcs_stringToInsets:value];
        } else if([value isKindOfClass:NSArray.class]){ //数组
            return [NSArray jcs_arrayToInsets:value];
        } else if([value isKindOfClass:NSDictionary.class]){ //字典
            return [NSDictionary jcs_dictionaryToInsets:value];
        }
    }
    return UIEdgeInsetsZero;
}
@end
