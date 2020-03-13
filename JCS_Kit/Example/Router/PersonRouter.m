//
//  PersonRouter.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "PersonRouter.h"
#import "JCS_Kit.h"

@implementation PersonRouter

- (void)setJcs_params:(NSDictionary *)jcs_params {
    [super setJcs_params:jcs_params];
    NSLog(@"--- PersonRouter --- jcs_params = %@",jcs_params);
}

- (NSInteger)say:(NSDictionary*)params {
    void(^completion)(NSError * _Nullable error, id  _Nullable response) = [params valueForKey:@"YLT_ROUTER_COMPLETION"];
    if(completion){
        completion(nil,params);
    }
//    return params;
    return 10;
}

+ (NSDictionary*)classFunc:(NSDictionary*)params {
    NSLog(@"---PersonRouter.classFunc");
    
    void(^completion)(NSError * _Nullable error, id  _Nullable response) = [params valueForKey:@"JCS_ROUTER_COMPLETION"];
    if(completion){
        completion(nil,params);
    }
    
    return params;
}

@end
