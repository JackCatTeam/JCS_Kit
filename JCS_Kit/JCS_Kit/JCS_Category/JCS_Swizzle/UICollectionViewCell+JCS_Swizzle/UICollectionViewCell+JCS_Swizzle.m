//
//  UICollectionViewCell+JCS_Swizzle.m
//  JCS_Category
//
//  Created by 永平 on 2020/2/15.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UICollectionViewCell+JCS_Swizzle.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"
#import "UIView+JCS_Swizzle.h"

const char JCS_UICollectionViewCell_Checked_Key;

@implementation UICollectionViewCell (JCS_Swizzle)

@dynamic jcs_checked;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UICollectionViewCell jcs_swizzleInstanceMethod:@selector(initWithFrame:) withMethod:@selector(jcs_UICollectionViewCell_initWithFrame:)];
    });
}

- (instancetype)jcs_UICollectionViewCell_initWithFrame:(CGRect)frame {
    [self jcs_UICollectionViewCell_initWithFrame:frame];
    
    [self jcs_setupUI];
    [self jcs_bindingSignal];
    
    return self;
}

///是否被选中
- (void)setJcs_checked:(BOOL)jcs_checked {
    objc_setAssociatedObject(self, &JCS_UICollectionViewCell_Checked_Key, @(jcs_checked), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)jcs_checked {
    id value = objc_getAssociatedObject(self, &JCS_UICollectionViewCell_Checked_Key);
    if(!value) {
        return NO;
    }
    return [value boolValue];
}

@end
