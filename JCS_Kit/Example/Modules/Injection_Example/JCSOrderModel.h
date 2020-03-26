//
//  JCSOrderModel.h
//  JCS_Kit
//
//  Created by 永平 on 2020/3/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HKGTOrderMedaDateTicket.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCSOrderModel : NSObject

@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy) NSString *jid;
@property (nonatomic, assign) double couponFee;
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,strong) NSNumber *actualPayAmount;
/**
 订单名称
 */
@property (nonatomic,copy) NSString *name;
/**
 订单金额
 */
@property (nonatomic,strong) NSNumber *amount;
/**
 订单状态 '0:未支付，1:已支付，待出票, 2:订单超时（未支付），，20:提交携程下单成功,21 提交携程下单失败, 22携程确认中, 23携程已确认,24已确认/部分退，25携程退订中，26携程退订
 */
@property (nonatomic,assign) NSInteger status;
/**
 下单时间
 */
@property (nonatomic,assign) NSInteger created;
/**
 支付时间
 */
@property (nonatomic,assign) NSInteger payTime;
/**
 使用时间
 */
@property (nonatomic,copy) NSString *useTime;
/**
 预定张数
 */
@property (nonatomic,assign) NSInteger nums;
/**
 接收短信手机
 */
@property (nonatomic,copy) NSString *contactPhone;
@property (nonatomic,copy) NSString *contactName;
@property (nonatomic,strong) NSArray<HKGTOrderMedaDateTicket *> *tickets;
//@property (nonatomic,strong) NSArray<HKGTOrderMedaDateTravel *> *travels;
//@property (nonatomic,strong) NSArray<HKGTRefundProgressModel *> *refunds;
@property (nonatomic,copy) NSString *statusName;
@property (nonatomic,strong)UIColor *statusColor;
/**
 是否是一单一人
 */
@property (nonatomic,assign) BOOL isOrderPerson;
@property (nonatomic, copy) NSString *restFeeList;


@end

NS_ASSUME_NONNULL_END
