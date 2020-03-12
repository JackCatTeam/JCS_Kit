//
//  JCS_TableViewModelHelper.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_TableViewRowProtocol.h"
#import "JCS_TableViewSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_TableViewRowModelHelper : NSObject

+ (UITableViewCell*)getCell:(UITableView*)tableView model:(id<JCS_TableViewRowProtocol>)model cellClass:(NSString*)cellClass indexPath:(NSIndexPath*)indexPath;
+ (CGFloat)getRowHeight:(id<JCS_TableViewRowProtocol>)model;

@end


@interface JCS_TableViewSectionModelHelper : NSObject

+ (UITableViewHeaderFooterView*)getSectionHeaderView:(UITableView*)tableView model:(id<JCS_TableViewSectionProtocol>)model;
+ (UITableViewHeaderFooterView*)getSectionFooterView:(UITableView*)tableView model:(id<JCS_TableViewSectionProtocol>)model;

+ (NSString*)getSectionHeaderTitle:(id<JCS_TableViewSectionProtocol>)model;
+ (NSString*)getSectionFooterTitle:(id<JCS_TableViewSectionProtocol>)model;

+ (CGFloat)getHeaderSectionHeight:(id<JCS_TableViewSectionProtocol>)model;
+ (CGFloat)getFooterSectionHeight:(id<JCS_TableViewSectionProtocol>)model;

@end

NS_ASSUME_NONNULL_END
