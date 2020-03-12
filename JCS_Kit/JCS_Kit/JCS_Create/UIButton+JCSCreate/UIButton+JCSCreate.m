//
//  UIButton+JCCreate.m
//  JCCreate
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UIButton+JCSCreate.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

static NSString *associatedTapBlockKey = nil;

typedef void (^ClickBlock)(UIButton*sender);

@implementation UIButton (JCSCreate)

#pragma mark - 文字

- (UIButton *(^)(NSString *value))jcs_normalTitle{
    return ^id(NSString *value) {
        [self setTitle:value forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(NSString *value))jcs_selectedTitle{
    return ^id(NSString *value) {
        [self setTitle:value forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_highlightedTitle{
    return ^id(NSString *value) {
        [self setTitle:value forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_disabledTitle{
    return ^id(NSString *value) {
        [self setTitle:value forState:(UIControlStateDisabled)];
        return self;
    };
}

#pragma mark - 字体

- (UIButton *(^)(UIFont *))jcs_font{
    return ^id(UIFont *value) {
        self.titleLabel.font = value;
        return self;
    };
}
- (UIButton *(^)(CGFloat))jcs_fontSize{
    return ^id(CGFloat value) {
        self.titleLabel.font = [UIFont systemFontOfSize:value];
        return self;
    };
}

#pragma mark - 颜色

- (UIButton *(^)(UIColor *))jcs_normalTitleColor{
    return ^id(UIColor *value) {
        [self setTitleColor:value forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(UIColor *))jcs_selectedTitleColor{
    return ^id(UIColor *value) {
        [self setTitleColor:value forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(UIColor *))jcs_highlightedTitleColor{
    return ^id(UIColor *value) {
        [self setTitleColor:value forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(UIColor *))jcs_disabledTitleColor{
    return ^id(UIColor *value) {
        [self setTitleColor:value forState:(UIControlStateDisabled)];
        return self;
    };
}
- (UIButton *(^)(UIColor *))jcs_tintColor{
    return ^id(UIColor *value) {
        [self setTintColor:value];
        return self;
    };
}

- (UIButton *(^)(NSInteger hex))jcs_normalTitleColorHex{
    return ^id(NSInteger hex) {
        [self setTitleColor:JCS_COLOR_HEX(hex) forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(NSInteger hex))jcs_selectedTitleColorHex{
    return ^id(NSInteger hex) {
        [self setTitleColor:JCS_COLOR_HEX(hex) forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(NSInteger hex))jcs_highlightedTitleColorHex{
    return ^id(NSInteger hex) {
        [self setTitleColor:JCS_COLOR_HEX(hex) forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(NSInteger hex))jcs_disabledTitleColorHex{
    return ^id(NSInteger hex) {
        [self setTitleColor:JCS_COLOR_HEX(hex) forState:(UIControlStateDisabled)];
        return self;
    };
}
- (UIButton *(^)(NSInteger hex))jcs_tintColorHex{
    return ^id(NSInteger hex) {
        [self setTintColor:JCS_COLOR_HEX(hex)];
        return self;
    };
}

#pragma mark - 图标

- (UIButton *(^)(UIImage *))jcs_normalImage{
    return ^id(UIImage *image) {
        [self setImage:image forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(UIImage *))jcs_selectedImage{
    return ^id(UIImage *image) {
        [self setImage:image forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(UIImage *))jcs_highlightedImage{
    return ^id(UIImage *image) {
        [self setImage:image forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(UIImage *))jcs_disabledImage{
    return ^id(UIImage *image) {
        [self setImage:image forState:(UIControlStateDisabled)];
        return self;
    };
}

- (UIButton *(^)(NSString *))jcs_normalImageWithName{
    return ^id(NSString *image) {
        [self setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_selectedImageWithName{
    return ^id(NSString *image) {
        [self setImage:[UIImage imageNamed:image] forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_highlightedImageWithName{
    return ^id(NSString *image) {
        [self setImage:[UIImage imageNamed:image] forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_disabledImageWithName{
    return ^id(NSString *image) {
        [self setImage:[UIImage imageNamed:image] forState:(UIControlStateDisabled)];
        return self;
    };
}

#pragma mark - 背景图

- (UIButton *(^)(UIImage *))jcs_normalBackgroundImage{
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(UIImage *))jcs_selectedBackgroundImage{
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(UIImage *))jcs_highlightedBackgroundImage{
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(UIImage *))jcs_disabledBackgroundImage{
    return ^id(UIImage *image) {
        [self setBackgroundImage:image forState:(UIControlStateDisabled)];
        return self;
    };
}

- (UIButton *(^)(NSString *))jcs_normalBackgroundImageWithName{
    return ^id(NSString *image) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_selectedBackgroundImageWithName{
    return ^id(NSString *image) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateSelected)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_highlightedBackgroundImageWithName{
    return ^id(NSString *image) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateHighlighted)];
        return self;
    };
}
- (UIButton *(^)(NSString *))jcs_disabledBackgroundImageWithName{
    return ^id(NSString *image) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateDisabled)];
        return self;
    };
}

#pragma mark - 其他

- (UIButton *(^)(BOOL))jcs_adjustsImageWhenHighlighted{
    return ^id(BOOL value) {
        self.adjustsImageWhenHighlighted = value;
        return self;
    };
}

- (UIButton *(^)(BOOL))jcs_adjustsImageWhenDisabled{
    return ^id(BOOL value) {
        self.adjustsImageWhenDisabled = value;
        return self;
    };
}

#pragma mark - 事件

- (UIButton *(^)(void (^)(UIButton*sender)))jcs_clickBlock{
    return ^id(void (^clickBlock)(UIButton*sender)) {
        
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
- (UIButton *(^)(id, SEL))jcs_clickAction{
    return ^id(id target, SEL sel) {
        [self addTarget:target action:sel forControlEvents:(UIControlEventTouchUpInside)];
        return self;
    };
}
- (void)clickAction:(UIButton*)sender{
    id block = objc_getAssociatedObject(self, &associatedTapBlockKey);
    if(block){
        ClickBlock __clickBlock = (ClickBlock)block;
        __clickBlock(self);
    }
}


#pragma mark - EdgeInsets

- (UIButton *(^)(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right))jcs_imageEdgeInsets{
    return ^id(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right) {
        self.imageEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}
- (UIButton *(^)(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right))jcs_contentEdgeInsets{
    return ^id(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right) {
        self.contentEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}

#pragma mark - 扩大热区

- (UIButton *(^)(CGFloat, CGFloat, CGFloat, CGFloat))jcs_enlargeEdge{
    return ^id(CGFloat left,CGFloat top,CGFloat right,CGFloat bottom) {
        [self setEnlargeEdgeWithLeft:left top:top right:right bottom:bottom];
        return self;
    };
}

- (void)setEnlargeEdgeWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    
    if (self.alpha <= 0.1 || self.hidden) {
        return nil;
    }
    
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}


@end
