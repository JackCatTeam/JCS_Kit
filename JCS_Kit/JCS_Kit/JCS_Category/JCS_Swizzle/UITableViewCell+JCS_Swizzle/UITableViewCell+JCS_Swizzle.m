//
//  UITableViewCell+JCS_Swizzle.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UITableViewCell+JCS_Swizzle.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCS_Swizzle.h"

#import "UIView+JCS_Swizzle.h"

const char JCS_UITableViewCell_Checked_Key;

@implementation UITableViewCell (JCS_Swizzle)


@dynamic jcs_checked;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UITableViewCell jcs_swizzleInstanceMethod:@selector(initWithStyle:reuseIdentifier:) withMethod:@selector(jcs_initWithStyle:reuseIdentifier:)];
    });
}

- (instancetype)jcs_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    [self jcs_initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self jcs_setupUI];
    [self jcs_bindingSignal];
    
    return self;
}

///是否被选中
- (void)setJcs_checked:(BOOL)jcs_checked {
    objc_setAssociatedObject(self, &JCS_UITableViewCell_Checked_Key, @(jcs_checked), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)jcs_checked {
    id value = objc_getAssociatedObject(self, &JCS_UITableViewCell_Checked_Key);
    if(!value) {
        return NO;
    }
    return [value boolValue];
}

@end
