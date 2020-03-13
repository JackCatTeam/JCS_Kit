//
//  Example_InjectTableView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Example_InjectTableView.h"
#import "JCS_Kit.h"

@interface Example_InjectTableView ()
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) JCS_TableViewSectionModel *refSectionModel;
@property (nonatomic, strong) JCS_TableViewRowModel *refRowModel;

@property (nonatomic, strong) NSMutableArray<JCS_TableViewSectionModel*> *sections;

@property (nonatomic, copy) NSString *testValue;
@property (nonatomic, copy) NSString *headerData1;
/** <#备注#> **/
@property (nonatomic, assign) BOOL isLogin;

@end

@implementation Example_InjectTableView

- (BOOL)jcs_propertyInjectEnable {
    return YES;
}

- (void)jcs_setup {
    [super jcs_setup];
    
    self.refSectionModel = [JCS_TableViewSectionModel jcs_create];
    
    self.view.jcs_whiteBackgroundColor();
    
     [UITableView jcs_createPlainTableView].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-JCS_HOME_INDICATOR_HEIGHT);
    }).jcs_toTableView()
    .jcs_rowHeight(44)
//    .jcs_customerSections(self.sections)
    .jcs_defaultCellClassName(@"ExampleTableViewCell")
    .jcs_defaultRowClickRouter(@"jcs://PersonRouter/say:?name=张三") //默认点击路由
    .jcs_selectMode_SectionSingle()
    .jcs_selectMode_Multiple()
    .jcs_tableFooterView_Empty()
    .jcs_associated(&_tableView);
}

- (void)jcs_request {
    self.sections = [self jcs_generateTableViewSections];
    self.tableView.jcs_customerSections(self.sections);
}

//- (NSMutableArray<JCS_TableViewSectionModel *> *)sections {
//    if(!_sections){
//        _sections = [NSMutableArray array];
//
//        JCS_TableViewSectionModel *sectionModel = nil;
//        JCS_TableViewRowModel *rowModel = nil;
//
//        sectionModel = [JCS_TableViewSectionModel jcs_create];
//        [_sections addObject:sectionModel];
//
//        //SectionView
//        sectionModel.headerClass = @"ExampleTableSectionHeaderView";
//        sectionModel.footerClass = @"ExampleTableSectionFooterView";
//        //数据，采用id类型接收
//        sectionModel.headerData = @{@"title":@"This is Header Data"};
//        sectionModel.footerData = @{@"title":@"This is Footer Data"};
//
////            //SectionTitle
////            section.headerTitle = @"This is Header Title";
////            section.footerTitle = @"This is Footer Title";
////            section.headerHeight = 50;
////            section.footerHeight = 50;
////
//        rowModel = [[JCS_TableViewRowModel alloc] init];
//        rowModel.cellClass = @"ExampleTableViewCell";
//        rowModel.data = @"This is cell data";
//        rowModel.cellHeight = 44;
//        [sectionModel.rows addObject:rowModel];
//
//        rowModel = [[JCS_TableViewRowModel alloc] init];
//        rowModel.cellClass = @"ExampleTableViewCell";
//        rowModel.data = @"This is cell data2";
//        rowModel.cellHeight = 44;
//        [sectionModel.rows addObject:rowModel];
//    }
//    return _sections;
//}

@end
