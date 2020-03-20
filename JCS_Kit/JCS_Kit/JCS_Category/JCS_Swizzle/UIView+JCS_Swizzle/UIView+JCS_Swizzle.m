//
//  UIView+JCS_Swizzle.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UIView+JCS_Swizzle.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"

static NSArray *blackList = nil;

@implementation UIView (JCS_Swizzle)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        blackList = @[
            @"UITableViewCell",
            @"UITableViewHeaderFooterView",
            @"UICollectionReusableView", //UICollectionViewCell继承自UICollectionReusableView
            @"UIPickerView",
    //        @"UIControl",
            @"UIScrollView",
            @"UINavigationBar",
            @"UIWindow",
            @"UIWebView",
            @"UIVisualEffectView",
            @"UIToolbar",
            @"UITabBar",
            @"UIStackView",
            @"UIProgressView",
            @"UILabel",
            @"UIInputView",
            @"UIImageView",
            @"UIAlertView"
        ];
        
        [UIView jcs_swizzleInstanceMethod:@selector(initWithFrame:) withMethod:@selector(jcs_initWithFrame:)];
    });
    
}

- (instancetype)jcs_initWithFrame:(CGRect)frame {
    
    [self jcs_initWithFrame:frame];
    
    //是否在黑名单里
    BOOL isBlack = NO;
    for (NSString *className in blackList) {
        Class clazz = NSClassFromString(className);
        //这里就是isKindOfClass，不是isMemberOfClass
        if(clazz && [self isKindOfClass:clazz]){
            isBlack = YES;
            break;
        }
    }
    if(!isBlack) {
        [self jcs_setupUI];
        [self jcs_bindingSignal];
    }
    return self;
}

/// 设置UI
- (void)jcs_setupUI {}
/// 绑定信号
- (void)jcs_bindingSignal {}

@end
