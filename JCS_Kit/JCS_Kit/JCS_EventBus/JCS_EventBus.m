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
#import "JCS_EventBusAction.h"
#import "JCS_EventBusQueue.h"

@interface JCS_EventBus()
@property (nonatomic, strong) JCS_EventBusQueue *busQueue;
@end

@implementation JCS_EventBus

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
    NSArray<JCS_EventBusAction*> *actionList = [self.busQueue getEventsWithId:eventId];
    for (JCS_EventBusAction *action in actionList) {
        if(![action executeWithParams:params]){
            //执行失败，则将action移除
            [self.busQueue removeActionWithAction:action];
        }
    }
}

JCS_LAZY(JCS_EventBusQueue, busQueue)

@end
