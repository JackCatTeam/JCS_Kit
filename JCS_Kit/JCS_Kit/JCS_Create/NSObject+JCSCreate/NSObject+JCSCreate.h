//
//  NSObject+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JCSCreate)

+ (instancetype)jcs_create;

/**
 关联
 */
@property (nonatomic,copy,readonly) NSObject*(^jcs_associated)(NSObject *__strong*pointer);

@end
