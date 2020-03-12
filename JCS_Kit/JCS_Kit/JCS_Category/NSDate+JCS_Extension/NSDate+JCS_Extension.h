//
//  NSDate+JCS_Extension.h
//  AFNetworking
//
//  Created by 永平 on 2020/1/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JCS_Extension)

#pragma mark - 类方法

+ (NSString*)jcs_todayDateString;
+ (NSString*)jcs_todayLongTimeString;
+ (NSString*)jcs_todayShortTimeString;
+ (NSString*)jcs_dateString:(NSDate*)date format:(NSString*)format;

#pragma mark - 示例方法

- (NSString*)jcs_dateString:(NSString*)format;

@end

NS_ASSUME_NONNULL_END
