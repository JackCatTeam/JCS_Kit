//
//  JCS_TableViewModel.m
//  JCS_Monitor
//
//  Created by 永平 on 2020/1/21.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_TableViewModel.h"

@implementation JCS_TableViewRowModel

- (NSString *)jcs_getCellClass {
    return self.cellClass;
}

- (CGFloat)jcs_getCellHeight {
    return self.cellHeight;
}

- (id)jcs_getData {
    return self.data;
}

- (NSString *)jcs_getClickRouter {
    return self.clickRouter;
}

@end

@implementation JCS_TableViewSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rows = [NSMutableArray array];
    }
    return self;
}

- (NSInteger)jcs_getRowsCount {
    return self.rows.count;
}
- (id<JCS_TableViewRowProtocol>)jcs_getRowAtIndex:(NSInteger)index {
    return self.rows[index];
}

- (NSString *)jcs_getHeaderViewClassName {
    return self.headerClass;
}
- (NSString *)jcs_getFooterViewClassName {
    return self.footerClass;
}

- (id)jcs_getHeaderData {
    return self.headerData;
}
- (id)jcs_getFooterData {
    return self.footerData;
}

- (NSString *)jcs_getHeaderTitle {
    return self.headerTitle;
}
- (NSString *)jcs_getFooterTitle {
    return self.footerTitle;
}

- (CGFloat)jcs_getHeaderHeight {
    return self.headerHeight;
}
- (CGFloat)jcs_getFooterHeight {
    return self.footerHeight;
}


@end
