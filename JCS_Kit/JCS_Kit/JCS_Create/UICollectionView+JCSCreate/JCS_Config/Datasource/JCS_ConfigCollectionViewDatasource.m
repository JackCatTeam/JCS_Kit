//
//  JCS_ConfigCollectionViewDatasource.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_ConfigCollectionViewDatasource.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "JCS_Router.h"
#import "UIView+JCSCreate.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "UICollectionReusableView+JCSCreate.h"
#import "UICollectionViewCell+JCSCreate.h"

#import "JCS_RouterTool.h"
#import "JCS_CollectionViewModel.h"
#import "JCS_CollectionViewFlowLayout.h"
#import "JCS_Create_Common.h"
#import "JCS_CollectionViewModelHelper.h"

@interface JCS_ConfigCollectionViewDatasource()<JCS_CollectionViewFlowLayoutDelegate>
/** 选中SectionItem **/
@property (nonatomic, strong) NSMutableDictionary *sectionSelectedItemDict;
/** 已注册的Cell **/
@property (nonatomic, strong) NSMutableSet<NSString*> *registerCellClasses;
/** 已注册的 Header or Footer **/
@property (nonatomic, strong) NSMutableSet<NSString*> *registerHeaderOrFooterClasses;

@end

@implementation JCS_ConfigCollectionViewDatasource

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate numberOfSectionsInCollectionView:collectionView];
    }
    //2. config
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView numberOfItemsInSection:section];
    }
    //2. config
    return  [self.sections[section] jcs_getItemsCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JCS_CollectionViewItemProtocol> itemModel = [self.sections[indexPath.section] jcs_getItemAtIndex:indexPath.item];
    //选择状态
     if([itemModel respondsToSelector:@selector(jcs_checked)] && [itemModel respondsToSelector:@selector(setJcs_checked:)] && itemModel.jcs_checked){
        //设置选中状态
        [self handleItemCheckedState:collectionView indexPath:indexPath];
    }
    //Cell未注册，则自动注册
    NSString *cellClass = itemModel.jcs_getCellClass;
    if(!cellClass.jcs_isValid){
        cellClass = self.defaultCellClassName;
    }
    //Cell未注册，则自动注册
    [self registerCellClassIfNeed:cellClass collectionView:collectionView];
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        UICollectionViewCell *cell = [self.customerDelegate collectionView:collectionView cellForItemAtIndexPath:indexPath];
        cell.jcs_eventBus = self.eventBus;
        return cell;
    }
    //2. Config
    UICollectionViewCell *cell = [JCS_CollectionViewItemModelHelper getCell:collectionView model:itemModel cellClass:cellClass indexPath:indexPath];
    cell.jcs_eventBus = self.eventBus;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    id<JCS_CollectionViewSectionProtocol> sectionModel = self.sections[indexPath.section];
    
    //Cell未注册，则自动注册
    if([sectionModel respondsToSelector:@selector(jcs_getHeaderViewClassName)]) {
        [self registerHeaderOrFooterClassIfNeed:[sectionModel jcs_getHeaderViewClassName] kind:UICollectionElementKindSectionHeader collectionView:collectionView];
    }
    if([sectionModel respondsToSelector:@selector(jcs_getFooterViewClassName)]) {
        [self registerHeaderOrFooterClassIfNeed:[sectionModel jcs_getFooterViewClassName] kind:UICollectionElementKindSectionFooter collectionView:collectionView];
    }
    
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        UICollectionReusableView *sectionView = [self.customerDelegate collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        sectionView.jcs_eventBus = self.eventBus;
        return sectionView;
    }
    
    //2. config
    UICollectionReusableView *sectionView = [JCS_CollectionViewSectionModelHelper getSectionView:collectionView model:sectionModel viewForSupplementaryElementOfKind:kind indexPath:indexPath];
    sectionView.jcs_eventBus = self.eventBus;
    return sectionView;
}


#pragma mark - UICollectionViewDelegate

