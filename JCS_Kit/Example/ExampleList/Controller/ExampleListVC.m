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
    .jcs_associated(&_tableView);
    
//    {
//        "data": {
//            "exampleList":[{
//                "title":"JCS_BaseLib",
//                "classname":"BaseLib_ExampleVC"
//            },{
//                "title":"JCS_Category",
//                "classname":"Category_ExampleVC"
//            },{
//                "title":"JCS_EventBus",
//                "classname":"EventBus_ExampleVC"
//            },{
//                "title":"JCS_Injection",
//                "classname":"Injection_ExampleVC"
//            },{
//                "title":"JCS_Router",
//                "classname":"Router_ExampleVC"
//            },{
//                "title":"JCS_Create",
//                "classname":"Create_ExampleVC"
//            }]
//        }
//    }
    
}

- (void)jcs_request {
    self.tableView.jcs_customerSections([self jcs_generateTableViewSections]);
}

@end
