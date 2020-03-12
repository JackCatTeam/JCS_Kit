//
//  NSArray+JCS_Injection.m
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSArray+JCS_Injection.h"
#import "NSDictionary+JCS_Injection.h"
#import "NSString+JCS_Injection.h"

@implementation NSArray (JCS_Injection)

/// 根据data进行参数注入
+ (NSArray*)jcs_injectParams:(NSArray*)paramsArray data:(id)data {
    if(!(data && [paramsArray isKindOfClass:NSArray.class])){
        return paramsArray;
    }
    
    NSMutableArray *mutableArray = nil;
    if([mutableArray isKindOfClass:NSMutableArray.class]){
        mutableArray = (NSMutableArray*)paramsArray;
    } else {
        mutableArray = [NSMutableArray arrayWithArray:paramsArray];
    }
    
    for (NSInteger index = 0; index < mutableArray.count; index++) {
        id value = mutableArray[index];
        id newValue = value;
        
        if([value isKindOfClass:NSDictionary.class]){
            newValue = [NSDictionary jcs_injectParams:value data:data];
            
        } else if([value isKindOfClass:NSString.class]){
            newValue = [NSString jcs_injectParams:value data:data];
        }
        
        mutableArray[index] = newValue;
    }
    
    return mutableArray;
}
- (NSArray*)jcs_injectParamsWithData:(id)data {
    return [[self class] jcs_injectParams:self data:data];
}

@end
