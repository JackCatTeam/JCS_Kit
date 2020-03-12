//
//  UINavigationController+JCS_Push.h
//  Classes
//
//  Created by 永平 on 2020/1/29.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (JCS_Push)

/**
 每个项目导航栏都会自定义，不考虑在这封装
 */
- (void)jcs_pushVC:(UIViewController*)targetVC animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
