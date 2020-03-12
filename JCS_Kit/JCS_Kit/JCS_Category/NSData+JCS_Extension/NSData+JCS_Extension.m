//
//  NSData+JCS_Extension.m
//  JCS_Category
//
//  Created by 永平 on 2020/2/8.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSData+JCS_Extension.h"

@implementation NSData (JCS_Extension)

///是否是JSON对象
- (BOOL)isJSONData {
    return [NSJSONSerialization JSONObjectWithData:self options:0 error:NULL] ? YES : NO;
}

@end
