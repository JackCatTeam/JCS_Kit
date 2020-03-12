//
//  JCS_ConfigTableViewDatasource.m
//  JCS_BaseLib
//
//  Created by 永平 on 2020/1/31.
//

#import "JCS_TableViewProtocol.h"
#import "JCS_ConfigTableViewDatasource.h"

#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "JCS_Router.h"

#import "UIView+JCSCreate.h"
#import "UITableViewHeaderFooterView+JCSCreate.h"
#import "UITableViewCell+JCSCreate.h"

#import "JCS_TableViewModelHelper.h"
#import "JCS_RouterTool.h"

@interface JCS_ConfigTableViewDatasource()
/** 选中SectionItem **/
@property (nonatomic, strong) NSMutableDictionary<NSString*,id<JCS_TableViewRowProtocol>> *sectionSelectedItemDict;
/** 已注册的Cell **/
@property (nonatomic, strong) NSMutableSet<NSString*> *registerCellClasses;
/** 已注册的registerHeaderOrFooterClasses **/
@property (nonatomic, strong) NSMutableSet<NSString*> *registerHeaderOrFooterClasses;
@end

@implementation JCS_ConfigTableViewDatasource

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate numberOfSectionsInTableView:tableView];
    }
    //2. Config
    return self.sections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView numberOfRowsInSection:section];
    }
    //2. Config
    return [self.sections[section] jcs_getRowsCount];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<JCS_TableViewRowProtocol> rowModel = [self.sections[indexPath.section] jcs_getRowAtIndex:indexPath.row];
    
    //选择状态
    if([rowModel respondsToSelector:@selector(jcs_checked)] && [rowModel respondsToSelector:@selector(setJcs_checked:)] && rowModel.jcs_checked){
       //设置选中状态
       [self handleItemCheckedState:tableView indexPath:indexPath];
   }
    
    //Cell未注册，则自动注册
    NSString *cellClass = rowModel.jcs_getCellClass;
    if(!cellClass.jcs_isValid){
        cellClass = self.defaultCellClassName;
    }
    [self registerCellClassIfNeed:cellClass tableView:tableView];
    
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        UITableViewCell *cell = [self.customerDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
        cell.jcs_eventBus = self.eventBus;
        return cell;
    }
    
    //2. Config
    UITableViewCell *cell = [JCS_TableViewRowModelHelper getCell:tableView model:rowModel cellClass:cellClass indexPath:indexPath];
    cell.jcs_eventBus = self.eventBus;
    return cell;
}

#pragma mark - UITableViewDelegate

//优先级 clickRouter > didSelectRowBlock > customerDelegate > defaultRowClickRouter
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<JCS_TableViewRowProtocol> model = [self.sections[indexPath.section] jcs_getRowAtIndex:indexPath.row];
    
    //设置选中状态(外部处理点击事件，则点击状态也由外部自己处理)
    if(!(self.customerDidSelectRowBlock != nil || (self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]))){
        if([model respondsToSelector:@selector(jcs_checked)] && [model respondsToSelector:@selector(setJcs_checked:)]){
            model.jcs_checked = !model.jcs_checked;
            [self handleItemCheckedState:tableView indexPath:indexPath];
        }
    }
    
    //路由数据
    id data = nil;
    if([model respondsToSelector:@selector(jcs_getData)]){
        data = [model jcs_getData];
    }
    
    //检测是否有点击路由
    if([model respondsToSelector:@selector(jcs_getClickRouter)]){
        NSString *clickRouter = [model jcs_getClickRouter];
        if(clickRouter.jcs_isValid){
            [JCS_RouterTool executeRouter:clickRouter data:data];
            return;
        }
    }
    
    //优先执行Block
    if(self.customerDidSelectRowBlock){
        self.customerDidSelectRowBlock(indexPath,model);
        return;
    }
    
    //其次执行Block
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        [self.customerDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    
    //最后执行默认路由
    if(self.defaultRowClickRouter.jcs_isValid){
        [JCS_RouterTool executeRouter:self.defaultRowClickRouter data:data];
        return;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    id<JCS_TableViewSectionProtocol> sectionModel = self.sections[section];
    
    //Cell未注册，则自动注册
    [self registerHeaderOrFooterClassIfNeed:sectionModel.jcs_getHeaderViewClassName tableView:tableView];
    
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        UIView *sectionView = [self.customerDelegate tableView:tableView viewForHeaderInSection:section];
        sectionView.jcs_eventBus = self.eventBus;
        return sectionView;
    }
    //2. Config
    UIView *sectionView = [JCS_TableViewSectionModelHelper getSectionHeaderView:tableView model:sectionModel];
    sectionView.jcs_eventBus = self.eventBus;
    return sectionView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<JCS_TableViewSectionProtocol> sectionModel = self.sections[section];
    
    //Cell未注册，则自动注册
    [self registerHeaderOrFooterClassIfNeed:sectionModel.jcs_getFooterViewClassName tableView:tableView];
    
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        UIView *sectionView = [self.customerDelegate tableView:tableView viewForFooterInSection:section];
        sectionView.jcs_eventBus = self.eventBus;
        return sectionView;
    }
    //2. Config
    UIView *sectionView = [JCS_TableViewSectionModelHelper getSectionFooterView:tableView model:sectionModel];
    sectionView.jcs_eventBus = self.eventBus;
    return sectionView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<JCS_TableViewSectionProtocol> sectionModel = self.sections[section];
    
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView titleForHeaderInSection:section];
    }
    //2. Config
    return [JCS_TableViewSectionModelHelper getSectionHeaderTitle:sectionModel];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    id<JCS_TableViewSectionProtocol> sectionModel = self.sections[section];
    
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView titleForFooterInSection:section];
    }
    //2. Config
    return [JCS_TableViewSectionModelHelper getSectionFooterTitle:sectionModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    //2. Config
    if(tableView.estimatedRowHeight > 0){
        return UITableViewAutomaticDimension;
    }
    
    id<JCS_TableViewRowProtocol> model = [self.sections[indexPath.section] jcs_getRowAtIndex:indexPath.row];
    CGFloat modelHeight = [JCS_TableViewRowModelHelper getRowHeight:model];
    if(modelHeight > 0){
        return modelHeight;
    }
    
    return tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView heightForHeaderInSection:section];
    }
    
    //2. Config
    return [JCS_TableViewSectionModelHelper getHeaderSectionHeight:self.sections[section]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView heightForFooterInSection:section];
    }
    
    //2. Config
    return [JCS_TableViewSectionModelHelper getFooterSectionHeight:self.sections[section]];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    //2. Config
    return tableView.estimatedRowHeight;
}

