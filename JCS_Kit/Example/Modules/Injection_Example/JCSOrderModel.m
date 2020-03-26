//
//  JCSOrderModel.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCSOrderModel.h"

@implementation JCSOrderModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"tickets" : @"HKGTOrderMedaDateTicket",
//             @"travels" : @"HKGTOrderMedaDateTravel",
//             @"refunds":@"HKGTRefundProgressModel"
             };
}

@end
