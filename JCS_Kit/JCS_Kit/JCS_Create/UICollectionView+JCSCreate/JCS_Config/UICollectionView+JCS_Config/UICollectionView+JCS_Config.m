//
//  UICollectionView+JCS_Config.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UICollectionView+JCS_Config.h"
#import "UICollectionView+JCSCreate.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <objc/runtime.h>
#import <MJRefresh/MJRefresh.h>
#import "JCS_Category.h"
#import "JCS_ConfigCollectionViewDatasource.h"
#import "JCS_CollectionViewFlowLayout.h"
#import "JCS_Create_Defines.h"

static char configDatasourceKey;
static char configRefreshHeaderBlockKey;
static char configRefreshFooterBlockKey;

@implementation UICollectionView (JCS_Config)

+ (instancetype)jcs_createWithWaterFallLayout:(void(^)(JCS_CollectionViewWaterFallLayout *layout))layoutConfig{
    JCS_CollectionViewWaterFallLayout *layout = [JCS_CollectionViewWaterFallLayout jcs_create];
    if(layoutConfig){
        layoutConfig(layout);
    }
    UICollectionView *collectionView = [self jcs_createWithLayout:layout];
    layout.jcs_customerDelegate(collectionView);
    return collectionView;
}
+ (instancetype)jcs_createWithFlowLayout:(void(^)(UICollectionViewFlowLayout *layout))layoutConfig{
    JCS_CollectionViewFlowLayout *layout = [[JCS_CollectionViewFlowLayout alloc] init];
    if(layoutConfig){
        layoutConfig(layout);
    }
    return [self jcs_createWithLayout:layout];
}

#pragma mark - 选择模式
- (UICollectionView *(^)(void))jcs_selectMode_Single{
    return ^id {
        [self sectionDatasource].selectMode = JCS_SelectModeSingle;
        return self;
    };
}
- (UICollectionView *(^)(void))jcs_selectMode_SectionSingle{
    return ^id {
        [self sectionDatasource].selectMode = JCS_SelectModeSectionSingle;
        return self;
    };
}
- (UICollectionView *(^)(void))jcs_selectMode_Multiple{
    return ^id {
        [self sectionDatasource].selectMode = JCS_SelectModeMultiple;
        return self;
    };
}

- (UICollectionView *(^)(NSArray<id<JCS_CollectionViewSectionProtocol>>*))jcs_customerSections{
    __weak typeof(self) weakSelf = self;
    return ^id(NSArray<id<JCS_CollectionViewSectionProtocol>> *sections) {
        __strong typeof(self) self = weakSelf;
        
        JCS_ConfigCollectionViewDatasource *datasource = [self sectionDatasource];
        datasource.sections = sections;
        self.delegate = datasource;
        self.dataSource = datasource;
        
        return self;
    };
}

- (UICollectionView *(^)(id<JCS_CollectionViewProtocol> delegate))jcs_customerDelegate{
    return ^id(id<JCS_CollectionViewProtocol> delegate) {
        [self sectionDatasource].customerDelegate = delegate;
        return self;
    };
}
- (UICollectionView *(^)(void (^)(NSIndexPath*,id<JCS_CollectionViewItemProtocol>)))jcs_customerDidSelectRowBlock{
    return ^id(void (^didSelectRowBlock)(NSIndexPath*indexPath,id<JCS_CollectionViewItemProtocol>selecedModel)) {
        [self sectionDatasource].customerDidSelectRowBlock = didSelectRowBlock;
        return self;
    };
}

