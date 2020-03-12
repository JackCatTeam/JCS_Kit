//
//  UICollectionView+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (JCSCreate)

+ (instancetype)jcs_createWithLayout:(UICollectionViewLayout*)layout;
/**
 注册 Cell
 */
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerCellClass)(NSString *className);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerCellClasses)(NSArray<NSString*> *classNames);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerCellClassWithIdentifier)(NSString *className,NSString *identifier);

/**
 注册 Section Header
*/
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerSectionHeaderClass)(NSString *className);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerSectionHeaderClasses)(NSArray<NSString*> *classNames);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerSectionHeaderClassWithIdentifier)(NSString *className,NSString *identifier);

/**
 注册 Section Footer
*/
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerSectionFooterClass)(NSString *className);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerSectionFooterClasses)(NSArray<NSString*> *classNames);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_registerSectionFooterClassWithIdentifier)(NSString *className,NSString *identifier);

/**
 代理及数据源
*/
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_delegate)(id<UICollectionViewDelegate> delegate);
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_dataSource)(id<UICollectionViewDataSource> dataSource);

/**
 切换Layout对象
*/
@property (nonatomic,copy,readonly) UICollectionView*(^jcs_customerLayout)(UICollectionViewLayout *layout,BOOL animated);

@end
