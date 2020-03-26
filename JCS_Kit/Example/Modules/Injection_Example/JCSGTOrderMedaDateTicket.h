//
//  JCSGTOrderMedaDateTicket.h
//  JCS_Kit
//
//  Created by 永平 on 2020/3/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCSGTOrderMedaDateTicket : NSObject


/**
 票款单价
 */
@property (nonatomic,strong) NSNumber *unitPrice;
@property (nonatomic,strong) NSArray<NSString *> *baseInfo;
/**
 票款总额
 */
@property (nonatomic,strong) NSNumber *amount;
/**
 张数
 */
@property (nonatomic,assign) NSInteger quantity;
/**
 使用日期
 */
@property (nonatomic,copy) NSString *useDate;
/**
 资源名称
 */
@property (nonatomic,copy) NSString *rname;
@property (nonatomic,strong) NSArray<NSString *> *refundRule;
/**
 票id
 */
@property (nonatomic,assign) NSInteger id;
/**
 资源ID
 */
@property (nonatomic,copy) NSString *rid;
//@property (nonatomic,strong) NSArray<HKGTOrderMedaDateTravel *> *travels;
@property (nonatomic,copy) NSString *personInfo;
@property (nonatomic,strong) NSValue *rnameSize;
@property (nonatomic,strong) NSValue *baseInfoSize;
@property (nonatomic,strong) NSString *customeBaseInfo;
/**
 二维码
 */
@property (nonatomic,copy) NSString *imgUrl;
/**
 二维码辅助码
 */
@property (nonatomic,copy) NSString *voucherCode;
/**
 入园凭证,数字验证码
 */
@property (nonatomic,copy) NSString *admissionCertificate;
/**
 销货单ID
 */
@property (nonatomic,copy) NSString *itemId;


@end

NS_ASSUME_NONNULL_END
