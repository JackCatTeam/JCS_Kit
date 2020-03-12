//
//  JCS_RouterCenter+YLT.m
//  JCS_Router
//
//  Created by 永平 on 2020/2/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_RouterCenter+YLT.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"

@implementation JCS_RouterCenter (YLT)

+ (id)ylt_router2Url:(NSString * _Nonnull )url args:(id _Nullable)args completion:(void(^ _Nullable)(NSError * _Nullable error, id  _Nullable response))completion {

    id target = NSClassFromString(@"YLT_RouterManager");
    SEL action = NSSelectorFromString(@"ylt_routerToURL:arg:completion:");
    
    if(target && [target respondsToSelector:action]){
//        [YLT_RouterManager ylt_routerToURL:url arg:args completion:completion];
        NSMethodSignature *methodSignature = [target methodSignatureForSelector:action];
        if(methodSignature == nil) {
            return nil;
        }
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setArgument:&url atIndex:2];
        [invocation setArgument:&args atIndex:3];
        [invocation setArgument:&completion atIndex:4];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];

        __autoreleasing id result;
        [invocation getReturnValue:&result];
        return result;
    }
    
    JCS_LogInfo(@"ylt://协议需要YLT_BaseLib支持，请添加 pod 'YLT_BaseLib'");
    return nil;
}

@end
