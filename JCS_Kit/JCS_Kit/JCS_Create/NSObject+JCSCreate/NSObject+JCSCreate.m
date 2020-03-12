//
//  NSObject+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
// 

#import "NSObject+JCSCreate.h"

@implementation NSObject (JCSCreate)
+ (instancetype)jcs_create{
    return [[self alloc]init];
}

- (NSObject *(^)(NSObject*__strong*))jcs_associated{
    return ^id(NSObject *__strong*pointer) {
        *pointer = self;
        return self;
    };
}
@end
