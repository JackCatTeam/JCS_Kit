//
//  UIViewController+JCS_Injection.m
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UIViewController+JCS_Injection.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "NSObject+JCS_Injection.h"

@implementation UIViewController (JCS_Injection)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController jcs_swizzleInstanceMethod:@selector(jcs_setup) withMethod:@selector(jcs_injection_setup)];
    });
}

- (void)jcs_injection_setup {
    [self jcs_injection_setup];
    
    //UIViewController则不处理，
    if([self isKindOfClass:UIViewController.class]){
        if([self respondsToSelector:@selector(jcs_propertyInjectEnable)]){
            BOOL inject = [self jcs_propertyInjectEnable];
            if(inject){
                [self jcs_injectPropertiesWithConfigFile:[self jcs_propertyConfigFileName]];
            }
        }
    }
}

@end
