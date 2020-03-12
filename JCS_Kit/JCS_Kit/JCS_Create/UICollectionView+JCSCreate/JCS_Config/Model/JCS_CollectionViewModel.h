//
//  JCS_CollectionViewModel.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_CollectionViewItemProtocol.h"
#import "JCS_CollectionViewSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_CollectionViewItemModel : NSObject<JCS_CollectionViewItemProtocol>
/** 数据 **/
@property (nonatomic, strong) id data;
/** Cell Class **/
@property (nonatomic, copy) NSString *cellClass;
/** Cell Size **/
@property (nonatomic, assign) CGSize cellSize;
/** 点击路由 **/
@property (nonatomic, copy) NSString *clickRouter;
/** 是否被选中 **/
@property (nonatomic, assign) BOOL jcs_checked;

@end



@interface JCS_CollectionViewSectionModel : NSObject<JCS_CollectionViewSectionProtocol>

/** 列数, 仅WaterFallLayou使用 **/
@property (nonatomic, assign) NSInteger columnCount;
/** 数据行 **/
@property (nonatomic, strong,nonnull) NSMutableArray<id<JCS_CollectionViewItemProtocol>> *items;
/** Header Class **/
@property (nonatomic, copy,nullable) NSString *headerClass;
/** Header Class Size **/
@property (nonatomic, assign) CGSize headerSize;
/** Footer Class **/
@property (nonatomic, copy,nullable) NSString *footerClass;
/** Footer Class Size **/
@property (nonatomic, assign) CGSize footerSize;
/** sectionInset **/
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/** 平行于滚动条间距,  默认 10**/
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/** 垂直于滚动条的间距 默认 10 **/
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/** HeaderData **/
@property (nonatomic, strong,nullable) id headerData;
/** FooterData **/
@property (nonatomic, strong,nullable) id footerData;

#pragma mark - 装饰视图 Decoration View

/** 装饰视图 Class **/
@property (nonatomic, copy,nullable) NSString *decorationClass;
/** 装饰视图 Margin **/
@property (nonatomic, assign) UIEdgeInsets decorationMarginInset;
/** 装饰视图 zIndex, 默认 -1 **/
@property (nonatomic, assign) NSInteger decorationZIndex;
/** 装饰视图 data **/
@property (nonatomic, strong,nullable) id decorationData;

@end

NS_ASSUME_NONNULL_END
