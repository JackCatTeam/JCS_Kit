//
//  JCS_TableViewModelHelper.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_TableViewModelHelper.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "JCS_Category.h"

#import "UITableViewCell+JCSCreate.h"
#import "UITableViewCell+JCS_Swizzle.h"

#import "UITableViewHeaderFooterView+JCSCreate.h"
#import "UITableViewHeaderFooterView+JCS_Swizzle.h"

#import "JCS_TableViewSectionProtocol.h"

#import "JCS_TableEmptyCell.h"
#import "JCS_TableSectionEmptyView.h"

#import "JCS_TableViewModel.h"

@implementation JCS_TableViewRowModelHelper

+ (instancetype)shareInstance {
    static JCS_TableViewRowModelHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JCS_TableViewRowModelHelper alloc] init];
    });
    return _instance;
}

+ (UITableViewCell*)getCell:(UITableView*)tableView model:(id<JCS_TableViewRowProtocol>)model cellClass:(NSString*)cellClass indexPath:(NSIndexPath*)indexPath {
    return [[self shareInstance] getCell:tableView model:model cellClass:cellClass indexPath:indexPath];
}
+ (CGFloat)getRowHeight:(id<JCS_TableViewRowProtocol>)rowModel {
    if(rowModel.jcs_getCellClass.jcs_isValid && NSClassFromString(rowModel.jcs_getCellClass)){
        return rowModel.jcs_getCellHeight;
    }
    return 0;
}

- (UITableViewCell*)getCell:(UITableView*)tableView model:(id<JCS_TableViewRowProtocol>)model cellClass:(NSString*)cellClass indexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = nil;
    if(cellClass.jcs_isValid){
        cell = [tableView dequeueReusableCellWithIdentifier:cellClass forIndexPath:indexPath];
        if([model respondsToSelector:@selector(jcs_getData)]){
            cell.jcs_data = [model jcs_getData];
        }
        //绑定选中状态
        if([model respondsToSelector:@selector(jcs_checked)]){
            RAC(cell,jcs_checked) = [RACObserve(model, jcs_checked) takeUntil:cell.rac_prepareForReuseSignal];
        }
        return cell;
    }
    return cell;
}

@end


@implementation JCS_TableViewSectionModelHelper

+ (UITableViewHeaderFooterView*)getSectionHeaderView:(UITableView*)tableView model:(id<JCS_TableViewSectionProtocol>)model{
    UITableViewHeaderFooterView *headerView = nil;
    if([model respondsToSelector:@selector(jcs_getHeaderViewClassName)]){
        NSString *className = [model jcs_getHeaderViewClassName];
        if(NSClassFromString(className)){
            headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:className];
            if([model respondsToSelector:@selector(jcs_getHeaderData)]){
                headerView.jcs_data = model.jcs_getHeaderData;
            }
            return headerView;
        }
    }
    return nil;
}
+ (UITableViewHeaderFooterView*)getSectionFooterView:(UITableView*)tableView model:(id<JCS_TableViewSectionProtocol>)model{
    UITableViewHeaderFooterView *footerView = nil;
    if([model respondsToSelector:@selector(jcs_getFooterViewClassName)]){
        NSString *className = [model jcs_getFooterViewClassName];
        if(NSClassFromString(className)){
            footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:className];
            if([model respondsToSelector:@selector(jcs_getFooterData)]){
                footerView.jcs_data = model.jcs_getFooterData;
            }
            return footerView;
        }
    }
    return nil;
}

+ (NSString*)getSectionHeaderTitle:(id<JCS_TableViewSectionProtocol>)model{
    //配置headerClass,则返回nil
    NSString *className = nil;
    if([model respondsToSelector:@selector(jcs_getHeaderViewClassName)]){
        className = [model jcs_getHeaderViewClassName];
    }
    if(className.jcs_isValid){ //配置了class,则不采用title
        return nil;
    }
    return model.jcs_getHeaderTitle;
}
+ (NSString*)getSectionFooterTitle:(id<JCS_TableViewSectionProtocol>)model {
    //配置footerClass,则返回nil
    NSString *className = nil;
    if([model respondsToSelector:@selector(jcs_getFooterViewClassName)]){
        className = [model jcs_getFooterViewClassName];
    }
    if(className.jcs_isValid){ //配置了class,则不采用title
        return nil;
    }
    return model.jcs_getFooterTitle;
}

/**
 思路
 1. 配置了headerClass则不再走headerTitle, 未配置headerClass才走headerTitle
 */
+ (CGFloat)getHeaderSectionHeight:(id<JCS_TableViewSectionProtocol>)model {
    
    CGFloat height = 0;
    if([model respondsToSelector:@selector(jcs_getHeaderHeight)]) {
        height = [model jcs_getHeaderHeight];
    }
    
    if([model respondsToSelector:@selector(jcs_getHeaderViewClassName)] && model.jcs_getHeaderViewClassName.jcs_isValid){
        return height; //实际高度
    }
    
    if([model respondsToSelector:@selector(jcs_getHeaderTitle)]  && model.jcs_getHeaderTitle.jcs_isValid){
        return height > 0 ? height : 44; //实际高度
    }
    
    return 0; //不需要显示
}
+ (CGFloat)getFooterSectionHeight:(id<JCS_TableViewSectionProtocol>)model{
    
    CGFloat height = 0;
    if([model respondsToSelector:@selector(jcs_getFooterHeight)] ) {
        height = [model jcs_getFooterHeight];
    }
    
    if([model respondsToSelector:@selector(jcs_getFooterViewClassName)]  && model.jcs_getFooterViewClassName.jcs_isValid){
        return height; //实际高度
    }
    
    if([model respondsToSelector:@selector(jcs_getFooterTitle)]  && model.jcs_getFooterTitle.jcs_isValid){
        return height > 0 ? height : 44; //实际高度
    }
    
    return 0; //不需要显示
}


@end
