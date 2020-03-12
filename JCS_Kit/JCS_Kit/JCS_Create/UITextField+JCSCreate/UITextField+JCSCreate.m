//
//  UITextField+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UITextField+JCSCreate.h"
#import "JCS_BaseLib.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UITextField (JCSCreate)

- (UITextField *(^)(NSString *))jcs_text{
    return ^id(NSString *value) {
        self.text = value;
        return self;
    };
}

- (UITextField *(^)(NSString *))jcs_placeHolder{
    return ^id(NSString *value) {
        self.placeholder = value;
        return self;
    };
}

- (UITextField *(^)(UIColor *))jcs_textColor{
    return ^id(UIColor *value) {
        self.textColor = value;
        return self;
    };
}
- (UITextField *(^)(NSInteger hex))jcs_textColorHex{
    return ^id(NSInteger hex) {
        self.textColor = JCS_COLOR_HEX(hex);
        return self;
    };
}

- (UITextField *(^)(UIFont *))jcs_font{
    return ^id(UIFont *value) {
        self.font = value;
        return self;
    };
}
- (UITextField *(^)(CGFloat))jcs_fontSize{
    return ^id(CGFloat value) {
        self.font = [UIFont systemFontOfSize:value];
        return self;
    };
}

- (UITextField *(^)(NSTextAlignment))jcs_textAlignment{
    return ^id(NSTextAlignment value) {
        self.textAlignment = value;
        return self;
    };
}

- (UITextField *(^)(UIView *))jcs_leftView{
    return ^id(UIView *value) {
        self.leftView = value;
        return self;
    };
}
- (UITextField *(^)(UITextFieldViewMode))jcs_leftViewMode{
    return ^id(UITextFieldViewMode value) {
        self.leftViewMode = value;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode))jcs_clearButtonMode{
    return ^id(UITextFieldViewMode value) {
        self.clearButtonMode = value;
        return self;
    };
}

- (UITextField *(^)(UIReturnKeyType))jcs_returnKeyType{
    return ^id(UIReturnKeyType value) {
        self.returnKeyType = value;
        return self;
    };
}

- (UITextField *(^)(UIKeyboardType))jcs_keyboardType{
    return ^id(UIKeyboardType value) {
        self.keyboardType = value;
        return self;
    };
}

- (UITextField *(^)(id<UITextFieldDelegate>))jcs_delegate{
    return ^id(id<UITextFieldDelegate> value) {
        self.delegate = value;
        return self;
    };
}

- (void)textChanged:(void (^)(NSString *))textChangedBlock {
    [[self rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        textChangedBlock(x);
    }];
}

@end
