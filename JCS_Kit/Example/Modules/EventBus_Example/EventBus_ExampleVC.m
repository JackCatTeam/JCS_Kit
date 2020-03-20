//
//  EventBus_ExampleVC.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "EventBus_ExampleVC.h"
#import "JCS_Kit.h"

#define EVENT_ID @"EVENT_ID"

@interface EventBus_ExampleVC ()
@property (nonatomic, strong) JCS_EventBus *eventBus;
@end

@implementation EventBus_ExampleVC

- (void)jcs_setup {
    self.view.jcs_whiteBackgroundColor();
    
//    [self.eventBus addEventRouterMap:EVENT_ID router:@"jcs://TestRouter/hello:"];
    [self.eventBus addEventRouterMapFromDictionary:@{
        EVENT_ID:@"jcs://TestRouter/hello:"
    }];
    
    [self.eventBus registerAction:EVENT_ID executeBlock:^(id params){
        NSLog(@"post 1 params = %@",params);
    }];
    [self.eventBus registerAction:EVENT_ID executeBlock:^(id params){
        NSLog(@"post 2 params = %@",params);
    }];
    [self.eventBus registerAction:EVENT_ID target:self selector:@selector(eventHandler:)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.eventBus postEvent:EVENT_ID params:@{
        @"goodsId":@"1o1o12i1i2"
    }];
}

- (void)eventHandler:(id)params {
    NSLog(@"post 3 params = %@",params);
}

JCS_LAZY(JCS_EventBus, eventBus)

@end
