//
//  UICollectionViewCell+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (JCSCreate)

/**
 从缓冲池中获取Cell
 */
+ (instancetype)getCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;
+ (instancetype)getCell:(UICollectionView*)collectionView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath;

@end
