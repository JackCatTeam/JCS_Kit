//
//  UILabel+JCCreate.m
//  JCCreate
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UILabel+JCSCreate.h"
#import "UIView+JCSCreate.h"
#import "NSObject+JCSCreate.h"
#import "JCS_BaseLib.h"

@implementation UILabel (JCSCreate)

+ (instancetype)jcs_createAndLayout:(id)superView
                              frame:(CGRect)frame
                               text:(NSString*)text
                               font:(UIFont*)font
                          textColor:(UIColor*)textColor{
    UILabel *label = nil;
    [UILabel jcs_createAndLayout:superView frame:frame].jcs_toLabel().jcs_font(font).jcs_textColor(textColor).jcs_text(text).jcs_associated(&label);
    return label;
}
+ (instancetype)jcs_createAndLayout:(id)superView
                    constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock
                               text:(NSString*)text
                               font:(UIFont*)font
                          textColor:(UIColor*)textColor{
    UILabel *label = nil;
    [UILabel jcs_createAndLayout:superView constraintBlock:constraintBlock].jcs_toLabel().jcs_font(font).jcs_textColor(textColor).jcs_text(text).jcs_associated(&label);
    return label;
}

- (UILabel *(^)(NSString *))jcs_text{
    return ^id(NSString *value) {
        self.text = value;
        return self;
    };
}

- (UILabel *(^)(UIColor *))jcs_textColor{
    return ^id(UIColor *value) {
        self.textColor = value;
        return self;
    };
}
- (UILabel *(^)(NSInteger hex))jcs_textColorHex{
    return ^id(NSInteger hex) {
        self.textColor = JCS_COLOR_HEX(hex);;
        return self;
    };
}

- (UILabel *(^)(UIFont *))jcs_font{
    return ^id(UIFont *value) {
        self.font = value;
        return self;
    };
}

- (UILabel *(^)(CGFloat))jcs_fontSize{
    return ^id(CGFloat value) {
        self.font = [UIFont systemFontOfSize:value];
        return self;
    };
}

- (UILabel *(^)(void))jcs_textAlignment_Left{
    return ^id {
        self.textAlignment = NSTextAlignmentLeft;
        return self;
    };
}

- (UILabel *(^)(void))jcs_textAlignment_Center{
    return ^id {
        self.textAlignment = NSTextAlignmentCenter;
        return self;
    };
}

- (UILabel *(^)(void))jcs_textAlignment_Right{
    return ^id {
        self.textAlignment = NSTextAlignmentRight;
        return self;
    };
}

- (UILabel *(^)(NSInteger))jcs_numberOfLines{
    return ^id(NSInteger numberOfLines) {
        self.numberOfLines = numberOfLines;
        return self;
    };
}

@end
