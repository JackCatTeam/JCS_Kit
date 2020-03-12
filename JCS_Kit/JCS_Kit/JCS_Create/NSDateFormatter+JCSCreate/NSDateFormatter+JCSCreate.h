//
//  NSDateFormatter+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/12.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (JCSCreate)

@property (nonatomic,copy,readonly) NSDateFormatter*(^jcs_dateFormat)(NSString *dateFormat);

@end
