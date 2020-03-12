//
//  UIControl+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/11.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIControl (JCSCreate)

#pragma mark - 布局

//@property (nonatomic,copy,readonly) UIControl*(^jcs_layout)(UIView *superView,void(^)(MASConstraintMaker *make));
//@property (nonatomic,copy,readonly) UIControl*(^jcs_layout2)(UIView *superView,CGRect frame);
//@property (nonatomic,copy,readonly) UIControl*(^jcs_frame)(CGRect frame);
//@property (nonatomic,copy,readonly) UIControl*(^jcs_bounds)(CGRect bounds);
//@property (nonatomic,copy,readonly) UIControl*(^jcs_center)(CGPoint center);

@property (nonatomic,copy,readonly) UIControl*(^jcs_enable)(BOOL flag);
@property (nonatomic,copy,readonly) UIControl*(^jcs_selected)(BOOL flag);
@property (nonatomic,copy,readonly) UIControl*(^jcs_highlighted)(BOOL flag);

@property (nonatomic,copy,readonly) UIControl*(^jcs_contentVerticalAlignment)(UIControlContentVerticalAlignment aignment);
@property (nonatomic,copy,readonly) UIControl*(^jcs_contentHorizontalAlignment)(UIControlContentHorizontalAlignment aignment);

//@property (nonatomic,copy,readonly) UIControl*(^jcs_action)(id target,SEL sel,UIControlEvents events);
//@property (nonatomic,copy,readonly) UIControl*(^jcs_removeAction)(id target,SEL sel,UIControlEvents events);

@property (nonatomic,copy,readonly) UIControl*(^jcs_clickBlock)(void(^)(UIControl*sender));
@property (nonatomic,copy,readonly) UIControl*(^jcs_clickAction)(id target,SEL sel);

//- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
//- (void)removeTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