//优先级 clickRouter > didSelectRowBlock > customerDelegate > defaultRowClickRouter
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JCS_CollectionViewItemProtocol> model = [self.sections[indexPath.section] jcs_getItemAtIndex:indexPath.item];
    
    //设置选中状态(外部处理点击事件，则点击状态也由外部自己处理)
    if(!(self.customerDidSelectRowBlock != nil || (self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]))){
        if([model respondsToSelector:@selector(jcs_checked)] && [model respondsToSelector:@selector(setJcs_checked:)]){
            model.jcs_checked = !model.jcs_checked;
            [self handleItemCheckedState:collectionView indexPath:indexPath];
        }
    }
    
    //路由数据
    id data = nil;
    if([model respondsToSelector:@selector(jcs_getData)]){
        data = [model jcs_getData];
    }
    
    //协议路由
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
    
    //3. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        [self.customerDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        return;
    }
    
    //最后执行默认路由
    if(self.defaultItemClickRouter.jcs_isValid){
        [JCS_RouterTool executeRouter:self.defaultItemClickRouter data:data];
        return;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    
    //2. config
    id<JCS_CollectionViewItemProtocol> itemModel = [self.sections[indexPath.section] jcs_getItemAtIndex:indexPath.item];
    CGSize itemSize = [itemModel jcs_getCellSize];
    if(!CGSizeEqualToSize(itemSize, CGSizeZero)){
        return itemSize;
    }
    
    //3. collectionViewLayout.itemSize
    if([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        return ((UICollectionViewFlowLayout*)collectionViewLayout).itemSize;
    }
    
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }

    //2. config
    id<JCS_CollectionViewSectionProtocol> sectionModel = self.sections[section];
    if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)]){
        UIEdgeInsets sectionInset = [sectionModel jcs_getSectionInset];
        if(!UIEdgeInsetsEqualToEdgeInsets(sectionInset, UIEdgeInsetsZero)){
            return sectionInset;
        }
    }
    
    if([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        return ((UICollectionViewFlowLayout*)collectionViewLayout).sectionInset;
    }
    
    return kUICollectionViewDefaulSectionInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = self.sections[section];
    
    //2. config
    if([sectionModel respondsToSelector:@selector(jcs_getMinimumLineSpacing)]){
        if([sectionModel jcs_getMinimumLineSpacing] > 0){
            return [sectionModel jcs_getMinimumLineSpacing];
        }
    }
    
    if([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        return ((UICollectionViewFlowLayout*)collectionViewLayout).minimumLineSpacing;
    }
    
    return kUICollectionViewDefaultMinimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = self.sections[section];
    //2. config
    if([sectionModel respondsToSelector:@selector(jcs_getMinimumInteritemSpacing)]){
        if([sectionModel jcs_getMinimumInteritemSpacing] > 0){
            return [sectionModel jcs_getMinimumInteritemSpacing];
        }
    }
    
    if([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        return ((UICollectionViewFlowLayout*)collectionViewLayout).minimumInteritemSpacing;
    }
    
    return kUICollectionViewDefaultMinimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = self.sections[section];
    //2. config
    if([sectionModel respondsToSelector:@selector(jcs_getHeaderSize)]){
        if(!CGSizeEqualToSize(CGSizeZero, sectionModel.jcs_getHeaderSize)){
            return sectionModel.jcs_getHeaderSize;
        }
    }
   
   if([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
       return ((UICollectionViewFlowLayout*)collectionViewLayout).headerReferenceSize;
   }
   
   return kUICollectionViewDefaultHeaderSize;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    //1. 外部代理
    if(self.customerDelegate && [self.customerDelegate respondsToSelector:_cmd]){
        return [self.customerDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = self.sections[section];
    //2. config
    if([sectionModel respondsToSelector:@selector(jcs_getFooterSize)]){
        if(!CGSizeEqualToSize(CGSizeZero, sectionModel.jcs_getFooterSize)){
            return sectionModel.jcs_getFooterSize;
        }
    }
    
    if([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        return ((UICollectionViewFlowLayout*)collectionViewLayout).footerReferenceSize;
    }
    
    return kUICollectionViewDefaultFooterSize;
}

#pragma mark - JCS_CollectionViewFlowLayoutDelegate

- (id<JCS_CollectionViewSectionProtocol>)jcs_FlowLayout:(JCS_CollectionViewFlowLayout * _Nonnull)layout sectionWithIndexPath:(NSInteger)section {
    return self.sections[section];
}

#pragma mark - 私有方法

///处理Item选中状态
- (void)handleItemCheckedState:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath {
    
    id<JCS_CollectionViewItemProtocol> model = [self.sections[indexPath.section] jcs_getItemAtIndex:indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%zd",indexPath.section];

    if(self.selectMode == JCS_SelectModeSingle){ //全局单选
        if(self.sectionSelectedItemDict.allKeys.count > 0){
            id<JCS_CollectionViewItemProtocol> currentCheckModel = self.sectionSelectedItemDict.allValues.firstObject;
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
        
        id<JCS_CollectionViewItemProtocol> currentCheckModel = [self.sectionSelectedItemDict valueForKey:key];
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
- (void)registerCellClassIfNeed:(NSString*)className collectionView:(UICollectionView*)collectionView{
    NSAssert(className.jcs_isValid,@"JCS: UICollectionView CellClassName 为空");
    if(className.jcs_isValid && ![self.registerCellClasses containsObject:className]){
        Class clazz = NSClassFromString(className);
        NSAssert1(clazz != NULL,@"JCS: UICollectionView CellClassName %@ 异常",className);
        if(clazz){
            [self.registerCellClasses addObject:className];
            [collectionView registerClass:clazz forCellWithReuseIdentifier:className];
        }
    }
}
- (void)registerHeaderOrFooterClassIfNeed:(NSString*)className kind:(NSString*)kind collectionView:(UICollectionView*)collectionView{
    if(className.jcs_isValid && ![self.registerHeaderOrFooterClasses containsObject:className]){
    
        Class clazz = NSClassFromString(className);
        NSAssert1(clazz != NULL,@"JCS: UICollectionView CellClassName %@ 异常",className);
        
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            NSAssert1(clazz != NULL,@"JCS: UICollectionView SectionHeaderClassName %@ 异常",className);
        } else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
            NSAssert1(clazz != NULL,@"JCS: UICollectionView SectionFooterClassName %@ 异常",className);
        }
        
        if(clazz){
            [self.registerHeaderOrFooterClasses addObject:className];
            [collectionView registerClass:clazz forSupplementaryViewOfKind:kind withReuseIdentifier:className];
        }
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

#pragma mark - setter

- (void)setSections:(NSArray<id<JCS_CollectionViewSectionProtocol>> *)sections {
    _sections = sections;
    if(self.collectionViewLayout ) {
        if([self.collectionViewLayout isKindOfClass:JCS_CollectionViewFlowLayout.class]){ //流式布局
            ((JCS_CollectionViewFlowLayout*)self.collectionViewLayout).jcs_layoutDelegate = self;
        }
        if(sections){
            [self.collectionViewLayout.collectionView reloadData];
        }
    }
}

#pragma mark - 懒加载

JCS_LAZY(NSMutableDictionary, sectionSelectedItemDict)
JCS_LAZY(NSMutableSet, registerCellClasses)
JCS_LAZY(NSMutableSet, registerHeaderOrFooterClasses)

@end
