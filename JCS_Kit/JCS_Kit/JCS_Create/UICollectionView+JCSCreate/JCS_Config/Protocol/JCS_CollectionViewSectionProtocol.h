//
//  JCS_CollectionViewSectionProtocol.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_CollectionViewSectionProtocol_h
#define JCS_CollectionViewSectionProtocol_h

#import "JCS_CollectionViewItemProtocol.h"

@protocol JCS_CollectionViewSectionProtocol <NSObject>

@required

- (NSInteger)jcs_getItemsCount;
- (id<JCS_CollectionViewItemProtocol>)jcs_getItemAtIndex:(NSInteger)index;

@optional

/// 列数(默认1列), 仅WaterFallLayou使用
- (NSInteger)jcs_columnCount;

- (NSString *)jcs_getHeaderViewClassName;
- (NSString *)jcs_getFooterViewClassName;

- (id)jcs_getHeaderData;
- (id)jcs_getFooterData;

- (CGSize)jcs_getHeaderSize;
- (CGSize)jcs_getFooterSize;

- (UIEdgeInsets)jcs_getSectionInset;

- (CGFloat)jcs_getMinimumLineSpacing;
- (CGFloat)jcs_getMinimumInteritemSpacing;

- (NSString*)jcs_getDecorationClass;
- (UIEdgeInsets)jcs_getDecorationMarginInset;
- (NSInteger)jcs_getDecorationZIndex;
- (id)jcs_getDecorationData;

@end

#endif /* JCS_CollectionViewSectionProtocol_h */
