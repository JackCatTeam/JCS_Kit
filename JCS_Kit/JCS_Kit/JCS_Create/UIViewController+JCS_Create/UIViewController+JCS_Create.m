//
//  UIViewController+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UIViewController+JCS_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "JCS_Injection.h"
#import <MJExtension/MJExtension.h>
#import "JCS_Create.h"
#import "JCS_ConvertTool.h"

@implementation UIViewController (JCSCreate)

- (UIView *(^)(void))jcs_hideNavigationBar{
    return ^id(void) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        return self;
    };
}
- (UIView *(^)(void))jcs_hideNavigationBarAnim{
    return ^id(void) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        return self;
    };
}
- (UIView *(^)(void))jcs_showNavigationBar{
    return ^id(void) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        return self;
    };
}
- (UIView *(^)(void))jcs_showNavigationBarAnim{
    return ^id(void) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        return self;
    };
}

#pragma mark - 解析 UICollectionView Sections

/// 根据配置文件生成UICollectionView Sections
- (NSMutableArray<JCS_CollectionViewSectionModel*>*)jcs_generateCollectionViewSections {
    //属性值重新注入
    [self jcs_injectProperties];
    NSArray *sectionsConfigArray = [self.jcs_configInfo valueForKey:@"page"];
    NSMutableArray *sections = [NSMutableArray array];
    for (NSDictionary *section in sectionsConfigArray) {
        if([section isKindOfClass:NSDictionary.class]){ //字典
            JCS_CollectionViewSectionModel *sectionModel = [self jcs_generateCollectionViewSectionWithDict:section];
            if(sectionModel){
                [sections addObject:sectionModel];
            }
        } else if([section isKindOfClass:NSString.class] && [(NSString*)section hasPrefix:@"&"]){ //引用
            NSString *key = [(NSString*)section substringFromIndex:1];
            JCS_CollectionViewSectionModel *sectionModel = [self valueForKeyPath:key];
            if(sectionModel && [sectionModel isKindOfClass:JCS_CollectionViewSectionModel.class]){
                [sections addObject:sectionModel];
            }
        }
    }
    return sections;
}
/// 根据字典生成Section
- (JCS_CollectionViewSectionModel*)jcs_generateCollectionViewSectionWithDict:(NSDictionary*)dict {
    if(!(dict && [dict isKindOfClass:NSDictionary.class])){
        return nil;
    }
    
    //hidden == true 不显示
    BOOL hidden = [dict jcs_isBoolTrue:@"hidden"];
    if(hidden){
        return nil;
    }
    
    //showIf
    //不配置，显示
    //配置了，但无效，不显示
    //配置了，且有效，显示
    if([dict.allKeys containsObject:@"showIf"] && ![self jcs_dataIsValid:[dict valueForKey:@"showIf"]]){
        return nil;
    }
    
    JCS_CollectionViewSectionModel *sectionModel = [JCS_CollectionViewSectionModel jcs_create];

    //引用
    NSString *ref = [dict valueForKey:@"ref"];
    if(ref.jcs_isValid){
        id refValue = [self valueForKeyPath:ref];
        if(refValue && [refValue isKindOfClass:JCS_CollectionViewSectionModel.class]){ //类型一致
            sectionModel = refValue;
        } else if(!refValue){ //值为空
            [self setValue:sectionModel forKeyPath:ref];
        }
    }
    
    //列数 (仅 water ayout 使用)
    id columnCount = [dict valueForKey:@"columnCount"];
    if(columnCount){
        sectionModel.columnCount = [JCS_ConvertTool valueToInteger:columnCount];
    }
    
    //header
    NSDictionary *header = [dict valueForKey:@"header"];
    if(header && [header isKindOfClass:NSDictionary.class] && [header valueForKey:@"class"]){
        
        //headerSize
        id sizeValue = [header valueForKey:@"size"];
        CGSize size = [JCS_ConvertTool valueToSize:sizeValue];
        
        //headerClass
        NSString *className = [header valueForKey:@"class"];
        if(className.jcs_isValid && !CGSizeEqualToSize(size, CGSizeZero)){
            sectionModel.headerClass = className;
            sectionModel.headerSize = size;
        }
        
        //headerData
        id headerData = [header valueForKey:@"data"];
        if(headerData){
            sectionModel.headerData = [self jcs_handleDataValue:headerData];
        }
    }
    
    //footer
    NSDictionary *footer = [dict valueForKey:@"footer"];
    if(footer && [footer isKindOfClass:NSDictionary.class]){
        
        //footerSize
        id sizeValue = [footer valueForKey:@"size"];
        CGSize size = [JCS_ConvertTool valueToSize:sizeValue];
        
        //footerClass
        NSString *className = [footer valueForKey:@"class"];
        if(className.jcs_isValid && !CGSizeEqualToSize(size, CGSizeZero)){
            sectionModel.footerClass = className;
            sectionModel.footerSize = size;
        }
        
        //footerData
        id footerData = [footer valueForKey:@"data"];
        if(footerData){
            sectionModel.footerData = [self jcs_handleDataValue:footerData];
        }
    }
    
    //style
    NSDictionary *style = [dict valueForKey:@"style"];
    if(style && [style isKindOfClass:NSDictionary.class]){
        
        id minimumLineSpacing = [style valueForKey:@"minimumLineSpacing"];
        if(minimumLineSpacing){
            sectionModel.minimumLineSpacing = [JCS_ConvertTool valueToFloat:minimumLineSpacing];
        }
        
        id minimumInteritemSpacing = [style valueForKey:@"minimumInteritemSpacing"];
        if(minimumInteritemSpacing){
            sectionModel.minimumInteritemSpacing = [JCS_ConvertTool valueToFloat:minimumInteritemSpacing];
        }

        id sectionInset = [style valueForKey:@"sectionInset"];
        if(sectionInset){
            sectionModel.sectionInset = [JCS_ConvertTool valueToInsets:sectionInset];
        }
    }
    
    //decoration View
    NSDictionary *decoration = [dict valueForKey:@"decoration"];
    if(decoration && [decoration isKindOfClass:NSDictionary.class]){
        NSString *className = [decoration valueForKey:@"class"];
        if(className.jcs_isValid){
            sectionModel.decorationClass = className;
        }
        
        id marginInset = [decoration valueForKey:@"marginInset"];
        if(marginInset){
            sectionModel.decorationMarginInset = [JCS_ConvertTool valueToInsets:marginInset];
        }

        id zIndex = [decoration valueForKey:@"zIndex"];
        if(zIndex){
            sectionModel.decorationZIndex = [JCS_ConvertTool valueToInteger:zIndex];
        }

        id decorationData = [decoration valueForKey:@"data"];
        if(decorationData){
           sectionModel.decorationData = [self jcs_handleDataValue:decorationData];
        }
    }
    
    NSArray *items = [dict valueForKey:@"items"];
    if(items) {
        if([items isKindOfClass:NSString.class]){ //配置了引用
            [self jcs_generateCollectionItemsWithString:(NSString*)items sectionModel:sectionModel];
            
        } else if([items isKindOfClass:NSArray.class]){ //数组，则解析数组
            [self jcs_generateCollectionItemsWithArray:(NSArray*)items sectionModel:sectionModel];
            
        } else {
            //items类型配置错误
        }
    }
    
    return sectionModel;
}

