//
//  UISegmentedControl+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/17.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UISegmentedControl+JCSCreate.h"

@implementation UISegmentedControl (JCSCreate)

+ (instancetype)createWithItems:(NSArray*)items{
    return [[self alloc]initWithItems:items];
}

- (UISegmentedControl *(^)(NSInteger))jcs_selectedSegmentIndex{
    return ^id(NSInteger selectedSegmentIndex) {
        self.selectedSegmentIndex = selectedSegmentIndex;
        return self;
    };
}

- (UISegmentedControl *(^)(UIColor *))jcs_tintColor{
    return ^id(UIColor *color) {
        self.tintColor = color;
        return self;
    };
}

@end
