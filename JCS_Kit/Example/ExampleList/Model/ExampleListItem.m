//
//  ExampleListItem.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleListItem.h"

@implementation ExampleListItem
+ (instancetype)itemWithTitle:(NSString*)title jumpClass:(NSString*)jumpClass{
    ExampleListItem *item = [[ExampleListItem alloc] init];
    item.title = title;
    item.jumpClass = jumpClass;
    return item;
}
@end
