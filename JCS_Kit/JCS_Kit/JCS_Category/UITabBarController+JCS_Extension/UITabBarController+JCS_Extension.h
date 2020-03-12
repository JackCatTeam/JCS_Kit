//
//  UITabBarController+JCS_Extension.h
//  StarCard
//
//  Created by 永平 on 2020/1/17.
//  Copyright © 2020 youye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_TabBarItem: NSObject

/** Item图片 实际类型UITabBarSwappableImageView **/
@property (nonatomic, strong) UIView *imageView;
/** Item文字 实际类型UITabBarButtonLabel **/
@property (nonatomic, strong) UIView *label;

@end

@interface UITabBarController (JCS_Extension)

///解析出每个TabBarItem的ImageView和Label
- (NSArray<JCS_TabBarItem*>*)tabBarItemComponents;

@end

NS_ASSUME_NONNULL_END
