//
//  NSArray+JCS_Create.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JCS_Create)

+ (CGSize)jcs_arrayToSize:(NSArray*)value;
- (CGSize)jcs_toSize;

+ (UIEdgeInsets)jcs_arrayToInsets:(NSArray*)value;
- (UIEdgeInsets)jcs_toInsets;

@end

NS_ASSUME_NONNULL_END
