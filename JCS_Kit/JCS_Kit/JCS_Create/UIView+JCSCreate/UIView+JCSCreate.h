//
//  UIView+JCSCreate.h
//  JCCreate
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "JCS_Category.h"
#import "JCS_EventBus.h"

@interface UIView (JCSCreate)

#pragma mark - 实例化

/**
 实例化对象
 */

+ (instancetype)createWithFrame:(CGRect)frame;
+ (instancetype)createWithCoder:(NSCoder *)coder;

+ (instancetype)jcs_createAndLayout:(id)superView frame:(CGRect)frame;
+ (instancetype)jcs_createAndLayout:(id)superView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock;

#pragma mark - 布局

@property (nonatomic,copy,readonly) UIView*(^jcs_layout)(id superView,void(^)(MASConstraintMaker *make));
@property (nonatomic,copy,readonly) UIView*(^jcs_layoutWithFrame)(id superView,CGRect frame);
@property (nonatomic,copy,readonly) UIView*(^jcs_frame)(CGRect frame);
@property (nonatomic,copy,readonly) UIView*(^jcs_bounds)(CGRect bounds);
@property (nonatomic,copy,readonly) UIView*(^jcs_center)(CGPoint center);

#pragma mark - 属性设置

@property (nonatomic,copy,readonly) UIView*(^jcs_tag)(NSInteger tag);

@property (nonatomic,copy,readonly) UIView*(^jcs_backgroundColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIView*(^jcs_backgroundColorHex)(NSInteger hex);
@property (nonatomic,copy,readonly) UIView*(^jcs_randomBackgroundColor)(void);
@property (nonatomic,copy,readonly) UIView*(^jcs_whiteBackgroundColor)(void);
@property (nonatomic,copy,readonly) UIView*(^jcs_clearBackgroundColor)(void);

@property (nonatomic,copy,readonly) UIView*(^jcs_contentMode)(UIViewContentMode mode);
@property (nonatomic,copy,readonly) UIView*(^jcs_hidden)(BOOL hidden);
@property (nonatomic,copy,readonly) UIView*(^jcs_userInteractionEnabled)(BOOL userInteractionEnabled);

@property (nonatomic,copy,readonly) UIView*(^jcs_clipsToBounds)(BOOL clipsToBounds);
@property (nonatomic,copy,readonly) UIView*(^jcs_alpha)(CGFloat alpha);
@property (nonatomic,copy,readonly) UIView*(^jcs_opaque)(BOOL opaque);
//@property (nonatomic,copy,readonly) UIView*(^jcs_contentStretch)(CGRect contentStretch);
@property (nonatomic,copy,readonly) UIView*(^jcs_tintColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIView*(^jcs_tintAdjustmentMode)(UIViewTintAdjustmentMode tintAdjustmentMode);

#pragma mark - 顺序转换

@property (nonatomic,copy,readonly) UIView*(^jcs_bringToFront)(void);
@property (nonatomic,copy,readonly) UIView*(^jcs_sendToBack)(void);

#pragma mark - CALayer相关

@property (nonatomic,copy,readonly) UIView*(^jcs_cornerRadius)(CGFloat radius);

@property (nonatomic,copy,readonly) UIView*(^jcs_borderColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIView*(^jcs_borderColorHex)(NSInteger hex);

@property (nonatomic,copy,readonly) UIView*(^jcs_borderWidth)(CGFloat width);

@property (nonatomic,copy,readonly) UIView*(^jcs_shadowColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIView*(^jcs_shadowColorHex)(NSInteger hex);

@property (nonatomic,copy,readonly) UIView*(^jcs_shadowPath)(UIBezierPath *path);
@property (nonatomic,copy,readonly) UIView*(^jcs_shadowOffset)(CGSize offset);
@property (nonatomic,copy,readonly) UIView*(^jcs_shadowRadius)(CGFloat radius);
@property (nonatomic,copy,readonly) UIView*(^jcs_shadowOpacity)(CGFloat opacity);

#pragma mark - 事件

@property (nonatomic,copy,readonly) UIView*(^jcs_clickBlock)(void(^)(UIView*sender));
@property (nonatomic,copy,readonly) UIView*(^jcs_clickAction)(id target,SEL sel);


#pragma mark - 类型转换


@property (nonatomic,copy,readonly) UILabel*(^jcs_toLabel)(void);
@property (nonatomic,copy,readonly) UIButton*(^jcs_toButton)(void);
@property (nonatomic,copy,readonly) UITextField*(^jcs_toTextField)(void);
@property (nonatomic,copy,readonly) UITextView*(^jcs_toTextView)(void);
@property (nonatomic,copy,readonly) UIImageView*(^jcs_toImageView)(void);
@property (nonatomic,copy,readonly) UIScrollView*(^jcs_toScrollView)(void);
@property (nonatomic,copy,readonly) UITableView*(^jcs_toTableView)(void);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_toCollectionView)(void);
@property (nonatomic,copy,readonly) UIControl*(^jcs_toControl)(void);
@property (nonatomic,copy,readonly) UISegmentedControl*(^jcs_toSegmentedControl)(void);

#pragma mark - EventBus

/** EventBus **/
@property (nonatomic, weak) JCS_EventBus *jcs_eventBus;

@end
