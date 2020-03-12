//
//  JCS_CollectionViewCustomerLayoutSectionMaxFrameItem.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/28.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_CollectionViewCustomerLayoutSectionMaxFrameItem : NSObject
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

- (CGRect)getSectionFrame;

- (void)configWithAttributesIfNeed:(UICollectionViewLayoutAttributes*)layoutAttributes;
@end

NS_ASSUME_NONNULL_END
