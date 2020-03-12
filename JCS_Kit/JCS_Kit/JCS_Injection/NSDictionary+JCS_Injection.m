//
//  NSDictionary+JCS_Injection.m
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSDictionary+JCS_Injection.h"
#import "NSArray+JCS_Injection.h"
#import "NSString+JCS_Injection.h"

@implementation NSDictionary (JCS_Injection)

/// 根据data进行参数注入
+ (NSMutableDictionary*)jcs_injectParams:(NSDictionary*)paramsDictionary data:(id)data {
    if(!(data && [paramsDictionary isKindOfClass:NSDictionary.class])){
        return [NSMutableDictionary dictionaryWithDictionary:paramsDictionary];
    }
    NSMutableDictionary *mutableDictionary = nil;
    if([paramsDictionary isKindOfClass:NSMutableDictionary.class]){
        mutableDictionary = (NSMutableDictionary*)paramsDictionary;
    } else {
        mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:paramsDictionary];
    }
    
    for (NSString *key in mutableDictionary.allKeys) {
        id value = mutableDictionary[key];
        id newValue = value;
        if([key isEqualToString:@"items"]){
            NSLog(@"");
        }
        if([value isKindOfClass:NSDictionary.class]){  //NSDictionary，递归参数注入替换
            newValue = [NSDictionary jcs_injectParams:value data:data];
            
        } else if([value isKindOfClass:NSArray.class]){
            newValue = [NSArray jcs_injectParams:value data:data];
            
        } else if([value isKindOfClass:NSString.class]){
            newValue = [NSString jcs_injectParams:value data:data];
        }
        
        mutableDictionary[key] = newValue;
    }
    
    return mutableDictionary;
}
- (NSMutableDictionary*)jcs_injectParamsWithData:(id)data {
    return [[self class] jcs_injectParams:self data:data];
}

@end
