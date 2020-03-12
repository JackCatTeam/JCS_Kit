//
//  UIScrollView+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UIScrollView+JCSCreate.h"

@implementation UIScrollView (JCSCreate)

- (UIScrollView *(^)(void))jcs_hideVerticalScrollIndicator{
    return ^id(void) {
        self.showsVerticalScrollIndicator = NO;
        return self;
    };
}

- (UIScrollView *(^)(void))jcs_hideHorizontalScrollIndicator{
    return ^id(void) {
        self.showsHorizontalScrollIndicator = NO;
        return self;
    };
}
- (UIScrollView *(^)(void))jcs_hideBothScrollIndicator{
    return ^id(void) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        return self;
    };
}


- (UIScrollView *(^)(id<UIScrollViewDelegate>))jcs_delegate{
    return ^id(id<UIScrollViewDelegate> value) {
        self.delegate = value;
        return self;
    };
}

- (UIScrollView *(^)(CGSize))jcs_contentSize{
    return ^id(CGSize size) {
        self.contentSize = size;
        return self;
    };
}
- (UIScrollView *(^)(UIEdgeInsets))jcs_contentInset{
    return ^id(UIEdgeInsets contentInset) {
        self.contentInset = contentInset;
        return self;
    };
}
- (UIScrollView *(^)(CGPoint))jcs_contentOffset{
    return ^id(CGPoint contentOffset) {
        self.contentOffset = contentOffset;
        return self;
    };
}

- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_Automatic  API_AVAILABLE(ios(11.0)){
    return ^id{
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        return self;
    };
}
- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_ScrollableAxes  API_AVAILABLE(ios(11.0)){
    return ^id{
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
        return self;
    };
}
- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_Never  API_AVAILABLE(ios(11.0)){
    return ^id{
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        return self;
    };
}
- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_Always  API_AVAILABLE(ios(11.0)){
    return ^id{
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        return self;
    };
}
- (UIScrollView *(^)(UIScrollViewContentInsetAdjustmentBehavior behavior))jcs_contentInsetAdjustmentBehavior  API_AVAILABLE(ios(11.0)){
    return ^id(UIScrollViewContentInsetAdjustmentBehavior behavior) {
        self.contentInsetAdjustmentBehavior = behavior;
        return self;
    };
}

@end
