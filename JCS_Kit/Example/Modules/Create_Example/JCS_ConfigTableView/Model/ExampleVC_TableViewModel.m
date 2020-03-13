//
//  ExampleVC_TableViewModel.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/28.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_TableViewModel.h"

@implementation ExampleVC_TableViewRowModel

- (NSString *)jcs_getCellClass {
    return self.cellClass2;
}

- (CGFloat)jcs_getCellHeight {
    return self.cellHeight2;
}

- (id)jcs_getData {
    return self.data2;
}

- (NSString *)jcs_getClickRouter {
    return self.clickRouter2;
}

@end

@implementation ExampleVC_TableViewSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rows2 = [NSMutableArray array];
    }
    return self;
}

- (NSInteger)jcs_getRowsCount {
    return self.rows2.count;
}
- (id<JCS_TableViewRowProtocol>)jcs_getRowAtIndex:(NSInteger)index {
    return self.rows2[index];
}

- (NSString *)jcs_getHeaderViewClassName {
    return self.headerClass2;
}
- (NSString *)jcs_getFooterViewClassName {
    return self.footerClass2;
}

- (id)jcs_getHeaderData {
    return self.headerData2;
}
- (id)jcs_getFooterData {
    return self.footerData2;
}

- (NSString *)jcs_getHeaderTitle {
    return self.headerTitle2;
}
- (NSString *)jcs_getFooterTitle {
    return self.footerTitle2;
}

- (CGFloat)jcs_getHeaderHeight {
    return self.headerHeight2;
}
- (CGFloat)jcs_getFooterHeight {
    return self.footerHeight2;
}

@end
