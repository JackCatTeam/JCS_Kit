//
//  UICollectionReusableView+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionReusableView (JCSCreate)
/**
 从缓冲池中获取HeaderView
 */
+ (instancetype)getHeaderView:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;
+ (instancetype)getHeaderView:(UICollectionView*)collectionView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath;

/**
 从缓冲池中获取FooterView
 */
+ (instancetype)getFooterView:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;
+ (instancetype)getFooterView:(UICollectionView*)collectionView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath;

@end
