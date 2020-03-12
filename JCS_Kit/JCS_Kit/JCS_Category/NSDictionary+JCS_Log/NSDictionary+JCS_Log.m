//
//  NSDictionary+JCS_Log.m
//  AFNetworking
//
//  Created by 永平 on 2020/1/20.
//

#import "NSDictionary+JCS_Log.h"

@implementation NSDictionary (JCS_Log)
#ifdef DEBUG
/**
 改写字典的日志打印
 
 @param locale 本地化
 @return 打印的字串
 */
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [strM appendString:@"}\n"];
    return strM;
}
#endif
@end
