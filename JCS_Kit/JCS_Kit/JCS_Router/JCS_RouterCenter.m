//
//  JCS_RouterCenter.m
//  AFNetworking
//
//  Created by 永平 on 2020/1/26.
//

#import "JCS_RouterCenter.h"
#import "JCS_Category.h"
#import "JCS_BaseLib.h"
#import "JCS_RouterDefine.h"

#import "JCS_RouterCenter+YLT.h"

#import "NSObject+JCS_Router.h"

@implementation JCS_RouterCenter

+ (id)router2Url:(NSString * _Nonnull )url args:(NSDictionary * _Nullable)args completion:(void(^ _Nullable)(NSError * _Nullable error, id  _Nullable response))completion {
    
    //电话拨打、发送短信
    if([url hasPrefix:@"tel://"] || [url hasPrefix:@"telprompt://"]
       || [url hasPrefix:@"sms://"]){
        NSURL *urlObj = [NSURL URLWithString:url];
        if (@available(iOS 10.0, *)) {
            //设备系统为iOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:urlObj options:@{} completionHandler:nil];
        } else {
            //设备系统为iOS 10.0以下的
            [[UIApplication sharedApplication] openURL:urlObj];
        }
        return nil;
    }
    
    if([url hasPrefix:@"ylt://"]){
        return [self ylt_router2Url:url args:args completion:completion];
    }
    
    NSAssert1(url.jcs_isValid, @"路由错误: url %@ 为空 ", url);
    NSAssert1([url hasPrefix:JCS_ROUTER_PREFIX], @"路由错误: url %@ 协议不支持 ", url);
    if(!(url.jcs_isValid && [url hasPrefix:JCS_ROUTER_PREFIX])) return nil;
    
    if(args){
        NSAssert([args isKindOfClass:NSDictionary.class], @"路由错误: args 必须为 NSDictionary ");
        if(![args isKindOfClass:NSDictionary.class]){
            return nil;
        }
    }

    //解析URL
    NSDictionary *routerDict = [self analysisURL:url];
    //拼接外部参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[routerDict valueForKey:JCS_ROUTER_ARG_DATA]];
    if(args && [args isKindOfClass:NSDictionary.class]){
        [params addEntriesFromDictionary:args];
    }
    
    return [self router2ClassName:[routerDict valueForKey:JCS_ROUTER_CLS_NAME]
                          selName:[routerDict valueForKey:JCS_ROUTER_SEL_NAME]
                             args:params
                       completion:completion];
}

+ (id)router2ClassName:(NSString * _Nonnull)className selName:(NSString * _Nonnull)selName args:(NSDictionary* _Nullable)args completion:( void(^ _Nullable )(NSError * _Nullable error, id _Nullable response))completion {
    
    //Class判空
    NSAssert1(className.jcs_isValid, @"路由错误: className %@ 为空 ", className);
    if(className.jcs_isBlank) return nil;
    
    //Class
    Class clazz = NSClassFromString(className);
    NSAssert1(clazz != nil, @"路由错误: className %@ 无效", className);
    if(clazz == nil) return nil;
    NSObject *routerObj = [[clazz alloc] init];
    
    if(args){
        NSAssert([args isKindOfClass:NSDictionary.class], @"路由错误: args 必须为 NSDictionary ");
        if(![args isKindOfClass:NSDictionary.class]){
            return nil;
        }
    }
    
    //将completion组装到参数中
    NSMutableDictionary *routerParams = [NSMutableDictionary dictionaryWithDictionary:args];
    routerParams[JCS_ROUTER_COMPLETION] = [completion copy];
    
    //SEL,默认为@selector(setJcs_params:)
    SEL selector = @selector(setJcs_params:);
    if(selName.jcs_isValid){
        selector = NSSelectorFromString(selName);
    }
    
    //优先执行instance方法
    BOOL instanceCanRespond = [routerObj respondsToSelector:selector];
    if(instanceCanRespond){
        return [self performSelector:selector target:routerObj params:routerParams];
    }
    
    //其次执行class方法
    BOOL classCanRespond = [clazz respondsToSelector:selector];
    if(classCanRespond){
        return [self performSelector:selector target:clazz params:routerParams];
    }
    
    NSAssert2((instanceCanRespond == YES || classCanRespond == YES), @"路由错误: %@ 无法响应方法 %@ ", className,selName);
    
    return nil;
}

