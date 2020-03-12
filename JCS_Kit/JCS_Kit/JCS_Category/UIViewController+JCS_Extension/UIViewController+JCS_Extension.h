//
//  UIViewController+JCS_Extension.h
//  JCS_Category
//
//  Created by 永平 on 2020/2/8.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JCS_Extension)

- (void)jcs_pushVC:(UIViewController*)vc animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
