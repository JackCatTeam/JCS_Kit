//
//  ExampleVC_JCS_ConfigTableView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/3.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_JCS_ConfigTableView.h"
#import "JCS_Create.h"
#import "ExampleVC_TableViewModel.h"

#import "ExampleListItem.h"
#import "ExampleService.h"

#define PAGESIZE 10

@interface ExampleVC_JCS_ConfigTableView ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<id<JCS_TableViewSectionProtocol>> *sections;

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation ExampleVC_JCS_ConfigTableView

- (void)jcs_setup {
    [super jcs_setup];
       self.view.jcs_whiteBackgroundColor();
        
        [UITableView jcs_createGroupTableView].jcs_layout(self.view, ^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view);
            make.left.top.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-JCS_HOME_INDICATOR_HEIGHT);
        }).jcs_toTableView()
        .jcs_rowHeight(44)
        .jcs_customerSections(self.sections)
        .jcs_defaultCellClassName(@"ExampleTableViewCell")
        .jcs_defaultRowClickRouter(@"jcs://PersonRouter/say:?name=张三") //默认点击路由
        .jcs_selectMode_Single()
//        .jcs_customerDidSelectRowBlock(^(NSIndexPath*indexPath,JCS_TableViewRowModel*selecedModel){
//
//        })
        .jcs_associated(&_tableView);
}

- (NSMutableArray<id<JCS_TableViewSectionProtocol>> *)sections {
    if(!_sections){
        _sections = [NSMutableArray array];
        
        ExampleVC_TableViewSectionModel *sectionModel = nil;
        ExampleVC_TableViewRowModel *rowModel = nil;
        
        sectionModel = [[ExampleVC_TableViewSectionModel alloc] init];
        [_sections addObject:sectionModel];

            //SectionView
        sectionModel.headerClass2 = @"ExampleTableSectionHeaderView";
        sectionModel.footerClass2 = @"ExampleTableSectionFooterView";
        //数据，采用id类型接收
        sectionModel.headerData2 = @{@"title":@"This is Header Data"};
        sectionModel.footerData2 = @{@"title":@"This is Footer Data"};

        //SectionTitle
        sectionModel.headerTitle2 = @"This is Header Title";
        sectionModel.footerTitle2 = @"This is Footer Title";
        sectionModel.headerHeight2 = 100;
        sectionModel.footerHeight2 = 100;

        rowModel = [[ExampleVC_TableViewRowModel alloc] init];
        rowModel.cellClass2 = @"ExampleTableViewCell";
        rowModel.data2 = @"This is cell data";
        rowModel.cellHeight2 = 44;
//            rowModel.jcs_checked = YES;
        [sectionModel.rows2 addObject:rowModel];
        
        ExampleListItem *item = nil;

        rowModel = [[ExampleVC_TableViewRowModel alloc] init];
        item = [[ExampleListItem alloc] init];
        item.title = @"1";
        rowModel.data2 = item;
        [sectionModel.rows2 addObject:rowModel];

        rowModel = [[ExampleVC_TableViewRowModel alloc] init];
        item = [[ExampleListItem alloc] init];
        item.title = @"2";
        rowModel.data2 = item;
        [sectionModel.rows2 addObject:rowModel];

        rowModel = [[ExampleVC_TableViewRowModel alloc] init];
        item = [[ExampleListItem alloc] init];
        item.title = @"3";
        rowModel.data2 = item;
        [sectionModel.rows2 addObject:rowModel];
    }
    return _sections;
}

@end
