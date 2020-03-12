//
//  UIButton+JCSCreate.h
//  JCCreate
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JCSCreate)

#pragma mark - 文字

@property (nonatomic,copy,readonly) UIButton*(^jcs_normalTitle)(NSString *title);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedTitle)(NSString *title);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedTitle)(NSString *title);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledTitle)(NSString *title);

#pragma mark - 字体

@property (nonatomic,copy,readonly) UIButton*(^jcs_font)(UIFont *font);
@property (nonatomic,copy,readonly) UIButton*(^jcs_fontSize)(CGFloat fontSize);

#pragma mark - 颜色

//UIColor
@property (nonatomic,copy,readonly) UIButton*(^jcs_normalTitleColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedTitleColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedTitleColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledTitleColor)(UIColor *color);
@property (nonatomic,copy,readonly) UIButton*(^jcs_tintColor)(UIColor *color);

//十六进制Color
@property (nonatomic,copy,readonly) UIButton*(^jcs_normalTitleColorHex)(NSInteger hex);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedTitleColorHex)(NSInteger hex);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedTitleColorHex)(NSInteger hex);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledTitleColorHex)(NSInteger hex);
@property (nonatomic,copy,readonly) UIButton*(^jcs_tintColorHex)(NSInteger hex);

#pragma mark - 图标

@property (nonatomic,copy,readonly) UIButton*(^jcs_normalImage)(UIImage *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedImage)(UIImage *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedImage)(UIImage *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledImage)(UIImage *image);

@property (nonatomic,copy,readonly) UIButton*(^jcs_normalImageWithName)(NSString *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedImageWithName)(NSString *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedImageWithName)(NSString *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledImageWithName)(NSString *image);

#pragma mark - 背景图

@property (nonatomic,copy,readonly) UIButton*(^jcs_normalBackgroundImage)(UIImage *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedBackgroundImage)(UIImage *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedBackgroundImage)(UIImage *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledBackgroundImage)(UIImage *image);

@property (nonatomic,copy,readonly) UIButton*(^jcs_normalBackgroundImageWithName)(NSString *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_selectedBackgroundImageWithName)(NSString *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_highlightedBackgroundImageWithName)(NSString *image);
@property (nonatomic,copy,readonly) UIButton*(^jcs_disabledBackgroundImageWithName)(NSString *image);

#pragma mark - 其他

@property (nonatomic,copy,readonly) UIButton*(^jcs_adjustsImageWhenHighlighted)(BOOL value);
@property (nonatomic,copy,readonly) UIButton*(^jcs_adjustsImageWhenDisabled)(BOOL value);

#pragma mark - EdgeInsets

@property (nonatomic,copy,readonly) UIButton*(^jcs_imageEdgeInsets)(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right);
@property (nonatomic,copy,readonly) UIButton*(^jcs_contentEdgeInsets)(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right);

#pragma mark - 事件

@property (nonatomic,copy,readonly) UIButton*(^jcs_clickBlock)(void(^)(UIButton*sender));
@property (nonatomic,copy,readonly) UIButton*(^jcs_clickAction)(id target,SEL sel);

#pragma mark - 扩大热区

@property (nonatomic,copy,readonly) UIButton*(^jcs_enlargeEdge)(CGFloat left,CGFloat top,CGFloat right,CGFloat bottom);
- (void)setEnlargeEdgeWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom;

@end
