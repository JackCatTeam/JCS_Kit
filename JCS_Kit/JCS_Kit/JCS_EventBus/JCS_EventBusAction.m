//
//  JCS_EventBusAction.m
//  JCS_EventBus
//
//  Created by 永平 on 2020/3/1.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_EventBusAction.h"

@implementation JCS_EventBusAction

- (BOOL)executeWithParams:(id)params {
    if(JCS_EventBusActionTypeBlock == self.actionType){
        if(self.executeBlock){
            self.executeBlock(params);
            return YES;
        }
    } else if(JCS_EventBusActionTypeSelector == self.actionType) {
        if(self.target && self.selector && [self.target respondsToSelector:self.selector]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.selector withObject:params];
            #pragma clang diagnostic pop
            return YES;
        }
    }
    return NO;
}

@end
