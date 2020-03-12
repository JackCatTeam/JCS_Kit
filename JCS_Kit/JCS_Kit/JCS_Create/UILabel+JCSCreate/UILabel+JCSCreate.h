//
//  UILabel+JCSCreate.h
//  JCCreate
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UILabel (JCSCreate)

+ (instancetype)jcs_createAndLayout:(id)superView
                              frame:(CGRect)frame
                               text:(NSString*)text
                               font:(UIFont*)font
                          textColor:(UIColor*)textColor;

+ (instancetype)jcs_createAndLayout:(id)superView
                    constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock
                               text:(NSString*)text
                               font:(UIFont*)font
                          textColor:(UIColor*)textColor;

/**
 文字颜色
 */
@property (nonatomic,copy,readonly) UILabel*(^jcs_textColor)(UIColor *color);
@property (nonatomic,copy,readonly) UILabel*(^jcs_textColorHex)(NSInteger hex);
/**
 字体
 */
@property (nonatomic,copy,readonly) UILabel*(^jcs_font)(UIFont *font);
/**
 字体大小
 */
@property (nonatomic,copy,readonly) UILabel*(^jcs_fontSize)(CGFloat fontSize);
/**
 文字
 */
@property (nonatomic,copy,readonly) UILabel*(^jcs_text)(NSString *text);
/**
 对齐方式
 */
@property (nonatomic,copy,readonly) UILabel*(^jcs_textAlignment_Left)(void);
@property (nonatomic,copy,readonly) UILabel*(^jcs_textAlignment_Center)(void);
@property (nonatomic,copy,readonly) UILabel*(^jcs_textAlignment_Right)(void);
/**
 文字行数
 */
@property (nonatomic,copy,readonly) UILabel*(^jcs_numberOfLines)(NSInteger numberOfLines);

@end
