//
//  NSArray+JCS_Log.m
//  AFNetworking
//
//  Created by 永平 on 2020/1/20.
//

#import "NSArray+JCS_Log.h"

@implementation NSArray (JCS_Log)
#ifdef DEBUG
/**
 改写数组的日志打印
 
 @param locale 本地化
 @return 打印的字串
 */
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    return strM;
}
#endif
@end
