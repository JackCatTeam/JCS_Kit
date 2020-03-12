//
//  JCS_RouterCenter+YLT.h
//  JCS_Router
//
//  Created by 永平 on 2020/2/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_RouterCenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_RouterCenter (YLT)


+ (id)ylt_router2Url:(NSString * _Nonnull )url args:(NSDictionary * _Nullable)args completion:(void(^ _Nullable)(NSError * _Nullable error, id  _Nullable response))completion;

@end

NS_ASSUME_NONNULL_END
