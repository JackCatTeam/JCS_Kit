//
//  NSObject+JCS_Swizzle.m
//  JCS_Category
//
//  Created by 永平 on 2020/2/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSObject+JCS_Swizzle.h"
#import <objc/runtime.h>

void jcs_swizzleClassMethod(Class cls, SEL originSelector, SEL newSelector) {
    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, newSelector);
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void jcs_swizzleInstanceMethod(Class cls, SEL originSelector, SEL newSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

const char JCS_NSObject_Data_Key;

@implementation NSObject (JCS_Swizzle)

@dynamic jcs_data;

/**
 方法交换 类方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)jcs_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    jcs_swizzleClassMethod([self class], origSelector, newSelector);
}

/**
 方法交换 实例方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)jcs_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    jcs_swizzleInstanceMethod(self, origSelector, newSelector);
}


/**
 获取当前的控制器
 
 @return 当前控制器
 */
- (UIViewController *)jcs_currentVC {
    UIResponder *responder = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    for (UIView *subView in [window subviews]) {
        responder = [subView nextResponder];
        if ([responder isEqual:window]) {
            if ([[subView subviews] count]) {
                UIView *subSubView = [subView subviews][0];
                responder = [subSubView nextResponder];
            }
        }
        
    }
    if (responder == nil || ![responder isKindOfClass:[UIViewController class]]) {
        responder = window.rootViewController;
    }
    return [self jcs_topViewController:((UIViewController *) responder)];
}

- (UIViewController *)jcs_topViewController:(UIViewController *)controller {
    BOOL isPresenting = NO;
    do {
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
    } while (isPresenting);
    while ([controller isKindOfClass:[UITabBarController class]]) {
        controller = ((UITabBarController *) controller).selectedViewController;
        if ([controller isKindOfClass:[UINavigationController class]]) {
            controller = [((UINavigationController *) controller).viewControllers lastObject];
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller = [((UINavigationController *) controller).viewControllers lastObject];
    }
    return controller;
}


/// Cell数据
- (void)setJcs_data:(id)jcs_data {
    objc_setAssociatedObject(self, &JCS_NSObject_Data_Key, jcs_data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)jcs_data {
    return objc_getAssociatedObject(self, &JCS_NSObject_Data_Key);
}

@end
