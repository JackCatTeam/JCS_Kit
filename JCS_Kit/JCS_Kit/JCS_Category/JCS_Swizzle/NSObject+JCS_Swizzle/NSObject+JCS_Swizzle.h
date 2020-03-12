//
//  NSObject+JCS_Swizzle.h
//  JCS_Category
//
//  Created by 永平 on 2020/2/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

void jcs_swizzleClassMethod(Class _Nonnull cls, SEL _Nonnull originSelector, SEL _Nonnull newSelector);
void jcs_swizzleInstanceMethod(Class _Nonnull cls, SEL _Nonnull originSelector, SEL _Nonnull newSelector);

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JCS_Swizzle)

/** 数据 **/
@property (nonatomic, strong) id jcs_data;

/**
 方法交换 类方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)jcs_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 方法交换 实例方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)jcs_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 获取当前的控制器

 @return 当前控制器
 */
- (UIViewController *)jcs_currentVC;

@end

NS_ASSUME_NONNULL_END
