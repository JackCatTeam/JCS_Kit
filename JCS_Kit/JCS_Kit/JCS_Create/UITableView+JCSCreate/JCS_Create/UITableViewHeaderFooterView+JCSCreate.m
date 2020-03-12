//
//  UITableViewHeaderFooterView+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UITableViewHeaderFooterView+JCSCreate.h"

@implementation UITableViewHeaderFooterView (JCSCreate)

+ (instancetype)getHeaderView:(UITableView *)tableView{
    return [self getHeaderFooterView:tableView identifier:NSStringFromClass(self.class)];
}

+ (instancetype)getHeaderView:(UITableView *)tableView identifier:(NSString *)identifier{
    return [self getHeaderFooterView:tableView identifier:identifier];;
}


+ (instancetype)getFooterView:(UITableView *)tableView{
    return [self getHeaderFooterView:tableView identifier:NSStringFromClass(self.class)];
}

+ (instancetype)getFooterView:(UITableView *)tableView identifier:(NSString *)identifier{
    return [self getHeaderFooterView:tableView identifier:identifier];;
}

+ (instancetype)getHeaderFooterView:(UITableView *)tableView identifier:(NSString *)identifier{
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

@end
