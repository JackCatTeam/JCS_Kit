//
//  JCS_EventBusQueue.m
//  JCS_EventBus
//
//  Created by 永平 on 2020/3/1.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_EventBusQueue.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "JCS_EventBusAction.h"

@interface JCS_EventBusQueue()
@property (nonatomic, strong) NSMutableArray<JCS_EventBusAction*> *eventQueue;
@end

@implementation JCS_EventBusQueue

- (void)registerAction:(NSString*)eventId executeBlock:(void(^)(id params))executeBlock {
    if(!(eventId.jcs_isValid && executeBlock)){
        return;
    }
    JCS_EventBusAction *action = [[JCS_EventBusAction alloc] init];
    action.actionType = JCS_EventBusActionTypeBlock;
    action.eventId = eventId;
    action.executeBlock = executeBlock;
    [self.eventQueue addObject:action];
}

- (void)registerAction:(NSString*)eventId target:(id)target selector:(SEL)selector {
    if(!(eventId.jcs_isValid && target && selector)){
        return;
    }
    JCS_EventBusAction *action = [[JCS_EventBusAction alloc] init];
    action.actionType = JCS_EventBusActionTypeSelector;
    action.eventId = eventId;
    action.target = target;
    action.selector = selector;
    [self.eventQueue addObject:action];
}

- (void)removeActionWithAction:(JCS_EventBusAction*)action {
    [self.eventQueue removeObject:action];
}
- (void)removeActionWithEventId:(NSString*)eventId {
    for (JCS_EventBusAction *action in self.eventQueue) {
        if([action.eventId isEqualToString:eventId]){
            [self.eventQueue removeObject:action];
            break;
        }
    }
}

- (NSMutableArray<JCS_EventBusAction*> *)getEventsWithId:(NSString*)eventId {
    NSMutableArray *list = [NSMutableArray array];
    //遍历获取Action
    for (JCS_EventBusAction *action in self.eventQueue) {
        if([action.eventId isEqualToString:eventId]){
            [list addObject:action];
        }
    }
    return list;
}

#pragma mark - 懒加载

JCS_LAZY(NSMutableArray, eventQueue)

@end
