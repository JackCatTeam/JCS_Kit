//
//  UIControl+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/11.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UIControl+JCSCreate.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"

static NSString *associatedTapBlockKey = nil;

typedef void (^ClickBlock)(UIControl*sender);

@implementation UIControl (JCSCreate)

- (UIControl *(^)(BOOL))jcs_enable{
    return ^id(BOOL flag) {
        self.enabled = flag;
        return self;
    };
}
- (UIControl *(^)(BOOL))jcs_selected{
    return ^id(BOOL flag) {
        self.selected = flag;
        return self;
    };
}
- (UIControl *(^)(BOOL))jcs_highlighted{
    return ^id(BOOL flag) {
        self.hidden = flag;
        return self;
    };
}

- (UIControl *(^)(UIControlContentVerticalAlignment))jcs_contentVerticalAlignment{
    return ^id(UIControlContentVerticalAlignment alignment) {
        self.contentVerticalAlignment = alignment;
        return self;
    };
}
- (UIControl *(^)(UIControlContentHorizontalAlignment))jcs_contentHorizontalAlignment{
    return ^id(UIControlContentHorizontalAlignment alignment) {
        self.contentHorizontalAlignment = alignment;
        return self;
    };
}

#pragma mark - 事件

- (UIControl *(^)(void (^)(UIControl*sender)))jcs_clickBlock{
    return ^id(void (^clickBlock)(UIControl*sender)) {
        
        if (clickBlock) { //将block绑定到自身上
            objc_setAssociatedObject(self, &associatedTapBlockKey, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
            [self addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }else{ //移除绑定
            objc_setAssociatedObject(self, &associatedTapBlockKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
            [self removeTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        return self;
    };
}
- (UIControl *(^)(id, SEL))jcs_clickAction{
    return ^id(id target, SEL sel) {
        [self addTarget:target action:sel forControlEvents:(UIControlEventTouchUpInside)];
        return self;
    };
}
- (void)clickAction:(UIControl*)sender{
    id block = objc_getAssociatedObject(self, &associatedTapBlockKey);
    if(block){
        ClickBlock __clickBlock = (ClickBlock)block;
        __clickBlock(self);
    }
}


@end
