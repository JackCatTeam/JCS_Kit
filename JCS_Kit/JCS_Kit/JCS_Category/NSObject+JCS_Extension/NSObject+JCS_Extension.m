//
//  NSObject+JCS_Extension.m
//  JCS_Category
//
//  Created by 永平 on 2020/3/4.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSObject+JCS_Extension.h"
#import "JCS_BaseLib.h"
#import "NSString+JCS_Extension.h"
#import <FastCoding/FastCoder.h>

@implementation NSObject (JCS_Extension)

- (void)jcs_saveWithKey:(NSString*)key {
    NSAssert(key.jcs_isValid, @"jcs_saveWithKey key 不能为空");
    if(key.jcs_isValid){
        NSData *data = [FastCoder dataWithRootObject:self];
        JCS_UserDefaults_SetObject(data, key);
    }
}

+ (instancetype)jcs_loadWithKey:(NSString*)key {
    NSAssert(key.jcs_isValid, @"jcs_saveWithKey key 不能为空");
    if(key.jcs_isValid){
        NSData *obj = JCS_UserDefaults_GetObject(key);
        if(obj){
            return [FastCoder objectWithData:obj];
        }
    }
    return nil;
}

@end
