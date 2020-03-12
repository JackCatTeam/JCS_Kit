//
//  NSDictionary+JCS_Create.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JCS_Create)

+ (CGSize)jcs_dictionaryToSize:(NSDictionary*)value;
- (CGSize)jcs_toSize;

+ (UIEdgeInsets)jcs_dictionaryToInsets:(NSDictionary*)value;
- (UIEdgeInsets)jcs_toInsets;

@end

NS_ASSUME_NONNULL_END