#pragma mark - 解析 UICollectionView Items

///解析Items
- (void)jcs_generateCollectionItemsWithArray:(NSArray*)items sectionModel:(JCS_CollectionViewSectionModel*)sectionModel {
    if(!(items && [items isKindOfClass:NSArray.class])){
        return;
    }
    for (NSDictionary *item in items) {
        if([item isKindOfClass:NSDictionary.class]){
            
            //hidden == true 不显示
            BOOL hidden = [item jcs_isBoolTrue:@"hidden"];
            if(hidden){
                continue;
            }
            
            //showIf
            //不配置，显示
            //配置了，但无效，不显示
            //配置了，且有效，显示
            if([item.allKeys containsObject:@"showIf"] && ![self jcs_dataIsValid:[item valueForKey:@"showIf"]]){
                continue;
            }
            
            JCS_CollectionViewItemModel *itemModel = [JCS_CollectionViewItemModel jcs_create];

            //引用
            NSString *ref = [item valueForKey:@"ref"];
            if(ref.jcs_isValid){
                id refValue = [self valueForKeyPath:ref];
                if(refValue && [refValue isKindOfClass:JCS_CollectionViewItemModel.class]){ //类型一致
                    itemModel = refValue;
                } else if(!refValue){ //值为空
                    [self setValue:itemModel forKeyPath:ref];
                }
            }
            
            //headerClass
            NSString *className = [item valueForKey:@"class"];
            if(className && [className isKindOfClass:NSString.class]){
                itemModel.cellClass = className;
            }
            
            //headerSize
            id sizeValue = [item valueForKey:@"size"];
            itemModel.cellSize = [JCS_ConvertTool valueToSize:sizeValue];
            
            //data
            id data = [item valueForKey:@"data"];
            if(data){
                itemModel.data = [self jcs_handleDataValue:data];
            }
            
            //clickRouter
            NSString *clickRouter = [item valueForKey:@"clickRouter"];
            if(clickRouter && [clickRouter isKindOfClass:NSString.class]){
                itemModel.clickRouter = clickRouter;
            }
            
            //checked
            NSString *checked = [item valueForKey:@"checked"];
            if(checked){
                if([checked isKindOfClass:NSString.class] && ( [checked isEqualToString:@"1"] || [checked isEqualToString:@"true"])){
                    itemModel.jcs_checked = YES;
                } else if([checked isKindOfClass:NSNumber.class] && [(NSNumber*)checked integerValue] == 1){
                    itemModel.jcs_checked = YES;
                }
            }
            
            [sectionModel.items addObject:itemModel];
            
        } else if([item isKindOfClass:NSString.class] && [(NSString*)item hasPrefix:@"&"]){ //引用
            NSString *key = [(NSString*)item substringFromIndex:1];
            JCS_CollectionViewItemModel *itemModel = [self valueForKeyPath:key];
            if(itemModel && [itemModel isKindOfClass:JCS_CollectionViewItemModel.class]){
                [sectionModel.items addObject:itemModel];
            }
        }
    }
}
- (void)jcs_generateCollectionItemsWithString:(NSString*)items sectionModel:(JCS_CollectionViewSectionModel*)sectionModel {
    if(!(items && [items isKindOfClass:NSString.class] && items.jcs_isValid)){
        return;
    }
    NSString *itemsString = (NSString*)items;
    if([itemsString hasPrefix:@"&"]){
        NSString *key = [itemsString substringFromIndex:1];
        id value = [self valueForKey:key];
        if(value){
            if([value isKindOfClass:NSArray.class]){
                sectionModel.items = value;
            } else {
                //引用获取到值不是数组，错误
            }
        } else {
            //引用获取到值未空
        }
    } else {
        //配置未字符串常量，错误
    }
}

