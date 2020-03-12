//
//  UIViewController+JCS_Extension.m
//  JCS_Category
//
//  Created by 永平 on 2020/2/8.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UIViewController+JCS_Extension.h"
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"

@implementation UIViewController (JCS_Extension)

- (void)jcs_pushVC:(UIViewController*)vc animated:(BOOL)animated {
    if(vc == nil){
        return;
    }
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController *navVC = self.jcs_currentVC.navigationController;
    if(navVC){
        [navVC pushViewController:vc animated:YES];
    } else {
        navVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.jcs_currentVC presentViewController:navVC animated:animated completion:nil];
    }
}

@end
