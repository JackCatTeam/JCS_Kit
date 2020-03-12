//
//  NSString+JCS_Create.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JCS_Create)

+ (NSInteger)jcs_stringToInteger:(NSString*)value;
- (NSInteger)jcs_toInteger;

+ (NSInteger)jcs_stringToFloat:(NSString*)value;
- (NSInteger)jcs_toFloat;

+ (CGSize)jcs_stringToSize:(NSString*)value;
- (CGSize)jcs_toSize;

+ (UIEdgeInsets)jcs_stringToInsets:(NSString*)value;
- (UIEdgeInsets)jcs_toInsets;

@end

NS_ASSUME_NONNULL_END
