//
//  HKGTOrderMedaDateTicket.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "HKGTOrderMedaDateTicket.h"

@implementation HKGTOrderMedaDateTicket

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"baseInfo" : @"NSString",
             @"refundRule": @"NSString"
             };
}

@end
