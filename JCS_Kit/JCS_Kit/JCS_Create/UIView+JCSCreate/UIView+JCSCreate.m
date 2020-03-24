//
//  UIView+JCCreate.m
//  JCCreate
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UIView+JCSCreate.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "NSObject+JCSCreate.h"

static NSString *associatedTapBlockKey = nil;
static NSString *associatedTapRecoginzerBKey = nil;
static NSString *jcs_UIView_EventBus_Key = nil;

typedef void (^ClickBlock)(UIView*sender);

@implementation UIView (JCSCreate)

#pragma mark - 实例化

+ (instancetype)createWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}
+ (instancetype)createWithCoder:(NSCoder *)coder{
    return [[self alloc]initWithCoder:coder];
}
+ (instancetype)jcs_createAndLayout:(id)superView frame:(CGRect)frame {
    return [super jcs_create].jcs_layoutWithFrame(superView, frame);
}
+ (instancetype)jcs_createAndLayout:(id)superView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock {
    return [super jcs_create].jcs_layout(superView, constraintBlock);
}


#pragma mark - 布局

- (UIView *(^)(id, void (^)(MASConstraintMaker *make)))jcs_layout{
    return ^id(id superView,void (^layout)(MASConstraintMaker *make)) {
        
        if([superView isKindOfClass:UIView.class]){
            [superView addSubview:self];
        } else if([superView isKindOfClass:UIViewController.class]){
            [((UIViewController*)superView).view addSubview:self];
        }
        [self mas_makeConstraints:layout];

        return self;
    };
}
- (UIView *(^)(id, CGRect ))jcs_layoutWithFrame{
    return ^id(id superView,CGRect frame) {
        if([superView isKindOfClass:UIView.class]){
            [superView addSubview:self];
        } else if([superView isKindOfClass:UIViewController.class]){
            [((UIViewController*)superView).view addSubview:self];
        }
        self.frame = frame;
        
        return self;
    };
}

- (UIView *(^)(CGRect))jcs_frame{
    return ^id(CGRect frame) {
        self.frame = frame;
        return self;
    };
}
- (UIView *(^)(CGRect))jcs_bounds{
    return ^id(CGRect bounds) {
        self.bounds = bounds;
        return self;
    };
}
- (UIView *(^)(CGPoint))jcs_center{
    return ^id(CGPoint center) {
        self.center = center;
        return self;
    };
}

#pragma mark - 属性设置

