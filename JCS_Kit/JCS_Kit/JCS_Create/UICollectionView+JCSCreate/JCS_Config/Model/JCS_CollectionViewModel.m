//
//  JCS_CollectionViewModel.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewModel.h"

@implementation JCS_CollectionViewItemModel

/// 获取Cell Size
- (CGSize)jcs_getCellSize {
    return self.cellSize;
}
/// 获取CellClass
- (NSString*)jcs_getCellClass {
    return self.cellClass;
}
/// 获取数据
- (id)jcs_getData {
    return self.data;
}
/// 获取点击路由
- (NSString*)jcs_getClickRouter {
    return self.clickRouter;
}

@end

@implementation JCS_CollectionViewSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (NSInteger)jcs_getItemsCount {
    return self.items.count;
}

- (id<JCS_CollectionViewItemProtocol>)jcs_getItemAtIndex:(NSInteger)index {
    return self.items[index];
}

- (NSInteger)jcs_columnCount {
    return self.columnCount;
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

- (CGSize)jcs_getHeaderSize {
    return self.headerSize;
}
- (CGSize)jcs_getFooterSize {
    return self.footerSize;
}

- (UIEdgeInsets)jcs_getSectionInset {
    return self.sectionInset;
}

- (CGFloat)jcs_getMinimumLineSpacing {
    return self.minimumLineSpacing;
}
- (CGFloat)jcs_getMinimumInteritemSpacing {
    return self.minimumInteritemSpacing;
}

- (NSString*)jcs_getDecorationClass {
    return self.decorationClass;
}
- (UIEdgeInsets)jcs_getDecorationMarginInset {
    return self.decorationMarginInset;
}
- (NSInteger)jcs_getDecorationZIndex {
    return self.decorationZIndex;
}
- (id)jcs_getDecorationData {
    return self.decorationData;
}


@end
