//
//  UIScrollView+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JCSCreate)

@property (nonatomic,copy,readonly) UIScrollView*(^jcs_hideVerticalScrollIndicator)(void);
@property (nonatomic,copy,readonly) UIScrollView*(^jcs_hideHorizontalScrollIndicator)(void);
@property (nonatomic,copy,readonly) UIScrollView*(^jcs_hideBothScrollIndicator)(void);

@property (nonatomic,copy,readonly) UIScrollView*(^jcs_delegate)(id<UIScrollViewDelegate> delegate);

@property (nonatomic,copy,readonly) UIScrollView*(^jcs_contentSize)(CGSize contentSize);
@property (nonatomic,copy,readonly) UIScrollView*(^jcs_contentInset)(UIEdgeInsets contentInset);
@property (nonatomic,copy,readonly) UIScrollView*(^jcs_contentOffset)(CGPoint contentOffset);

- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_Automatic;
- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_ScrollableAxes;
- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_Never;
- (UIScrollView *(^)(void))jcs_contentInsetAdjustmentBehavior_Always;
- (UIScrollView *(^)(UIScrollViewContentInsetAdjustmentBehavior behavior))jcs_contentInsetAdjustmentBehavior ;

@end
