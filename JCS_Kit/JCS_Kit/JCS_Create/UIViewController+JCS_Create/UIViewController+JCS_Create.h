//
//  UIViewController+JCS_Create.h
//  NingTai
//
//  Created by 永平 on 2018/4/10.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCS_CollectionViewSectionModel;
@class JCS_TableViewSectionModel;

@interface UIViewController (JCSCreate)
/**
 隐藏导航栏,无动画
 */
@property (nonatomic,copy,readonly) UIView*(^jcs_hideNavigationBar)(void);
/**
 显示导航栏,无动画
 */
@property (nonatomic,copy,readonly) UIView*(^jcs_showNavigationBar)(void);
/**
 隐藏导航栏,带动画
 */
@property (nonatomic,copy,readonly) UIView*(^jcs_hideNavigationBarAnim)(void);
/**
 显示导航栏,带动和
 */
@property (nonatomic,copy,readonly) UIView*(^jcs_showNavigationBarAnim)(void);

#pragma mark - UICollectionView Sections

/// 根据配置文件生成UICollectionView Sections
- (NSMutableArray<JCS_CollectionViewSectionModel*>*)jcs_generateCollectionViewSections;
/// 根据配置文件生成UICollectionView Sections
- (NSMutableArray<JCS_TableViewSectionModel*>*)jcs_generateTableViewSections;

#pragma mark - 转场

/// 转场切换，默认切换时间0.3s
- (void)transition:(UIViewController*)toChild completion:(void(^)(void))completion;
- (void)jcs_transition:(UIViewController*)transToVC duration:(CGFloat)duration completion:(void(^)(void))completion;

@end
