//
//  GoodsModel.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (CGSize)jcs_getCellSize {
    return CGSizeMake(80,(arc4random_uniform(100) + 20));
}

//- (NSString*)jcs_getClickRouter {
//    return @"jcs://PersonRouter/say:?name=李四";
//}

@end
