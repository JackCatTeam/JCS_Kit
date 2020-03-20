//
//  UIViewController+JCS_Swizzle.m
//  JCS_Category
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UIViewController+JCS_Swizzle.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"

@implementation UIViewController (JCS_Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController jcs_swizzleInstanceMethod:@selector(viewDidLoad) withMethod:@selector(jcs_UIViewController_viewDidLoad)];
    });
}

- (void)jcs_UIViewController_viewDidLoad {
    [self jcs_UIViewController_viewDidLoad];
    
    [self jcs_setup];
    [self jcs_bindingSignal];
    [self jcs_registerNotifications];
    [self jcs_request];
}

/// 设置控制器
- (void)jcs_setup {}
/// 注册通知
- (void)jcs_registerNotifications {}
/// 绑定信号
- (void)jcs_bindingSignal {}
/// 网络请求
- (void)jcs_request {}

@end
