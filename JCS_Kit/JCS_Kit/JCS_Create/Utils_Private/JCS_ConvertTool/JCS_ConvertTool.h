//
//  JCS_ConvertTool.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_ConvertTool : NSObject

+ (CGSize)valueToSize:(id)value;

+ (NSInteger)valueToInteger:(id)value;
+ (CGFloat)valueToFloat:(id)value;

+ (UIEdgeInsets)valueToInsets:(id)value;

@end

NS_ASSUME_NONNULL_END