#pragma mark - 解析 UITableView Sections

/// 根据配置文件生成UICollectionView Sections
- (NSMutableArray<JCS_TableViewSectionModel*>*)jcs_generateTableViewSections {
    //属性值重新注入
    [self jcs_injectProperties];
    NSArray *sectionsConfigArray = [self.jcs_configInfo valueForKey:@"page"];
    NSMutableArray *sections = [NSMutableArray array];
    for (NSDictionary *section in sectionsConfigArray) {
        if([section isKindOfClass:NSDictionary.class]){ //字典
            JCS_TableViewSectionModel *sectionModel = [self jcs_generateTableViewSectionWithDict:section];
            if(sectionModel){
                [sections addObject:sectionModel];
            }
        } else if([section isKindOfClass:NSString.class] && [(NSString*)section hasPrefix:@"&"]){ //引用
            NSString *key = [(NSString*)section substringFromIndex:1];
            JCS_TableViewSectionModel *sectionModel = [self valueForKeyPath:key];
            if(sectionModel && [sectionModel isKindOfClass:JCS_TableViewSectionModel.class]){
                [sections addObject:sectionModel];
            }
        }
    }
    return sections;
}
/// 根据字典生成Section
- (JCS_TableViewSectionModel*)jcs_generateTableViewSectionWithDict:(NSDictionary*)dict {
    if(!(dict && [dict isKindOfClass:NSDictionary.class])){
        return nil;
    }
    
    //hidden == true 不显示
    BOOL hidden = [dict jcs_isBoolTrue:@"hidden"];
    if(hidden){
        return nil;
    }
    
    //showIf
    //不配置，显示
    //配置了，但无效，不显示
    //配置了，且有效，显示
    if([dict.allKeys containsObject:@"showIf"] && ![self jcs_dataIsValid:[dict valueForKey:@"showIf"]]){
        return nil;
    }
    
    JCS_TableViewSectionModel *sectionModel = [JCS_TableViewSectionModel jcs_create];
    
    //引用
    NSString *ref = [dict valueForKey:@"ref"];
    if(ref.jcs_isValid){
        id refValue = [self valueForKeyPath:ref];
        if(refValue && [refValue isKindOfClass:JCS_TableViewSectionModel.class]){ //类型一致
            sectionModel = refValue;
        } else if(!refValue){ //值为空
            [self setValue:sectionModel forKeyPath:ref];
        }
    }

    //header
    NSDictionary *header = [dict valueForKey:@"header"];
    if(header && [header isKindOfClass:NSDictionary.class]){
        //height
        sectionModel.headerHeight = [JCS_ConvertTool valueToFloat:[header valueForKey:@"height"]];
        //headerClass
        sectionModel.headerClass = [header valueForKey:@"class"];
        //Title
        sectionModel.headerTitle = [self jcs_handleDataValue:[header valueForKey:@"title"]];
        //headerData
        id headerData = [header valueForKey:@"data"];
        if(headerData){
            sectionModel.headerData = [self jcs_handleDataValue:headerData];
        }
    }
    
    //footer
    NSDictionary *footer = [dict valueForKey:@"footer"];
    if(footer && [footer isKindOfClass:NSDictionary.class]){
        
        //height
        sectionModel.footerHeight = [JCS_ConvertTool valueToFloat:[footer valueForKey:@"height"]];
        //Class
        sectionModel.footerClass = [footer valueForKey:@"class"];
        //Title
        sectionModel.footerTitle = [self jcs_handleDataValue:[footer valueForKey:@"title"]];
        //Data
        id data = [footer valueForKey:@"data"];
        if(data){
            sectionModel.headerData = [self jcs_handleDataValue:data];
        }
    }
    
    NSArray *rows = [dict valueForKey:@"rows"];
    if(rows) {
        if([rows isKindOfClass:NSString.class]){ //配置了引用
            [self jcs_generateTableRowsWithString:(NSString*)rows sectionModel:sectionModel];
            
        } else if([rows isKindOfClass:NSArray.class]){ //数组，则解析数组
            [self jcs_generateTableRowsWithArray:(NSArray*)rows sectionModel:sectionModel];
            
        } else {
            //items类型配置错误
        }
    }
    
    return sectionModel;
}


