//
//  UIView+JCS_Swizzle.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JCS_Swizzle)

/// 设置UI
- (void)jcs_setupUI;
/// 绑定信号
- (void)jcs_bindingSignal;

@end

NS_ASSUME_NONNULL_END
