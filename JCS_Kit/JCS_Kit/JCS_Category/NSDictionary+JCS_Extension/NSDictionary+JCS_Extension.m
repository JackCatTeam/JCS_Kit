//
//  NSDictionary+JCS_Extension.m
//  JCS_Category
//
//  Created by 永平 on 2020/2/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSDictionary+JCS_Extension.h"
#import "NSString+JCS_Extension.h"

@implementation NSDictionary (JCS_Extension)

/// 获取模型类型
- (Class)jcs_getModelClass {
    NSString *className = [self valueForKey:@"__class"];
    if(!className.jcs_isValid){
        className = [self valueForKey:@"class"];
    }
    if(!className.jcs_isValid){
        return nil;
    }
    return NSClassFromString(className);
}

/// bool key 是否为 true
- (BOOL)jcs_isBoolTrue:(NSString*)key {
    NSString *value = [self valueForKey:key];
    if(value){
        if([value isKindOfClass:NSString.class] && ( [value integerValue] > 0 || [value isEqualToString:@"true"])){
            return YES;
        } else if([value isKindOfClass:NSNumber.class] && [(NSNumber*)value integerValue] > 0){
            return YES;
        }
    }
    return NO;
}

@end
