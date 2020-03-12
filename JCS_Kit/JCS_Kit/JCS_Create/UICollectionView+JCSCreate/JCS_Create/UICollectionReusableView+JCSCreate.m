//
//  UICollectionReusableView+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UICollectionReusableView+JCSCreate.h"

@implementation UICollectionReusableView (JCSCreate)

+ (instancetype)getHeaderView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    return [self getHeaderView:collectionView identifier:NSStringFromClass(self.class) indexPath:indexPath];
}
+ (instancetype)getHeaderView:(UICollectionView *)collectionView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
}


+ (instancetype)getFooterView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    return [self getFooterView:collectionView identifier:NSStringFromClass(self.class) indexPath:indexPath];
}
+ (instancetype)getFooterView:(UICollectionView *)collectionView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
