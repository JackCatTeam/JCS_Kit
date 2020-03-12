//
//  UITableViewHeaderFooterView+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (JCSCreate)

/**
 从缓冲池中获取HeaderView
 */
+ (instancetype)getHeaderView:(UITableView*)tableView;
+ (instancetype)getHeaderView:(UITableView*)tableView identifier:(NSString*)identifier;

/**
 从缓冲池中获取FooterView
 */
+ (instancetype)getFooterView:(UITableView*)tableView;
+ (instancetype)getFooterView:(UITableView*)tableView identifier:(NSString*)identifier;

@end
