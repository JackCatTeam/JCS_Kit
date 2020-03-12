//
//  JCS_CollectionViewModelHelper.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/28.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewModelHelper.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import "JCS_Category.h"
#import "JCS_BaseLib.h"
#import "JCS_CollectionViewItemProtocol.h"
#import "JCS_CollectionViewSectionProtocol.h"
#import "JCS_Create_Common.h"
#import "UICollectionViewCell+JCSCreate.h"
#import "UICollectionReusableView+JCSCreate.h"

@implementation JCS_CollectionViewItemModelHelper

+ (instancetype)shareInstance {
    static JCS_CollectionViewItemModelHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JCS_CollectionViewItemModelHelper alloc] init];
    });
    return _instance;
}

+ (UICollectionViewCell*)getCell:(UICollectionView*)collectionView model:(id<JCS_CollectionViewItemProtocol>)model cellClass:(NSString*)cellClass indexPath:(NSIndexPath*)indexPath {
    return [[self shareInstance] getCell:collectionView model:model cellClass:cellClass indexPath:indexPath];
}

+ (CGSize)getItemSize:(id<JCS_CollectionViewItemProtocol>)model {
    if(model.jcs_getCellClass.jcs_isValid && NSClassFromString(model.jcs_getCellClass)){
        return model.jcs_getCellSize;
    }
    //2. Item Model cell Size
    return CGSizeZero;
}

- (UICollectionViewCell*)getCell:(UICollectionView*)collectionView model:(id<JCS_CollectionViewItemProtocol>)model cellClass:(NSString*)cellClass indexPath:(NSIndexPath*)indexPath {
    UICollectionViewCell *cell = nil;
    if(cellClass.jcs_isValid){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellClass forIndexPath:indexPath];
        if([model respondsToSelector:@selector(jcs_getData)]){
            cell.jcs_data = [model jcs_getData];
        }
        //绑定选中状态
        if([model respondsToSelector:@selector(jcs_checked)]){
            RAC(cell,jcs_checked) = [RACObserve(model, jcs_checked) takeUntil:cell.rac_prepareForReuseSignal];
        }
    }
    return cell;
}

@end


@implementation JCS_CollectionViewSectionModelHelper

+ (UICollectionReusableView*)getSectionView:(UICollectionView*)collectionView model:(id<JCS_CollectionViewSectionProtocol>)model viewForSupplementaryElementOfKind:(NSString*)kind indexPath:(NSIndexPath*)indexPath{
    UICollectionReusableView *sectionView = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if([model respondsToSelector:@selector(jcs_getHeaderViewClassName)]){
            NSString *className = [model jcs_getHeaderViewClassName];
            if(!className.jcs_isValid){
                className = kUICollectionViewDefaultHeaderClass;
            }
            sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:className forIndexPath:indexPath];
            if([model respondsToSelector:@selector(jcs_getHeaderData)]){
                sectionView.jcs_data = [model jcs_getHeaderData];
            }
        }
        
    } else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        if([model respondsToSelector:@selector(jcs_getFooterViewClassName)]){
            NSString *className = [model jcs_getFooterViewClassName];
            if(!className.jcs_isValid){
                className = kUICollectionViewDefaultFooterClass;
            }
            sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:className forIndexPath:indexPath];
            if([model respondsToSelector:@selector(jcs_getFooterData)]){
                sectionView.jcs_data = [model jcs_getFooterData];
            }
        }
    }
    
    return sectionView;
}

+ (CGSize)getHeaderSectionSize:(id<JCS_CollectionViewSectionProtocol>)model {
    if([model respondsToSelector:@selector(jcs_getHeaderSize)]){
        return [model jcs_getHeaderSize];
    }
    return CGSizeZero;
}
+ (CGSize)getFooterSectionSize:(id<JCS_CollectionViewSectionProtocol>)model {
    if([model respondsToSelector:@selector(jcs_getFooterSize)]){
        return [model jcs_getFooterSize];
    }
    return CGSizeZero;
}

+ (UIEdgeInsets)getSectionInsets:(id<JCS_CollectionViewSectionProtocol>)model {
    if([model respondsToSelector:@selector(jcs_getSectionInset)]){
        return [model jcs_getSectionInset];
    }
    return UIEdgeInsetsZero;
}

@end
