//
//  JCS_CollectionViewFlowLayout.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_CollectionViewSectionProtocol.h"

@class JCS_CollectionViewFlowLayout;

@protocol JCS_CollectionViewFlowLayoutDelegate <NSObject>

- (id<JCS_CollectionViewSectionProtocol>_Nullable)jcs_FlowLayout:(JCS_CollectionViewFlowLayout * _Nonnull)layout sectionWithIndexPath:(NSInteger)section;

@end

NS_ASSUME_NONNULL_BEGIN

@interface JCS_CollectionViewFlowLayout : UICollectionViewFlowLayout

//@property (nonatomic, strong) NSArray<id<JCS_CollectionViewSectionProtocol>*> *customerSections;

@property (nonatomic, weak) id<JCS_CollectionViewFlowLayoutDelegate> jcs_layoutDelegate;

@end

NS_ASSUME_NONNULL_END
