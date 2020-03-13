//
//  UITableView+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JCSCreate)

+ (instancetype)jcs_createGroupTableView;
+ (instancetype)jcs_createPlainTableView;

#pragma mark - 注册

@property (nonatomic,copy,readonly) UITableView*(^jcs_registerCellClass)(NSString *cellClassName);
@property (nonatomic,copy,readonly) UITableView*(^jcs_registerCellClasses)(NSArray<NSString*> *cellClassNames);
@property (nonatomic,copy,readonly) UITableView*(^jcs_registerCellClassWithIdentifier)(NSString *cellClassName,NSString*identifier);

@property (nonatomic,copy,readonly) UITableView*(^jcs_registerSectionHeaderFooterClass)(NSString *headerFooterClassName);
@property (nonatomic,copy,readonly) UITableView*(^jcs_registerSectionHeaderFooterClasses)(NSArray<NSString*> *headerFooterClassNames);
@property (nonatomic,copy,readonly) UITableView*(^jcs_registerSectionHeaderFooterClassWithIdentifier)(NSString *headerFooterClassName, NSString *identifier);

#pragma mark - 代理

@property (nonatomic,copy,readonly) UITableView*(^jcs_delegate)(id<UITableViewDelegate> delegate);
@property (nonatomic,copy,readonly) UITableView*(^jcs_dataSource)(id<UITableViewDataSource> dataSource);

#pragma mark - 行高

@property (nonatomic,copy,readonly) UITableView*(^jcs_rowHeight)(CGFloat value);
@property (nonatomic,copy,readonly) UITableView*(^jcs_estimatedRowHeight)(CGFloat value);

#pragma mark - 区高

@property (nonatomic,copy,readonly) UITableView*(^jcs_estimatedSectionHeaderHeight)(CGFloat value);
@property (nonatomic,copy,readonly) UITableView*(^jcs_estimatedSectionFooterHeight)(CGFloat value);
@property (nonatomic,copy,readonly) UITableView*(^jcs_sectionHeaderHeight)(CGFloat value);
@property (nonatomic,copy,readonly) UITableView*(^jcs_sectionFooterHeight)(CGFloat value);

#pragma mark - 分隔栏

@property (nonatomic,copy,readonly) UITableView*(^jcs_separatorColor)(UIColor *color);
@property (nonatomic,copy,readonly) UITableView*(^jcs_separatorColorHex)(NSInteger hex);
@property (nonatomic,copy,readonly) UITableView*(^jcs_separatorStyle)(UITableViewCellSeparatorStyle style);
@property (nonatomic,copy,readonly) UITableView*(^jcs_separatorNone)(void);
@property (nonatomic,copy,readonly) UITableView*(^jcs_separatorInset)(UIEdgeInsets insets);

#pragma mark - 选择

@property (nonatomic,copy,readonly) UITableView*(^jcs_allowsSelection)(BOOL enable);
@property (nonatomic,copy,readonly) UITableView*(^jcs_allowsMultipleSelection)(BOOL enable);

#pragma mark - 表头、表尾

@property (nonatomic,copy,readonly) UITableView*(^jcs_tableHeaderView)(UIView *headerView);
@property (nonatomic,copy,readonly) UITableView*(^jcs_tableFooterView)(UIView *footerView);
@property (nonatomic,copy,readonly) UITableView*(^jcs_tableHeaderView_Empty)(void);
@property (nonatomic,copy,readonly) UITableView*(^jcs_tableFooterView_Empty)(void);

@property (nonatomic,copy,readonly) UITableView*(^jcs_editing)(BOOL editing);

@end
