//
//  UISegmentedControl+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/17.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (JCSCreate)

+ (instancetype)createWithItems:(NSArray*)items;

@property (nonatomic,copy,readonly) UISegmentedControl*(^jcs_selectedSegmentIndex)(NSInteger selectedSegmentIndex);
@property (nonatomic,copy,readonly) UISegmentedControl*(^jcs_tintColor)(UIColor *tintColor);

@end
