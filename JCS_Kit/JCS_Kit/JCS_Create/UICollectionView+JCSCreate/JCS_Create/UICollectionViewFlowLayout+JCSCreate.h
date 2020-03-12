//
//  UICollectionViewFlowLayout+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewFlowLayout (JCSCreate)

//layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, ADJ_SIZE_375(250));
//layout.minimumLineSpacing = 0;
//layout.minimumInteritemSpacing = 0;


@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_itemSize)(CGSize size);

@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_minimumLineSpacing )(CGFloat value);
@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_minimumInteritemSpacing)(CGFloat value);

@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_headerReferenceSize)(CGSize size);
@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_footerReferenceSize)(CGSize size);

@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_scrollDirectionVertical)(void);
@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_scrollDirectionHorizontal)(void);

@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_sectionInset)(UIEdgeInsets inset);

//@property (nonatomic,copy,readonly) UICollectionViewFlowLayout*(^jcs_delegate)(id<UICollectionViewDelegateFlowLayout> delegate);

//UIEdgeInsets sectionInset

@end
