//
//  UITableViewHeaderFooterView+JCS_Swizzle.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UITableViewHeaderFooterView+JCS_Swizzle.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"

#import "UIView+JCS_Swizzle.h"

@implementation UITableViewHeaderFooterView (JCS_Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UITableViewHeaderFooterView jcs_swizzleInstanceMethod:@selector(initWithReuseIdentifier:) withMethod:@selector(jcs_initWithReuseIdentifier:)];
    });
}

- (instancetype)jcs_initWithReuseIdentifier:(NSString *)reuseIdentifier {
    [self jcs_initWithReuseIdentifier:reuseIdentifier];
    [self jcs_setupUI];
    [self jcs_bindingSignal];
    return self;
}

@end
