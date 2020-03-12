//
//  UICollectionViewCell+JCS_Swizzle.h
//  JCS_Category
//
//  Created by 永平 on 2020/2/15.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (JCS_Swizzle)

/** 是否被选中 **/
@property (nonatomic, assign) BOOL jcs_checked;

@end

NS_ASSUME_NONNULL_END
