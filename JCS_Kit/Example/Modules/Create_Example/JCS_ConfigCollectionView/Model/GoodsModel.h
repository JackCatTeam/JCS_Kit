//
//  GoodsModel.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCS_Create.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsModel : NSObject<JCS_CollectionViewItemProtocol>
/** <#备注#> **/
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
