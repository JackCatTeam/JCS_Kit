//
//  NSString+JCS_Injection.m
//  JCS_Injection
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSString+JCS_Injection.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"

@implementation NSString (JCS_Injection)

/// 根据data进行参数注入
+ (NSString*)jcs_injectParams:(NSString*)paramsString data:(id)data {
    if(!(data && [paramsString isKindOfClass:NSString.class])){
        return paramsString;
    }
    //常量替换
    NSString *originString = [self jcs_injectConstants:paramsString data:data];

    NSError *error = nil;
    //不包含站位符，直接返回
    if(!([originString containsString:@"${"] && [originString containsString:@"}"])){
        return originString;
    }
    NSString *pattern = @"\\$\\{[a-zA-Z0-9_.]*\\}";
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:(NSRegularExpressionCaseInsensitive) error:&error];
    //出现错误，原样返回
    if(error){
        return originString;
    }
    NSArray<NSTextCheckingResult *> *checkResults = [regularExpression matchesInString:originString options:(NSMatchingReportCompletion) range:NSMakeRange(0, originString.length)];
    //没有匹配到，原样返回
    if(!(checkResults && checkResults.count > 0)){
        return originString;
    }
    
    //存放temp 和 key 的键值对
    NSMutableDictionary *templatePairs = [NSMutableDictionary dictionary];
    for (NSTextCheckingResult *result in checkResults) {
        NSString *template = [originString substringWithRange:result.range];
        NSString *templateKey = [template substringWithRange:NSMakeRange(2, template.length - 3)];
        //重复模板，无需再次获取
        if([templatePairs.allKeys containsObject:template]){
            continue;
        }
        //将获取到的值，存入templatePairs
        @try {
            id templateValue = [data valueForKeyPath:templateKey];
            if(templateValue){
                if([templateValue isKindOfClass:NSURL.class]){ // NSURL -> NSString
                    templatePairs[template] = [((NSURL*)templateValue) absoluteString];
                    
                } else if([templateValue isKindOfClass:NSAttributedString.class]){ // NSAttributedString -> NSString
                    templatePairs[template] = [((NSAttributedString*)templateValue) string];
                    
                } else if([templateValue isKindOfClass:NSNumber.class]){ // NSNumber -> NSString
                    templatePairs[template] = [templateValue description];
                    
                } else {
                    templatePairs[template] = templateValue;
                }
                
            } else {
                //如没找到，则空字符串代替
                templatePairs[template] = @"";
            }
        } @catch (NSException *exception) {
            //如没找到，则空字符串代替
            templatePairs[template] = @"";
            JCS_LogError(@"%@",exception);
        } @finally {
            
        }
    }
    //对originString进行模板替换
    if(templatePairs.count > 0){
        for (NSString *key in templatePairs.allKeys) {
            originString = [originString stringByReplacingOccurrencesOfString:key withString:templatePairs[key]];
        }
    }
    
    return originString;
    
}
- (NSString*)jcs_injectParamsWithData:(id)data {
    return [[self class] jcs_injectParams:self data:data];
}

/// 根据data进行常量注入
+ (NSString*)jcs_injectConstants:(NSString*)constantsString data:(id)data {
    if(!(data && [constantsString containsString:@"$"])){
        return constantsString;
    }
    
    NSString *key = nil;
    
    //Screen Width
    key = @"$SCREEN_WIDTH";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",UIScreen.mainScreen.bounds.size.width]];
    }
    
    //Screen Height
    key = @"$SCREEN_HEIGHT";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",UIScreen.mainScreen.bounds.size.height]];
    }
    
    //Screen scale
    key = @"$SCREEN_SCALE";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",UIScreen.mainScreen.scale]];
    }
    
    //状态栏高度
    key = @"$STATUS_BAR_HEIGHT";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",JCS_STATUS_BAR_HEIGHT]];
    }
    
    //导航栏高度
    key = @"$NAVIGATION_BAR_HEIGHT";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",JCS_NAVIGATION_BAR_HEIGHT]];
    }
    
    //tabBar高度
    key = @"$TAB_BAR_HEIGHT";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",JCS_TAB_BAR_HEIGHT]];
    }
    
    //导航栏不带statusbar
    key = @"$NAVIGATION_BAR_WITHOUTSTATUS_HEIGHT";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2d",JCS_NAVIGATION_BAR_WITHOUTSTATUS_HEIGHT]];
    }
    
    //indicator hone按钮高度
    key = @"$HOME_INDICATOR_HEIGHT";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%0.2f",JCS_HOME_INDICATOR_HEIGHT]];
    }
    
    //iOS系统信息
    key = @"$iOS_VERSION";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_iOS_VERSION];
    }
    
    //app版本
    key = @"$APP_NAME";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_APP_NAME];
    }
    
    //app版本
    key = @"$APP_VERSION";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_APP_VERSION];
    }
    
    //app build版本
    key = @"$BUILD_VERSION";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_BUILD_VERSION];
    }
    
    //device Model
    key = @"$DEVICE_TYPE";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_DEVICE_TYPE];
    }
    
    //app bundle id
    key = @"$BUNDLE_ID";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_BUNDLE_ID];
    }
    
    //设备名称
    key = @"$DEVICE_NAME";
    if([constantsString containsString:key]){
        constantsString = [constantsString stringByReplacingOccurrencesOfString:key withString:JCS_DEVICE_NAME];
    }
    
    return constantsString;
    
}
- (NSString*)jcs_injectConstantsWithData:(id)data {
    return [[self class] jcs_injectConstants:self data:data];
}
@end
