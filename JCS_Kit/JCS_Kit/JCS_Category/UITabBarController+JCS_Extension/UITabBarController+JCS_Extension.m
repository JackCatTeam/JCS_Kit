//
//  UITabBarController+JCS_Extension.m
//  StarCard
//
//  Created by 永平 on 2020/1/17.
//  Copyright © 2020 youye. All rights reserved.
//

#import "UITabBarController+JCS_Extension.h"

@implementation JCS_TabBarItem @end

@implementation UITabBarController (JCS_Extension)

///解析出每个TabBarItem的ImageView和Label
- (NSArray<JCS_TabBarItem*>*)tabBarItemComponents{
    NSMutableArray *array = [NSMutableArray array];
    for (UIControl *tabBarButton in self.tabBar.subviews) {
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            JCS_TabBarItem *item = [[JCS_TabBarItem alloc] init];
            for (UIControl *comp in tabBarButton.subviews) {
                if([comp isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]){
                    item.imageView = comp;
                } else if([comp isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]){
                    item.label = comp;
                }
            }
            if(item.imageView || item.label){
                [array addObject:item];
            }
        }
    }
    return array;
}

@end
