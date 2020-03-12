//
//  UITextField+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JCSCreate)

@property (nonatomic,copy,readonly) UITextField*(^jcs_text)(NSString *text);

@property (nonatomic,copy,readonly) UITextField*(^jcs_textColor)(UIColor *color);
@property (nonatomic,copy,readonly) UITextField*(^jcs_textColorHex)(NSInteger hex);

@property (nonatomic,copy,readonly) UITextField*(^jcs_placeHolder)(NSString *placeHolder);

@property (nonatomic,copy,readonly) UITextField*(^jcs_textAlignment)(NSTextAlignment alignment);

@property (nonatomic,copy,readonly) UITextField*(^jcs_font)(UIFont *font);
@property (nonatomic,copy,readonly) UITextField*(^jcs_fontSize)(CGFloat fontSize);

@property (nonatomic,copy,readonly) UITextField*(^jcs_leftView)(UIView *leftView);
@property (nonatomic,copy,readonly) UITextField*(^jcs_leftViewMode)(UITextFieldViewMode mode);
@property (nonatomic,copy,readonly) UITextField*(^jcs_clearButtonMode)(UITextFieldViewMode mode);
@property (nonatomic,copy,readonly) UITextField*(^jcs_returnKeyType)(UIReturnKeyType type);
@property (nonatomic,copy,readonly) UITextField*(^jcs_keyboardType)(UIKeyboardType type);

@property (nonatomic,copy,readonly) UITextField*(^jcs_delegate)(id<UITextFieldDelegate> delegate);

- (void)textChanged:(void(^)(NSString*newValue))textChangedBlock;

@end
