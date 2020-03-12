//
//  UITextView+JCS_Create.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/8.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (JCS_Create)


@property (nonatomic,copy,readonly) UITextField*(^jcs_text)(NSString *text);

@property (nonatomic,copy,readonly) UITextField*(^jcs_textColor)(UIColor *color);
@property (nonatomic,copy,readonly) UITextField*(^jcs_textColorHex)(NSInteger hex);

//@property (nonatomic,copy,readonly) UITextField*(^jcs_placeHolder)(NSString *placeHolder);

@property (nonatomic,copy,readonly) UITextField*(^jcs_textAlignment)(NSTextAlignment alignment);

@property (nonatomic,copy,readonly) UITextField*(^jcs_font)(UIFont *font);
@property (nonatomic,copy,readonly) UITextField*(^jcs_fontSize)(CGFloat fontSize);

@property (nonatomic,copy,readonly) UITextField*(^jcs_returnKeyType)(UIReturnKeyType type);

@property (nonatomic,copy,readonly) UITextField*(^jcs_delegate)(id<UITextViewDelegate> delegate);


- (void)textChanged:(void(^)(NSString*newValue))textChangedBlock;;

@end

NS_ASSUME_NONNULL_END
