//
//  UITableView+JCS_Config.h
//  AFNetworking
//
//  Created by 永平 on 2020/1/21.
//

#import <UIKit/UIKit.h>
#import "UITableView+JCSCreate.h"
#import "JCS_ConfigTableViewDatasource.h"
#import "JCS_TableViewRowProtocol.h"
#import "JCS_EventBus.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JCS_Config)

#pragma mark - 选择模式
///单选
@property (nonatomic,copy,readonly) UITableView*(^jcs_selectMode_Single)(void);
/// Section 内 单选
@property (nonatomic,copy,readonly) UITableView*(^jcs_selectMode_SectionSingle)(void);
/// 多选
@property (nonatomic,copy,readonly) UITableView*(^jcs_selectMode_Multiple)(void);

///Section数据集
@property (nonatomic,copy,readonly) UITableView*(^jcs_customerSections)(NSArray<id<JCS_TableViewSectionProtocol>> *sections);
///外部UITableView代理，用于JCS_ConfigTableView无法实现时使用
@property (nonatomic,copy,readonly) UITableView*(^jcs_customerDelegate)(id<JCS_TableViewProtocol> delegate);
///didSelectRowBlock
@property (nonatomic,copy,readonly) UITableView*(^jcs_customerDidSelectRowBlock)(void (^)(NSIndexPath*indexPath,id<JCS_TableViewRowProtocol>selecedModel));

///下拉刷新、上拉加载 Block
@property (nonatomic,copy,readonly) UITableView*(^jcs_headerRefreshBlock)(void (^)(UITableView*sender));
@property (nonatomic,copy,readonly) UITableView*(^jcs_footerRefreshBlock)(void (^)(UITableView*sender));

///下拉刷新、上拉加载 Selector
@property (nonatomic,copy,readonly) UITableView*(^jcs_headerRefreshSelector)(NSObject *target,SEL sel);
@property (nonatomic,copy,readonly) UITableView*(^jcs_footerRefreshSelector)(NSObject *target,SEL sel);

///默认值
@property (nonatomic,copy,readonly) UITableView*(^jcs_defaultCellClassName)(NSString * _Nonnull className);
@property (nonatomic,copy,readonly) UITableView*(^jcs_defaultRowClickRouter)(NSString * _Nonnull clickRouter);

#pragma mark - Event Bus

@property (nonatomic,copy,readonly) UITableView*(^jcs_eventBus)(JCS_EventBus * _Nonnull eventBus);


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