#pragma mark - 解析 UITableView Rows

///解析Items
- (void)jcs_generateTableRowsWithArray:(NSArray*)items sectionModel:(JCS_TableViewSectionModel*)sectionModel {
    if(!(items && [items isKindOfClass:NSArray.class])){
        return;
    }
    for (NSDictionary *item in items) {
        if([item isKindOfClass:NSDictionary.class]){
                        
            //hidden == true 不显示
            BOOL hidden = [item jcs_isBoolTrue:@"hidden"];
            if(hidden){
                continue;
            }
            
            //showIf
            //不配置，显示
            //配置了，但无效，不显示
            //配置了，且有效，显示
            if([item.allKeys containsObject:@"showIf"] && ![self jcs_dataIsValid:[item valueForKey:@"showIf"]]){
                continue;
            }
            
            JCS_TableViewRowModel *itemModel = [JCS_TableViewRowModel jcs_create];

            //引用
            NSString *ref = [item valueForKey:@"ref"];
            if(ref.jcs_isValid){
                id refValue = [self valueForKeyPath:ref];
                if(refValue && [refValue isKindOfClass:JCS_TableViewRowModel.class]){ //类型一致
                    itemModel = refValue;
                } else if(!refValue){ //值为空
                    [self setValue:itemModel forKeyPath:ref];
                }
            }
            
            //headerClass
            NSString *className = [item valueForKey:@"class"];
            if(className && [className isKindOfClass:NSString.class]){
                itemModel.cellClass = className;
            }
            
            //header height
            itemModel.cellHeight = [JCS_ConvertTool valueToFloat:[item valueForKey:@"height"]];
            
            //data
            id data = [item valueForKey:@"data"];
            if(data){
                itemModel.data = [self jcs_handleDataValue:data];
            }
            
            //clickRouter
            NSString *clickRouter = [item valueForKey:@"clickRouter"];
            if(clickRouter && [clickRouter isKindOfClass:NSString.class]){
                itemModel.clickRouter = clickRouter;
            }
            
            //checked
            NSString *checked = [item valueForKey:@"checked"];
            if(checked){
                if([checked isKindOfClass:NSString.class] && ( [checked isEqualToString:@"1"] || [checked isEqualToString:@"true"])){
                    itemModel.jcs_checked = YES;
                } else if([checked isKindOfClass:NSNumber.class] && [(NSNumber*)checked integerValue] == 1){
                    itemModel.jcs_checked = YES;
                }
            }
            
            [sectionModel.rows addObject:itemModel];
            
        } else if([item isKindOfClass:NSString.class] && [(NSString*)item hasPrefix:@"&"]){ //引用
            NSString *key = [(NSString*)item substringFromIndex:1];
            JCS_TableViewRowModel *itemModel = [self valueForKeyPath:key];
            if(itemModel && [itemModel isKindOfClass:JCS_TableViewRowModel.class]){
                [sectionModel.rows addObject:itemModel];
            }
        }
    }
}
- (void)jcs_generateTableRowsWithString:(NSString*)items sectionModel:(JCS_TableViewSectionModel*)sectionModel {
    if(!(items && [items isKindOfClass:NSString.class] && items.jcs_isValid)){
        return;
    }
    NSString *itemsString = (NSString*)items;
    if([itemsString hasPrefix:@"&"]){
        NSString *key = [itemsString substringFromIndex:1];
        id value = [self valueForKey:key];
        if(value){
            if([value isKindOfClass:NSArray.class]){
                sectionModel.rows = value;
            } else {
                //引用获取到值不是数组，错误
            }
        } else {
            //引用获取到值未空
        }
    } else {
        //配置未字符串常量，错误
    }
}

