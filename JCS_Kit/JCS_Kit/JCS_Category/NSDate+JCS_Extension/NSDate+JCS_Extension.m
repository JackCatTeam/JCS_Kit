//
//  NSDate+JCS_Extension.m
//  AFNetworking
//
//  Created by 永平 on 2020/1/17.
//

#import "NSDate+JCS_Extension.h"

@implementation NSDate (JCS_Extension)

#pragma mark - 类方法

+ (NSString*)jcs_todayDateString {
    return [self jcs_dateString:[NSDate date] format:@"yyyy-MM-dd"];
}

+ (NSString*)jcs_todayLongTimeString {
    return [self jcs_dateString:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString*)jcs_todayShortTimeString {
    return [self jcs_dateString:[NSDate date] format:@"HH:mm:ss"];
}

+ (NSString*)jcs_dateString:(NSDate*)date format:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

#pragma mark - 示例方法

- (NSString*)jcs_dateString:(NSString*)format {
    return [NSDate jcs_dateString:self format:format];
}

@end
