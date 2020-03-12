//
//  UICollectionViewCell+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UICollectionViewCell+JCSCreate.h"

@implementation UICollectionViewCell (JCSCreate)

+ (instancetype)getCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    return [self getCell:collectionView identifier:NSStringFromClass(self.class) indexPath:indexPath];
}

+ (instancetype)getCell:(UICollectionView *)collectionView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
