//
//  JCS_EventBus.h
//  JCS_EventBus
//
//  Created by 永平 on 2020/3/1.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_EventBus : NSObject

- (void)registerAction:(NSString* _Nonnull)eventId executeBlock:(void(^ _Nonnull)(id params))executeBlock;
- (void)registerAction:(NSString* _Nonnull)eventId target:(id _Nonnull)target selector:(SEL _Nonnull)selector;
- (void)removeAction:(NSString* _Nonnull)eventId;
- (void)postEvent:(NSString* _Nonnull)eventId params:(id _Nullable)params;

@end

NS_ASSUME_NONNULL_END
