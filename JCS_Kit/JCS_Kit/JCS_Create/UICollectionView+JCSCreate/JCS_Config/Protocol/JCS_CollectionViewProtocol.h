//
//  JCS_CollectionViewProtocol.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_CollectionViewProtocol_h
#define JCS_CollectionViewProtocol_h

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wnullability-completeness"

//这里避免继承 UICollectionViewDataSource 的原因是，UICollectionViewDataSource有两个方法是@required的
//但对于外部来说不是必须的。这样做避免外部没有实现@required而出现警告
@protocol JCS_CollectionViewProtocol <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@optional

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *_Nonnull)collectionView;

- (NSInteger)collectionView:(UICollectionView *_Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;

- (UICollectionViewCell *_Nonnull)collectionView:(UICollectionView *_Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath *_Nonnull)indexPath;

- (UICollectionReusableView *_Nonnull)collectionView:(UICollectionView *_Nonnull)collectionView viewForSupplementaryElementOfKind:(NSString *_Nonnull)kind atIndexPath:(NSIndexPath *_Nonnull)indexPath;

- (BOOL)collectionView:(UICollectionView *_Nonnull)collectionView canMoveItemAtIndexPath:(NSIndexPath *_Nonnull)indexPath;

- (void)collectionView:(UICollectionView *_Nonnull)collectionView moveItemAtIndexPath:(NSIndexPath *_Nonnull)sourceIndexPath toIndexPath:(NSIndexPath*_Nonnull)destinationIndexPath;

- (nullable NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *_Nonnull)collectionView;

@end

#pragma clang diagnostic pop

#endif /* JCS_CollectionViewProtocol_h */
