//
//  UIViewController+JCS_Swizzle.h
//  JCS_Category
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+JCS_Swizzle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JCS_Swizzle)

/// 设置控制器
- (void)jcs_setup ;
/// 注册通知
- (void)jcs_registerNotifications ;
/// 绑定信号
- (void)jcs_bindingSignal ;
/// 网络请求
- (void)jcs_request ;

@end

NS_ASSUME_NONNULL_END
