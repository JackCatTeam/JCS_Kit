//
//  UITableViewCell+JCS_Swizzle.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (JCS_Swizzle)

/** 是否被选中 **/
@property (nonatomic, assign) BOOL jcs_checked;

@end

NS_ASSUME_NONNULL_END