///执行路由方法
+ (id)performSelector:(SEL)action target:(id)target params:(NSDictionary*)params {
    
    //如果target 为UIViewController，则直接push
    if([target isKindOfClass:UIViewController.class]){
        if([params.allKeys containsObject:@"title"]){
            ((UIViewController*)target).title = [params valueForKey:@"title"];
        }
        [[NSObject new].jcs_currentVC jcs_pushVC:target animated:YES];
    }
    
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:action];
    if(methodSignature == nil) {
        return nil;
    }
    const char* retType = [methodSignature methodReturnType];
    NSUInteger count =  [methodSignature numberOfArguments];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    if (count >= 3) {
        //>2 才表示有参数
        [invocation setArgument:&params atIndex:2];
    }
    [invocation setSelector:action];
    [invocation setTarget:target];
    if (strcmp(retType, @encode(void)) == 0) {
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
        
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
    #pragma clang diagnostic pop
    return nil;
}

///解析URL参数
+ (NSDictionary *)analysisURL:(NSString *)routerURL {
    //显示错误
    void(^showError)(void) = ^{
        JCS_LogError(@"url不合法 : %@", routerURL);
    };
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  JCS_ROUTER_PREFIX:@"",
                                                                                  JCS_ROUTER_SEL_NAME:@"",
                                                                                  JCS_ROUTER_ARG_DATA:@{}
                                                                                  }];
    
    //不以“jcs://”未前缀，或者字符串就是“jcs://”，则不合法
    if (routerURL.jcs_isBlank || ![routerURL hasPrefix:JCS_ROUTER_PREFIX] || [routerURL isEqualToString:JCS_ROUTER_PREFIX]) {
        showError();
        return result;
    }
    
    NSString *tempString = nil;
    NSScanner *scanner = [NSScanner scannerWithString:routerURL];
    [scanner setScanLocation:JCS_ROUTER_PREFIX.length]; //设置从ylt://后面开始扫描
    //解析路径部分
    {
        //扫描出path部分(jcs://.....?)
        [scanner scanUpToString:@"?" intoString:&tempString];
        NSArray *comps = [tempString componentsSeparatedByString:@"/"];
        
        //JCS_ROUTER_CLS_NAME
        if (comps.count > 0) {
            NSString *cls = comps[0];
            if(!(cls.jcs_isValid && NSClassFromString(cls))){ //验证cls是否合法
                showError();
                return result;
            }
            [result setObject:cls forKey:JCS_ROUTER_CLS_NAME];
//            #pragma clang diagnostic push
//            #pragma clang diagnostic ignored"-Wundeclared-selector"
////            #pragma clang diagnostic ignored"-Wunused-variable"
//            if ([NSClassFromString(cls) respondsToSelector:@selector(jcs_create)]) {
//                [result setObject:@"jcs_create" forKey:JCS_ROUTER_SEL_NAME];
//            }
//            #pragma clang diagnostic pop
        }
        
        //JCS_ROUTER_SEL_NAME
        if (comps.count > 1) {
            NSString *sel = comps[1];
            if(sel.jcs_isBlank){ //验证sel是否合法
                showError();
                return result;
            }
            [result setObject:sel forKey:JCS_ROUTER_SEL_NAME];
        }
    }
    
    //解析参数部分
    {
        //扫描出参数部分(这里填'??',因为参数部分不可能有‘??’,所以会将剩余部分全部放入tempString)
        //这里就是两个问号，不是手误
        tempString = nil;
        [scanner scanUpToString:@"??" intoString:&tempString];
        if (tempString.jcs_isValid) {
            //如果开头是？，则删除?
            if ([tempString hasPrefix:@"?"]) {
                tempString = [tempString substringFromIndex:1];
            }
            [result setObject:[self generateParamsString:tempString] forKey:JCS_ROUTER_ARG_DATA];
        }
    }
    
    return result;
}

+ (NSDictionary *)generateParamsString:(NSString *)paramString {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *components = [paramString componentsSeparatedByString:@"&"];
    for (NSString *tmpStr in components) {
        if (tmpStr.jcs_isBlank) {
            continue;
        }
        NSArray *tmpArray = [tmpStr componentsSeparatedByString:@"="];
        if (tmpArray.count == 2) {
            [params setObject:tmpArray[1] forKey:tmpArray[0]];
        } else {
            JCS_LogError(@"参数不合法 : %@",tmpStr);
        }
    }
    return params;
}

@end
