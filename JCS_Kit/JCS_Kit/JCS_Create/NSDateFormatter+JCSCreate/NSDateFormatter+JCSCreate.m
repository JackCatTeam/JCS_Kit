//
//  NSDateFormatter+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/12.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "NSDateFormatter+JCSCreate.h"

@implementation NSDateFormatter (JCSCreate)

- (NSDateFormatter *(^)(NSString *))jcs_dateFormat{
    return ^id(NSString *dateFormat) {
        self.dateFormat = dateFormat;
        return self;
    };
}

@end
