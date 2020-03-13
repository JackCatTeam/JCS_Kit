//
//  ExampleListVC.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleListVC.h"
#import "JCS_Kit.h"

@interface ExampleListVC ()
/** 示例 **/
@property (nonatomic, strong) NSArray<JCS_TableViewSectionModel*> *sections;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ExampleListVC

- (BOOL)jcs_propertyInjectEnable {
    return YES;
}

- (void)jcs_setup {
    [super jcs_setup];
    [UITableView jcs_createGroupTableView].jcs_layout(self, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }).jcs_toTableView()
    .jcs_defaultCellClassName(@"ExampleListCell")
    .jcs_estimatedRowHeight(50)
    .jcs_sectionHeaderHeight(60)
    .jcs_tableHeaderView_Empty()
    .jcs_tableFooterView_Empty()
    .jcs_associated(&_tableView);
}

- (void)jcs_request {
    self.tableView.jcs_customerSections([self jcs_generateTableViewSections]);
}

@end
