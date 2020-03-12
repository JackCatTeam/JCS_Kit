//
//  UICollectionView+JCS_Config.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_CollectionViewProtocol.h"
#import "JCS_CollectionViewItemProtocol.h"
#import "JCS_CollectionViewSectionProtocol.h"
#import "JCS_CollectionViewWaterFallLayout.h"
#import "JCS_EventBus.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (JCS_Config)<JCS_CollectionViewWaterFallLayoutDelegate>

+ (instancetype)jcs_createWithWaterFallLayout:(void(^_Nullable)(JCS_CollectionViewWaterFallLayout *_Nonnull layout))layoutConfig;
+ (instancetype)jcs_createWithFlowLayout:(void(^_Nullable)(UICollectionViewFlowLayout *_Nonnull layout))layoutConfig;

#pragma mark - 选择模式
///单选
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_selectMode_Single)(void);
/// Section 内 单选
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_selectMode_SectionSingle)(void);
/// 多选
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_selectMode_Multiple)(void);

///Section数据集
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_customerSections)(NSArray<id<JCS_CollectionViewSectionProtocol>> *sections);
///外部UITableView代理，用于JCS_ConfigTableView无法实现时使用
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_customerDelegate)(id<JCS_CollectionViewProtocol> delegate);
/** cell点击事件 **/
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_customerDidSelectRowBlock)(void (^)(NSIndexPath*indexPath,id<JCS_CollectionViewItemProtocol>selecedModel));


/// 下拉刷新、上拉加载 Block
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_headerRefreshBlock)(void (^)(UICollectionView*sender));
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_footerRefreshBlock)(void (^)(UICollectionView*sender));

/// 下拉刷新、上拉加载 Selector
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_headerRefreshSelector)(NSObject *target,SEL sel);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_footerRefreshSelector)(NSObject *target,SEL sel);

/// 默认值
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_defaultCellClassName)(NSString * _Nonnull className);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_defaultItemClickRouter)(NSString * _Nonnull clickRouter);

#pragma mark - Event Bus

@property (nonatomic,copy,readonly) UICollectionView*(^jcs_eventBus)(JCS_EventBus * _Nonnull eventBus);

#pragma mark - 上拉下拉

///开始下来刷新
- (void)jcs_beginHeaderRefreshing;
///停止下来刷新
- (void)jcs_endHeaderRefreshing;
///停止上拉加载
- (void)jcs_endFooterRefreshing;
//停止上拉加载-没有更多数据
- (void)jcs_endFooterRefreshingWithNoMoreData;
//重置上拉刷新
- (void)jcs_resetNoMoreData;

@end

NS_ASSUME_NONNULL_END
