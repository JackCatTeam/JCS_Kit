//
//  TestRouter.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/20.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "TestRouter.h"
#import "JCS_Kit.h"

@implementation TestRouter

- (NSString*)getMessage{
    return @"你好 Message";
}

//- (void)showLoginVC {
//    [self.jcs_currentVC jcs_pushVC:[[Login alloc] init] animated:YES];
//}

- (void)hello:(NSDictionary*)params {
    NSLog(@"-TestRouter-hello-%@",params);
}

- (void)sayHello:(NSDictionary*)params {
    void(^completion)(NSError*error,NSDictionary*response) = [params valueForKey:JCS_ROUTER_COMPLETION];
}

+ (void)sayHello:(NSDictionary*)params {
    
}

//- (void)setJcs_params:(NSDictionary*)params {
//    NSLog(@"");
//}

@end
