//
//  UITableView+JCS_Config.m
//  AFNetworking
//
//  Created by 永平 on 2020/1/21.
//

#import "UITableView+JCS_Config.h"
#import <MJRefresh/MJRefresh.h>
#import "JCS_Category.h"

#import "JCS_TableViewModel.h"
#import <objc/runtime.h>

#import "JCS_Create_Defines.h"

#import "JCS_ConfigTableViewDatasource.h"

static char configTableViewDatasourceKey;
static char configTableViewRefreshHeaderBlockKey;
static char configTableViewRefreshFooterBlockKey;

@implementation UITableView (JCS_Config)


#pragma mark - 选择模式
- (UITableView *(^)(void))jcs_selectMode_Single{
    return ^id {
        [self sectionDatasource].selectMode = JCS_SelectModeSingle;
        return self;
    };
}
- (UITableView *(^)(void))jcs_selectMode_SectionSingle{
    return ^id {
        [self sectionDatasource].selectMode = JCS_SelectModeSectionSingle;
        return self;
    };
}
- (UITableView *(^)(void))jcs_selectMode_Multiple{
    return ^id {
        [self sectionDatasource].selectMode = JCS_SelectModeMultiple;
        return self;
    };
}

#pragma mark - 配置区域

- (UITableView *(^)(NSArray<id<JCS_TableViewSectionProtocol>>*))jcs_customerSections{
    __weak typeof(self) weakSelf = self;
    return ^id(NSArray<id<JCS_TableViewSectionProtocol>> *sections) {
        __strong typeof(self) self = weakSelf;
        JCS_ConfigTableViewDatasource *datasource = [self sectionDatasource];
        datasource.sections = sections;
        self.delegate = datasource;
        self.dataSource = datasource;
        [self reloadData];
        return self;
    };
}

- (UITableView *(^)(id<JCS_TableViewProtocol> delegate))jcs_customerDelegate{
    return ^id(id<JCS_TableViewProtocol> delegate) {
        [self sectionDatasource].customerDelegate = delegate;
        return self;
    };
}

- (UITableView *(^)(void (^)(NSIndexPath*indexPath,id<JCS_TableViewRowProtocol>selecedModel)))jcs_customerDidSelectRowBlock{
    return ^id(void (^didSelectRowBlock)(NSIndexPath*indexPath,id<JCS_TableViewRowProtocol>selecedModel)) {
        [self sectionDatasource].customerDidSelectRowBlock = didSelectRowBlock;
        return self;
    };
}

- (UITableView *(^)(void (^)(UITableView*sender)))jcs_headerRefreshBlock {
    return ^id(void (^headerRefreshBlock)(UITableView*sender)) {
        if(headerRefreshBlock){
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(jcs_headerRefresh)];;
            objc_setAssociatedObject(self, &configTableViewRefreshHeaderBlockKey, headerRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        return self;
    };
}
- (UITableView *(^)(void (^)(UITableView*sender)))jcs_footerRefreshBlock {
    return ^id(void (^footerRefreshBlock)(UITableView*sender)) {
        if(footerRefreshBlock){
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(jcs_footerRefresh)];;
            objc_setAssociatedObject(self, &configTableViewRefreshFooterBlockKey, footerRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        return self;
    };
}

- (UITableView *(^)(NSObject *target,SEL sel))jcs_headerRefreshSelector {
    return ^id(NSObject *target,SEL sel) {
        if(target && sel){
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:sel];
        }
        return self;
    };
}
- (UITableView *(^)(NSObject *target,SEL sel))jcs_footerRefreshSelector {
    return ^id(NSObject *target,SEL sel) {
        if(target && sel){
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:sel];
        }
        return self;
    };
}

- (UITableView *(^)(NSString *className))jcs_defaultCellClassName {
    return ^id(NSString *className) {
        if(className.jcs_isValid){
            //默认classname，直接注册
            self.jcs_registerCellClass(className);
            [self sectionDatasource].defaultCellClassName = className;
        }
        return self;
    };
}
- (UITableView *(^)(NSString *clickRouter))jcs_defaultRowClickRouter {
    return ^id(NSString *clickRouter) {
        if(clickRouter.jcs_isValid){
            [self sectionDatasource].defaultRowClickRouter = clickRouter;
        }
        return self;
    };
}

#pragma mark - Event Bus

- (UITableView * _Nonnull (^)(JCS_EventBus * _Nonnull eventBus))jcs_eventBus {
    return ^id(JCS_EventBus * _Nonnull eventBus) {
        if(eventBus){
            [self sectionDatasource].eventBus = eventBus;
        }
        return self;
    };
}


#pragma mark - Action

- (void)jcs_headerRefresh {
    void (^headerRefreshBlock)(UITableView*sender) = objc_getAssociatedObject(self, &configTableViewRefreshHeaderBlockKey);
    if(headerRefreshBlock){
        headerRefreshBlock(self);
    }
}
- (void)jcs_footerRefresh {
    void (^footerRefreshBlock)(UITableView*sender) = objc_getAssociatedObject(self, &configTableViewRefreshFooterBlockKey);
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

- (JCS_ConfigTableViewDatasource*)sectionDatasource {
    JCS_ConfigTableViewDatasource *datasource = objc_getAssociatedObject(self, &configTableViewDatasourceKey);
    if(!datasource){
        datasource = [[JCS_ConfigTableViewDatasource alloc] init];
        objc_setAssociatedObject(self, &configTableViewDatasourceKey, datasource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return datasource;
}

@end
