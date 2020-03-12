//
//  JCS_CollectionViewModelHelper.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/28.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_CollectionViewItemProtocol.h"
#import "JCS_CollectionViewSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_CollectionViewItemModelHelper:NSObject

+ (UICollectionViewCell*)getCell:(UICollectionView*)collectionView model:(id<JCS_CollectionViewItemProtocol>)model cellClass:(NSString*)cellClass indexPath:(NSIndexPath*)indexPath;
+ (CGSize)getItemSize:(id<JCS_CollectionViewItemProtocol>)model;

@end



@interface JCS_CollectionViewSectionModelHelper:NSObject

+ (UICollectionReusableView*)getSectionView:(UICollectionView*)collectionView model:(id<JCS_CollectionViewSectionProtocol>)model viewForSupplementaryElementOfKind:(NSString*)kind indexPath:(NSIndexPath*)indexPath;

+ (CGSize)getHeaderSectionSize:(id<JCS_CollectionViewSectionProtocol>)model;
+ (CGSize)getFooterSectionSize:(id<JCS_CollectionViewSectionProtocol>)model;

+ (UIEdgeInsets)getSectionInsets:(id<JCS_CollectionViewSectionProtocol>)model;

@end

NS_ASSUME_NONNULL_END
