//
//  JCS_EventBusQueue.h
//  JCS_EventBus
//
//  Created by 永平 on 2020/3/1.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JCS_EventBusAction;

NS_ASSUME_NONNULL_BEGIN

@interface JCS_EventBusQueue : NSObject

- (void)registerAction:(NSString*)eventId executeBlock:(void(^)(id params))executeBlock;
- (void)registerAction:(NSString*)eventId target:(id)target selector:(SEL)selector ;
- (void)removeActionWithAction:(JCS_EventBusAction*)action;
- (void)removeActionWithEventId:(NSString*)eventId;

- (NSMutableArray<JCS_EventBusAction*> *)getEventsWithId:(NSString*)eventId;

@end

NS_ASSUME_NONNULL_END