- (UICollectionView *(^)(void (^)(UICollectionView*sender)))jcs_headerRefreshBlock {
    return ^id(void (^headerRefreshBlock)(UICollectionView*sender)) {
        if(headerRefreshBlock){
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(jcs_headerRefresh)];;
            objc_setAssociatedObject(self, &configRefreshHeaderBlockKey, headerRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        return self;
    };
}
- (UICollectionView *(^)(void (^)(UICollectionView*sender)))jcs_footerRefreshBlock {
    return ^id(void (^footerRefreshBlock)(UICollectionView*sender)) {
        if(footerRefreshBlock){
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(jcs_footerRefresh)];;
            objc_setAssociatedObject(self, &configRefreshFooterBlockKey, footerRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        return self;
    };
}

- (UICollectionView *(^)(NSObject *target,SEL sel))jcs_headerRefreshSelector {
    return ^id(NSObject *target,SEL sel) {
        if(target && sel){
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:sel];
        }
        return self;
    };
}
- (UICollectionView *(^)(NSObject *target,SEL sel))jcs_footerRefreshSelector {
    return ^id(NSObject *target,SEL sel) {
        if(target && sel){
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:sel];
        }
        return self;
    };
}

- (UICollectionView *(^)(NSString *className))jcs_defaultCellClassName {
    return ^id(NSString *className) {
        if(className.jcs_isValid){
            //默认classname，直接注册
            self.jcs_registerCellClass(className);
            [self sectionDatasource].defaultCellClassName = className;
        }
        return self;
    };
}
- (UICollectionView *(^)(NSString *clickRouter))jcs_defaultItemClickRouter {
    return ^id(NSString *clickRouter) {
        if(clickRouter.jcs_isValid){
            [self sectionDatasource].defaultItemClickRouter = clickRouter;
        }
        return self;
    };
}

#pragma mark - Event Bus

- (UICollectionView * _Nonnull (^)(JCS_EventBus * _Nonnull eventBus))jcs_eventBus {
    return ^id(JCS_EventBus * _Nonnull eventBus) {
        if(eventBus){
            [self sectionDatasource].eventBus = eventBus;
        }
        return self;
    };
}

#pragma mark - JCS_CollectionViewWaterFallLayoutDelegate

///根据 indexPath 获取 Section 对象
- (id<JCS_CollectionViewSectionProtocol> _Nullable)jcs_waterFallLayout:(JCS_CollectionViewWaterFallLayout * _Nonnull)layout
                                       sectionWithIndexPath:(NSInteger)section {
    return [self sectionDatasource].sections[section];
}
///根据 indexPath 获取 Item 对象
- (id<JCS_CollectionViewItemProtocol> _Nullable)jcs_waterFallLayout:(JCS_CollectionViewWaterFallLayout * _Nonnull)layout
                                        itemWithIndexPath:(NSIndexPath * _Nonnull)indexPath {
    return [[self sectionDatasource].sections[indexPath.section] jcs_getItemAtIndex:indexPath.item];
}

#pragma mark - Action

- (void)jcs_headerRefresh {
    void (^headerRefreshBlock)(UICollectionView*sender) = objc_getAssociatedObject(self, &configRefreshHeaderBlockKey);
    if(headerRefreshBlock){
        headerRefreshBlock(self);
    }
}
- (void)jcs_footerRefresh {
    void (^footerRefreshBlock)(UICollectionView*sender) = objc_getAssociatedObject(self, &configRefreshFooterBlockKey);
    if(footerRefreshBlock){
        footerRefreshBlock(self);
    }
}

///开始下来刷新
- (void)jcs_beginHeaderRefreshing {
    [self.mj_header beginRefreshing];
}
- (void)jcs_endHeaderRefreshing {
    [self.mj_header endRefreshing];
}
- (void)jcs_endFooterRefreshing {
    [self.mj_footer endRefreshing];
}
- (void)jcs_endFooterRefreshingWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}
- (void)jcs_resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

#pragma mark - 懒加载

- (JCS_ConfigCollectionViewDatasource*)sectionDatasource {
    JCS_ConfigCollectionViewDatasource *datasource = objc_getAssociatedObject(self, &configDatasourceKey);
    if(!datasource){
        datasource = [[JCS_ConfigCollectionViewDatasource alloc] init];
        RAC(datasource,collectionViewLayout) = RACObserve(self, collectionViewLayout);
        objc_setAssociatedObject(self, &configDatasourceKey, datasource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return datasource;
}

@end
