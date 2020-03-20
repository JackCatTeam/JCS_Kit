//
//  JCS_EventBus.m
//  JCS_EventBus
//
//  Created by 永平 on 2020/3/1.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_EventBus.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "JCS_Router.h"
#import "JCS_EventBusAction.h"
#import "JCS_EventBusQueue.h"

@interface JCS_EventBus()
@property (nonatomic, strong) JCS_EventBusQueue *busQueue;
/** 时间路由表 **/
@property (nonatomic, strong) NSMutableDictionary *eventRouterMap;
@end

@implementation JCS_EventBus

/**
 添加路由表,如map已有的eventID，post时将不在执行block和action
*/
- (void)addEventRouterMap:(NSString* _Nonnull)eventId router:(NSString* _Nonnull)router {
    if(eventId.jcs_isValid && router.jcs_isValid){
        self.eventRouterMap[eventId] = router;
    }
}
- (void)addEventRouterMapFromDictionary:(NSDictionary* _Nonnull)map {
    if(map){
        [self.eventRouterMap addEntriesFromDictionary:map];
    }
}

- (void)registerAction:(NSString*)eventId executeBlock:(void(^)(id params))executeBlock {
    [self.busQueue registerAction:eventId executeBlock:executeBlock];
}

- (void)registerAction:(NSString*)eventId target:(id)target selector:(SEL)selector {
    [self.busQueue registerAction:eventId target:target selector:selector];
}

- (void)removeAction:(NSString*)eventId {
    [self.busQueue removeActionWithEventId:eventId];
}

- (void)postEvent:(NSString*)eventId params:(id)params {
    
    //匹配到路由表
    NSString *router = self.eventRouterMap[eventId];
    if(router.jcs_isValid){
        [JCS_RouterCenter router2Url:router args:params completion:nil];
        return;
    }
    
    //其次block、Action
    NSArray<JCS_EventBusAction*> *actionList = [self.busQueue getEventsWithId:eventId];
    for (JCS_EventBusAction *action in actionList) {
        if(![action executeWithParams:params]){
            //执行失败，则将action移除
            [self.busQueue removeActionWithAction:action];
        }
    }
}

JCS_LAZY(JCS_EventBusQueue, busQueue)
JCS_LAZY(NSMutableDictionary, eventRouterMap)

@end