#pragma mark - 私有方法

///处理Item选中状态
- (void)handleItemCheckedState:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    id<JCS_TableViewRowProtocol> model = [self.sections[indexPath.section] jcs_getRowAtIndex:indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%zd",indexPath.section];

    if(self.selectMode == JCS_SelectModeSingle){ //全局单选
        if(self.sectionSelectedItemDict.allKeys.count > 0){
            id<JCS_TableViewRowProtocol> currentCheckModel = self.sectionSelectedItemDict.allValues.firstObject;
            //如果model != currentCheckModel 时再替换
            if(currentCheckModel != model) {
                currentCheckModel.jcs_checked = NO;
                [self.sectionSelectedItemDict removeAllObjects];
                self.sectionSelectedItemDict[key] = model;
            }
        } else {
            //没有被选中的，则直接添加
            self.sectionSelectedItemDict[key] = model;
        }
        
    } else if(self.selectMode == JCS_SelectModeSectionSingle){ //Section内单选
        
        id<JCS_TableViewRowProtocol> currentCheckModel = [self.sectionSelectedItemDict valueForKey:key];
        if(currentCheckModel){
            //如果model != currentCheckModel 时再替换
            if(currentCheckModel != model){
                currentCheckModel.jcs_checked = NO;
                self.sectionSelectedItemDict[key] = model;
            }
        } else {
            //没有被选中的，则直接添加
            self.sectionSelectedItemDict[key] = model;
        }
        
    } else if(self.selectMode == JCS_SelectModeMultiple){
        //可多选
    }
    
}
/// 必须时注册CellClass
- (void)registerCellClassIfNeed:(NSString*)className tableView:(UITableView*)tableView{
    if(className.jcs_isValid && NSClassFromString(className)
       && ![self.registerCellClasses containsObject:className]){
        [self.registerCellClasses addObject:className];
        [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
    }
}
/// 必须时注册registerHeaderOrFooterClasses
- (void)registerHeaderOrFooterClassIfNeed:(NSString*)className tableView:(UITableView*)tableView{
    if(className.jcs_isValid && NSClassFromString(className)
       && ![self.registerHeaderOrFooterClasses containsObject:className]){
        [self.registerHeaderOrFooterClasses addObject:className];
        [tableView registerClass:NSClassFromString(className) forHeaderFooterViewReuseIdentifier:className];
    }
}

#pragma mark - 消息转发

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if([super respondsToSelector:aSelector]){
        return self;
    } else if((self.customerDelegate && [self.customerDelegate respondsToSelector:aSelector])){
        return self.customerDelegate;
    }
    return self;
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || (self.customerDelegate && [self.customerDelegate respondsToSelector:aSelector]);
}

#pragma mark - 懒加载

JCS_LAZY(NSMutableDictionary, sectionSelectedItemDict)
JCS_LAZY(NSMutableSet, registerCellClasses)
JCS_LAZY(NSMutableSet, registerHeaderOrFooterClasses)


@end
