//
//  UITableViewCell+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (JCSCreate)

/**
 从缓冲池中获取Cell
 */
+ (instancetype)getCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
+ (instancetype)getCell:(UITableView*)tableView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath;

@end
