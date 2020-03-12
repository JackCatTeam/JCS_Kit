//
//  JCS_CollectionViewWaterFallLayout.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/11.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_CollectionViewItemProtocol.h"
#import "JCS_CollectionViewSectionProtocol.h"

@class JCS_CollectionViewWaterFallLayout;

@protocol JCS_CollectionViewWaterFallLayoutDelegate <NSObject>

@required

///根据 indexPath 获取 Section 对象
- (id<JCS_CollectionViewSectionProtocol>_Nullable)jcs_waterFallLayout:(JCS_CollectionViewWaterFallLayout * _Nonnull)layout
                                                 sectionWithIndexPath:(NSInteger)section;
///根据 indexPath 获取 Item 对象
- (id<JCS_CollectionViewItemProtocol> _Nullable)jcs_waterFallLayout:(JCS_CollectionViewWaterFallLayout * _Nonnull)layout
                                                  itemWithIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface JCS_CollectionViewWaterFallLayout : UICollectionViewLayout

/** 所有项的布局属性 **/
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> *layoutAttributes;
/** 所有Section下每列column的最大高度/宽度 */
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber*> *> *sectionColumnMaxLengthArray;
/** 内容高度 **/
@property (nonatomic, assign) CGFloat contentHeight;
/** 内容宽度 **/
@property (nonatomic, assign) CGFloat contentWidth;
/** 滚动方向，默认 UICollectionViewScrollDirectionVertical**/
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
/** 代理 **/
@property (nonatomic, weak) id<JCS_CollectionViewWaterFallLayoutDelegate> customerDelegate;

+ (instancetype)jcs_create;

/** 代理 **/
@property (nonatomic,copy,readonly) JCS_CollectionViewWaterFallLayout*(^jcs_customerDelegate)(id<JCS_CollectionViewWaterFallLayoutDelegate> delegate);
/** 滚动方向*/
@property (nonatomic,copy,readonly) JCS_CollectionViewWaterFallLayout*(^jcs_scrollDirectionVertical)(void);
@property (nonatomic,copy,readonly) JCS_CollectionViewWaterFallLayout*(^jcs_scrollDirectionHorizontal)(void);

@end

NS_ASSUME_NONNULL_END
