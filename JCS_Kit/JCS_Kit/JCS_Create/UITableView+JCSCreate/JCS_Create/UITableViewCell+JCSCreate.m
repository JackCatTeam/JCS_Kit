//
//  UITableViewCell+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UITableViewCell+JCSCreate.h"

@implementation UITableViewCell (JCSCreate)

+ (instancetype)getCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    return [self getCell:tableView identifier:NSStringFromClass(self.class) indexPath:indexPath];
}

+ (instancetype)getCell:(UITableView *)tableView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

@end