- (UIView *(^)(NSInteger))jcs_tag{
    return ^id(NSInteger value) {
        self.tag = value;
        return self;
    };
}
- (UIView*(^)(UIColor *))jcs_backgroundColor{
    return ^id(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (UIView*(^)(NSInteger hex))jcs_backgroundColorHex{
    return ^id(NSInteger hex) {
        self.backgroundColor = JCS_COLOR_HEX(hex);
        return self;
    };
}
- (UIView*(^)(void))jcs_randomBackgroundColor{
    return ^id {
        self.backgroundColor = UIColor.jcs_randomColor;
        return self;
    };
}
- (UIView *(^)(UIViewContentMode))jcs_contentMode{
    return ^id(UIViewContentMode mode) {
        self.contentMode = mode;
        return self;
    };
}
- (UIView *(^)(void))jcs_whiteBackgroundColor{
    return ^id(void) {
        self.backgroundColor = [UIColor whiteColor];
        return self;
    };
}
- (UIView *(^)(void))jcs_clearBackgroundColor{
    return ^id(void) {
        self.backgroundColor = [UIColor clearColor];
        return self;
    };
}
- (UIView *(^)(BOOL))jcs_hidden{
    return ^id(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}
- (UIView *(^)(BOOL))jcs_userInteractionEnabled{
    return ^id(BOOL userInteractionEnabled) {
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}
- (UIView *(^)(BOOL))jcs_clipsToBounds{
    return ^id(BOOL clipsToBounds) {
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}
- (UIView *(^)(CGFloat))jcs_alpha{
    return ^id(CGFloat alpha) {
        self.alpha = alpha;
        return self;
    };
}
- (UIView *(^)(BOOL))jcs_opaque{
    return ^id(BOOL opaque) {
        self.opaque = opaque;
        return self;
    };
}
//- (UIView *(^)(CGRect))jcs_contentStretch{
//    return ^id(CGRect contentStretch) {
//        self.contentStretch = contentStretch;
//        return self;
//    };
//}
- (UIView *(^)(UIColor *))jcs_tintColor{
    return ^id(UIColor *tintColor) {
        self.tintColor = tintColor;
        return self;
    };
}
- (UIView *(^)(UIViewTintAdjustmentMode))jcs_tintAdjustmentMode{
    return ^id(UIViewTintAdjustmentMode tintAdjustmentMode) {
        self.tintAdjustmentMode = tintAdjustmentMode;
        return self;
    };
}

#pragma mark - 顺序转换

- (UIView*(^)(void))jcs_bringToFront{
    return ^id(void) {
        [self.superview bringSubviewToFront:self];
        return self;
    };
}
- (UIView *(^)(void))jcs_sendToBack{
    return ^id(void) {
        [self.superview sendSubviewToBack:self];
        return self;
    };
}

#pragma mark - CALayer相关

- (UIView *(^)(CGFloat))jcs_cornerRadius{
    return ^id(CGFloat value) {
        self.layer.cornerRadius = value;
        self.layer.masksToBounds = YES;
        return self;
    };
}

- (UIView *(^)(UIColor *))jcs_borderColor{
    return ^id(UIColor *value) {
        self.layer.borderColor = value.CGColor;
        return self;
    };
}
- (UIView*(^)(NSInteger hex))jcs_borderColorHex{
    return ^id(NSInteger hex) {
        self.layer.borderColor = JCS_COLOR_HEX(hex).CGColor;
        return self;
    };
}
- (UIView *(^)(CGFloat))jcs_borderWidth{
    return ^id(CGFloat value) {
        self.layer.borderWidth = value;
        return self;
    };
}

- (UIView *(^)(UIColor *))jcs_shadowColor{
    return ^id(UIColor *color) {
        self.layer.shadowColor = color.CGColor;
        return self;
    };
}
- (UIView*(^)(NSInteger hex))jcs_shadowColorHex{
    return ^id(NSInteger hex) {
        self.layer.shadowColor = JCS_COLOR_HEX(hex).CGColor;
        return self;
    };
}
- (UIView *(^)(CGFloat))jcs_shadowRadius{
    return ^id(CGFloat value) {
        self.layer.shadowRadius = value;
        return self;
    };
}
- (UIView *(^)(UIBezierPath*))jcs_shadowPath{
    return ^id(UIBezierPath *path) {
        self.layer.shadowPath = path.CGPath;
        return self;
    };
}
- (UIView *(^)(CGFloat))jcs_shadowOpacity{
    return ^id(CGFloat value) {
        self.layer.shadowOpacity = value;
        return self;
    };
}
- (UIView *(^)(CGSize))jcs_shadowOffset{
    return ^id(CGSize value) {
        self.layer.shadowOffset = value;
        return self;
    };
}

#pragma mark - 事件

- (UIView *(^)(void (^)(UIView*sender)))jcs_clickBlock{
    return ^id(void (^clickBlock)(UIView*sender)) {
        if (clickBlock) { //将block绑定到自身上
            [self configTabRecognizerWithTarget:self selector:@selector(clickAction:)];
            objc_setAssociatedObject(self, &associatedTapBlockKey, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
        }else{ //移除绑定
            [self removeTabRecognizer];
            objc_setAssociatedObject(self, &associatedTapRecoginzerBKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        return self;
    };
}
- (UIView *(^)(id, SEL))jcs_clickAction{
    return ^id(id target, SEL sel) {
        [self configTabRecognizerWithTarget:target selector:sel];
        return self;
    };
}
- (void)clickAction:(UIView*)sender{
    id block = objc_getAssociatedObject(self, &associatedTapBlockKey);
    if(block){
        ClickBlock __clickBlock = (ClickBlock)block;
        __clickBlock(self);
    }
}

- (void)configTabRecognizerWithTarget:(id)target selector:(SEL)selector{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *recoginzer = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:recoginzer];
    objc_setAssociatedObject(self, &associatedTapRecoginzerBKey, recoginzer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeTabRecognizer {
    UITapGestureRecognizer *recoginzer = objc_getAssociatedObject(self, &associatedTapRecoginzerBKey);
    if(recoginzer){
        [self removeGestureRecognizer:recoginzer];
        objc_setAssociatedObject(self, &associatedTapRecoginzerBKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - 类型转换

#define JCS_TO_OBJ(__CLASSNAME__,__PROPERTYNAME__) \
- (__CLASSNAME__ *(^)(void))__PROPERTYNAME__{ \
    return ^id(void) { \
        NSAssert2([self isKindOfClass:[__CLASSNAME__ class]], @"%@  转换为  %@  失败",self,NSStringFromClass(__CLASSNAME__.class));\
        return self; \
    }; \
}

JCS_TO_OBJ(UIButton,jcs_toButton)
JCS_TO_OBJ(UILabel,jcs_toLabel)
JCS_TO_OBJ(UITextField,jcs_toTextField)
JCS_TO_OBJ(UITextView,jcs_toTextView)
JCS_TO_OBJ(UIImageView,jcs_toImageView)
JCS_TO_OBJ(UIScrollView,jcs_toScrollView)
JCS_TO_OBJ(UITableView,jcs_toTableView)
JCS_TO_OBJ(UICollectionView,jcs_toCollectionView)
JCS_TO_OBJ(UIControl,jcs_toControl)
JCS_TO_OBJ(UISegmentedControl,jcs_toSegmentedControl)

#undef JCS_TO_OBJ

#pragma mark - EventBus

- (void)setJcs_eventBus:(JCS_EventBus *)jcs_eventBus {
    if(jcs_eventBus){
        objc_setAssociatedObject(self, &jcs_UIView_EventBus_Key, jcs_eventBus, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (JCS_EventBus *)jcs_eventBus {
    return objc_getAssociatedObject(self, &jcs_UIView_EventBus_Key);
}

@end
