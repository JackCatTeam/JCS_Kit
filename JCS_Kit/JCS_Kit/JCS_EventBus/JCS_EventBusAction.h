//
//  JCS_EventBusAction.h
//  JCS_EventBus
//
//  Created by 永平 on 2020/3/1.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    JCS_EventBusActionTypeBlock,
    JCS_EventBusActionTypeSelector
} JCS_EventBusActionType;

NS_ASSUME_NONNULL_BEGIN

@interface JCS_EventBusAction : NSObject

@property (nonatomic, copy) NSString *eventId;

@property (nonatomic, assign) JCS_EventBusActionType actionType;

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@property (nonatomic, copy) void(^executeBlock)(id params);

- (BOOL)executeWithParams:(id)params;

@end

NS_ASSUME_NONNULL_END
