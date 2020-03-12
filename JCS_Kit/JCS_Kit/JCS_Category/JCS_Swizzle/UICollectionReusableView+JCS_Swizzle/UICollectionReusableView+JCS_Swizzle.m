//
//  UICollectionReusableView+JCS_Swizzle.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UICollectionReusableView+JCS_Swizzle.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"
#import "UIView+JCS_Swizzle.h"

@implementation UICollectionReusableView (JCS_Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UICollectionReusableView jcs_swizzleInstanceMethod:@selector(initWithFrame:) withMethod:@selector(jcs_UICollectionReusableView_initWithFrame:)];
    });
}

- (instancetype)jcs_UICollectionReusableView_initWithFrame:(CGRect)frame {
    [self jcs_UICollectionReusableView_initWithFrame:frame];
    
        //UICollectionViewCell则不执行下面方法
    if(![self isKindOfClass:UICollectionViewCell.class]){
        [self jcs_setupUI];
        [self jcs_bindingSignal];
    }
    
    return self;
}

@end