/// 处理data属性值
- (id)jcs_handleDataValue:(id)oriValue {
    if(!oriValue){
        return nil;
    }
    if([oriValue isKindOfClass:NSString.class]
       && [(NSString*)oriValue hasPrefix:@"&"]){ //地址引用
        NSString *key = [(NSString*)oriValue substringFromIndex:1];
        return [self valueForKeyPath:key];
//        @weakify(self)
//        [[self rac_valuesForKeyPath:key observer:self] subscribeNext:^(id  _Nullable x) {
//            @strongify(self)
//            sectionModel.headerData = [self valueForKeyPath:key];
//            NSIndexPath *indexPath = sectionModel.indexPath;
//            if(indexPath){
//                [UIView animateWithDuration:0 animations:^{
//                    [self.collectionView performBatchUpdates:^{
//                        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
//                    } completion:nil];
//                }];
//            }
//        }];
    } else if([oriValue isKindOfClass:NSDictionary.class]){ //字典
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:oriValue];
        for (NSString *key in dict.allKeys) {
            dict[key] = [self jcs_handleDataValue:dict[key]];
        }
        Class clazz = [dict jcs_getModelClass];
        if(clazz){ //模型转换
            return [clazz mj_objectWithKeyValues:dict];
        }
        return dict;
        
    } else if([oriValue isKindOfClass:NSArray.class]) { //数组
        NSMutableArray *array = [NSMutableArray arrayWithArray:oriValue];
        for (NSInteger index = 0; index < array.count; index++) {
            id item = array[index];
            id newItem = [self jcs_handleDataValue:item];
            array[index] = newItem;
        }
        return array;
    }
    //字面值
    return oriValue;
}
/// 数据是否有效
- (BOOL)jcs_dataIsValid:(id)data {
    BOOL valid = NO;
    if([data isKindOfClass:NSString.class]){ //字符串或引用，需有效
        if([(NSString*)data hasPrefix:@"&"]){
            valid = [self jcs_dataIsValid:[self jcs_handleDataValue:data]];
        } else {
            valid = ((NSString*)data).jcs_isValid;
        }
    } else if([data isKindOfClass:NSNumber.class]){ //数字 > 0
        valid = [(NSNumber*)data integerValue] > 0;
    } else {    //其他类型不为空
        valid = (data != nil);
    }
    return valid;
}

#pragma mark - 转场

- (void)jcs_transition:(UIViewController*)transToVC completion:(void(^)(void))completion {
    CGFloat duration = 0.3;
    [self jcs_transition:transToVC duration:duration completion:completion];
}
- (void)jcs_transition:(UIViewController*)transToVC duration:(CGFloat)duration completion:(void(^)(void))completion {
    
    UIViewController *lastChildVC = self.childViewControllers.lastObject;
    [self addChildViewController:transToVC];
    
    UIView *newView = transToVC.view;
    newView.frame = self.view.bounds;
    
    if(lastChildVC) { //如果已经有childVC，则切换，反之直接添加
        [lastChildVC willMoveToParentViewController:nil];
        [self transitionFromViewController:lastChildVC toViewController:transToVC duration:duration options:(UIViewAnimationOptionTransitionCrossDissolve) animations:nil completion:^(BOOL finished) {
            [lastChildVC removeFromParentViewController];
            [transToVC didMoveToParentViewController:self];
            if(completion){
                completion();
            }
        }];
    } else {
        [self.view addSubview:newView];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        } completion:^(BOOL finished) {
            [transToVC didMoveToParentViewController:self];
            if(completion){
                completion();
            }
        }];
    }
}


@end
