//
//  UITableView+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UITableView+JCSCreate.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"

@implementation UITableView (JCSCreate)

+ (instancetype)jcs_createGroupTableView{
    UITableView *tableView = [[self alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerDefaultClass];
    return tableView;
}

+ (instancetype)jcs_createPlainTableView{
    UITableView *tableView = [[self alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView registerDefaultClass];
    return tableView;
}

- (void)registerDefaultClass {
    self.jcs_registerCellClass(@"UITableViewCell");
    self.jcs_registerCellClass(@"JCS_TableEmptyCell");
    self.jcs_registerSectionHeaderFooterClass(@"JCS_TableSectionEmptyView");
}

#pragma mark - 注册

- (UITableView *(^)(NSString *cellClassName))jcs_registerCellClass{
    return ^id(NSString *cellClassName) {
        self.jcs_registerCellClassWithIdentifier(cellClassName,cellClassName);
        return self;
    };
}
- (UITableView *(^)(NSArray<NSString*> *cellClassNames))jcs_registerCellClasses{
    return ^id(NSArray<NSString*> *cellClassNames) {
        for (NSString *clazz in cellClassNames) {
            self.jcs_registerCellClass(clazz);
        }
        return self;
    };
}
- (UITableView *(^)(NSString *cellClassName,NSString *))jcs_registerCellClassWithIdentifier{
    return ^id(NSString *cellClassName,NSString *identifier) {
        if(cellClassName.jcs_isValid){
            Class cellClass = NSClassFromString(cellClassName);
            NSAssert1(cellClass != NULL,@"JCS: UITableView CellClassName %@ 异常",cellClassName);
            [self registerClass:cellClass forCellReuseIdentifier:identifier];
        }
        return self;
    };
}

- (UITableView *(^)(NSString *headerFooterClassName))jcs_registerSectionHeaderFooterClass{
    return ^id(NSString *headerFooterClassName) {
        self.jcs_registerSectionHeaderFooterClassWithIdentifier(headerFooterClassName, headerFooterClassName);
        return self;
    };
}
- (UITableView *(^)(NSArray<NSString*> *headerFooterClassNames))jcs_registerSectionHeaderFooterClasses{
    return ^id(NSArray<NSString*> *headerFooterClassNames) {
        for (NSString *clazz in headerFooterClassNames) {
            self.jcs_registerSectionHeaderFooterClass(clazz);
        }
        return self;
    };
}
- (UITableView *(^)(NSString *headerFooterClassName, NSString *identifier))jcs_registerSectionHeaderFooterClassWithIdentifier{
    return ^id(NSString *headerFooterClassName,NSString *identifier) {
        if(headerFooterClassName.jcs_isValid){
            Class clazz = NSClassFromString(headerFooterClassName);
            NSAssert1(clazz != NULL,@"JCS: UITableView headerFooterClassName %@ 异常",headerFooterClassName);
            [self registerClass:clazz forHeaderFooterViewReuseIdentifier:identifier];
        }
        return self;
    };
}

#pragma mark - 代理

- (UITableView *(^)(id<UITableViewDelegate>))jcs_delegate{
    return ^id(id<UITableViewDelegate> value) {
        self.delegate = value;
        return self;
    };
}
- (UITableView *(^)(id<UITableViewDataSource>))jcs_dataSource{
    return ^id(id<UITableViewDataSource> value) {
        self.dataSource = value;
        return self;
    };
}

#pragma mark - 行高

- (UITableView *(^)(CGFloat))jcs_rowHeight{
    return ^id(CGFloat value) {
        self.estimatedRowHeight = -1;
        self.rowHeight = value;
        return self;
    };
}
-(UITableView *(^)(CGFloat))jcs_estimatedRowHeight{
    return ^id(CGFloat value) {
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = value;
        return self;
    };
}

#pragma mark - 区高

- (UITableView *(^)(CGFloat))jcs_estimatedSectionHeaderHeight{
    return ^id(CGFloat value) {
        self.estimatedSectionHeaderHeight = value;
        return self;
    };
}
- (UITableView *(^)(CGFloat))jcs_estimatedSectionFooterHeight{
    return ^id(CGFloat value) {
        self.estimatedSectionFooterHeight = value;
        return self;
    };
}

- (UITableView *(^)(CGFloat))jcs_sectionHeaderHeight{
    return ^id(CGFloat value) {
        self.sectionHeaderHeight = value;
        return self;
    };
}
- (UITableView *(^)(CGFloat))jcs_sectionFooterHeight{
    return ^id(CGFloat value) {
        self.sectionFooterHeight = value;
        return self;
    };
}

#pragma mark - 分隔栏

- (UITableView *(^)(UIColor *))jcs_separatorColor{
    return ^id(UIColor *value) {
        self.separatorColor = value;
        return self;
    };
}
- (UITableView *(^)(NSInteger hex))jcs_separatorColorHex{
    return ^id(NSInteger hex) {
        self.separatorColor = JCS_COLOR_HEX(hex);;
        return self;
    };
}
- (UITableView *(^)(UITableViewCellSeparatorStyle))jcs_separatorStyle{
    return ^id(UITableViewCellSeparatorStyle value) {
        self.separatorStyle = value;
        return self;
    };
}
- (UITableView *(^)(void))jcs_separatorNone{
    return ^id {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        return self;
    };
}
- (UITableView *(^)(UIEdgeInsets))jcs_separatorInset{
    return ^id(UIEdgeInsets value) {
        self.separatorInset = value;
        return self;
    };
}

#pragma mark - 选择

- (UITableView *(^)(BOOL))jcs_allowsSelection{
    return ^id(BOOL value) {
        self.allowsSelection = value;
        return self;
    };
}
- (UITableView *(^)(BOOL))jcs_allowsMultipleSelection{
    return ^id(BOOL value) {
        self.allowsMultipleSelection = value;
        return self;
    };
}

#pragma mark - 表头、表尾

- (UITableView *(^)(UIView *))jcs_tableHeaderView{
    return ^id(UIView *value) {
        self.tableHeaderView = value;
        return self;
    };
}
- (UITableView *(^)(UIView *))jcs_tableFooterView{
    return ^id(UIView *value) {
        self.tableFooterView = value;
        return self;
    };
}
- (UITableView *(^)(void))jcs_tableFooterView_Empty{
    return ^id {
        self.tableFooterView = [[UIView alloc] init];
        return self;
    };
}

- (UITableView *(^)(BOOL))jcs_editing{
    return ^id(BOOL editing) {
        self.editing = editing;
        return self;
    };
}

@end
