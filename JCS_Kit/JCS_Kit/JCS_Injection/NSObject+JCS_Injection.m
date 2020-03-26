//
//  NSObject+JCS_Injection.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/20.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSObject+JCS_Injection.h"
#import <objc/runtime.h>
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import <MJExtension/MJExtension.h>
#import "NSString+JCS_Injection.h"

#import "NSDictionary+JCS_Injection.h"
#import <MJExtension/MJExtensionConst.h>

#define JCS_CONFIG_DATA_KEY @"data"

const char jcsInjectConfigKey;

@implementation NSObject (JCS_Injection)

@dynamic jcs_configInfo;

#pragma mark - 方法交换

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject jcs_swizzleInstanceMethod:@selector(init) withMethod:@selector(jcs_injection_NSObject_init)];
        
        //MJExtension Hook
        [NSObject jcs_swizzleInstanceMethod:@selector(mj_setKeyValues:) withMethod:@selector(jcs_mj_setKeyValues:)];
    });
}

- (instancetype)jcs_injection_NSObject_init {
    [self jcs_injection_NSObject_init];
    
    //UIViewController则不处理，
    if(![self isKindOfClass:UIViewController.class]){
        if([self respondsToSelector:@selector(jcs_propertyInjectEnable)]){
            BOOL inject = [self jcs_propertyInjectEnable];
            if(inject){
                [self jcs_injectProperties];
            }
        }
    }
    
    return self;
}

#pragma mark - 外部可重写

/// 是否开启注入功能
- (BOOL)jcs_propertyInjectEnable {
    return NO;
}
/// 注入是的配置文件名
- (NSString*)jcs_propertyConfigFileName {
    return [NSString stringWithFormat:@"%@.geojson",NSStringFromClass(self.class)];
}

#pragma mark - 公共方法

///使用默认配置进行注入
- (void)jcs_injectProperties {
    [self jcs_injectPropertiesWithConfigFile:[self jcs_propertyConfigFileName]];
}

/// 使用字典进行注入，字典内直接是属性内容，无需放在data属性中， 格式如下
/// {
///     "username":"",
///     "profile":""
/// }
- (void)jcs_injectPropertiesWithPureDictionary:(NSDictionary*)dictionary {
    //对data先注入（这里是常量和变量的注入）
    NSDictionary *dataConfig = [NSDictionary jcs_injectParams:dictionary data:self];
    //开始赋值
    [self mj_setKeyValues:dataConfig];
    
}

/// 使用字典进行注入, 需要注入的属性需要放在data属性下， 格式如下
/// {
///     "data":{
///         ...
///         ...
///     }
/// }
- (void)jcs_injectPropertiesWithDictionary:(NSDictionary*)dictionary {
    if(!dictionary){
        JCS_LogError(@"%@ 注入失败 dictionary 为空",NSStringFromClass(self.class));
        return;
    }
    if(![dictionary isKindOfClass:NSDictionary.class]){
        JCS_LogError(@"%@ 注入失败 dictionary = %@ 不是字典类型",NSStringFromClass(self.class),dictionary);
        return;
    }
    
    //优先注入data属性
    //在全量对其他属性进行注入
    
    //DATA配置
    NSDictionary *dataConfig = [dictionary valueForKey:JCS_CONFIG_DATA_KEY];
    if(!(dataConfig && [dataConfig isKindOfClass:NSDictionary.class])){
        //如果没有data，则直接全量注入（这里是常量和变量的注入）
        self.jcs_configInfo = [NSDictionary jcs_injectParams:dictionary data:self];
        return;
    }
    
    //对数据进行注入
    [self jcs_injectPropertiesWithPureDictionary:dataConfig];
    
    //再对除data之外的进行注入
    NSMutableDictionary *configInfo = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [configInfo removeObjectForKey:JCS_CONFIG_DATA_KEY];
    configInfo = [NSDictionary jcs_injectParams:configInfo data:self];
    configInfo[JCS_CONFIG_DATA_KEY] = dataConfig;
    self.jcs_configInfo = configInfo;
}

/// 使用JSON字符串进行注入，json内直接是属性内容，无需放在data属性中， 格式如下
/// {
///     "username":"",
///     "profile":""
/// }
- (void)jcs_injectPropertiesWithPureJSONString:(NSString*)jsonString {
    if(!jsonString.jcs_isValid){
        JCS_LogError(@"%@ 注入失败 jsonString 为空",NSStringFromClass(self.class));
        return;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingFragmentsAllowed) error:&error];
    if(error){
        JCS_LogError(@"%@ 注入失败 jsonString 不是合法的JSON",NSStringFromClass(self.class));
        return;
    }
    [self jcs_injectPropertiesWithPureDictionary:jsonDict];
}

/// 使用JSON字符串进行注入, 需要注入的属性需要放在data属性下， 格式如下
/// {
///     "data":{
///         ...
///         ...
///     }
/// }
- (void)jcs_injectPropertiesWithJSONString:(NSString*)jsonString {
    if(!jsonString.jcs_isValid){
        JCS_LogError(@"%@ 注入失败 jsonString 为空",NSStringFromClass(self.class));
        return;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingFragmentsAllowed) error:&error];
    if(error){
        JCS_LogError(@"%@ 注入失败 jsonString 不是合法的JSON",NSStringFromClass(self.class));
        return;
    }
    [self jcs_injectPropertiesWithDictionary:jsonDict];
}

/// 使用配置文件进行注入
- (void)jcs_injectPropertiesWithConfigFile:(NSString*)configFileName {
    NSString *className = NSStringFromClass(self.class);
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:configFileName ofType:nil];
    if(!jsonPath.jcs_isValid){
        JCS_LogError(@"%@ 注入失败 filename = %@ 无效",className,configFileName);
        return;
    }
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];

    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingFragmentsAllowed) error:&error];
    if(!error){
        [self jcs_injectPropertiesWithDictionary:jsonDict];
    } else {
        JCS_LogError(@"%@ 注入失败 filename = %@ 文件内容不是合法的json",className,configFileName);
    }
}

#pragma mark - hook MJExtension

- (instancetype)jcs_mj_setKeyValues:(id)keyValues
{
    if ([keyValues isKindOfClass:NSDictionary.class]) {
        Class __class = [keyValues jcs_getModelClass];
        if(__class){
            NSMutableDictionary *muKeyValues = [NSMutableDictionary dictionaryWithDictionary:keyValues];
            //移除__class、class占位符
            NSString *className = [muKeyValues valueForKey:@"__class"];
            if(className.jcs_isValid && NSClassFromString(className) == __class){
                [muKeyValues removeObjectForKey:@"__class"];
            }
            className = [muKeyValues valueForKey:@"class"];
            if(className.jcs_isValid && NSClassFromString(className) == __class){
                [muKeyValues removeObjectForKey:@"class"];
            }
            //类型切换
            return [__class mj_objectWithKeyValues:muKeyValues];
        }
    }
    
    //MJ 原有方法
    return [self jcs_mj_setKeyValues:keyValues];
}

#pragma mark - getter and setter

- (void)setJcs_configInfo:(NSDictionary * _Nonnull)jcs_configInfo {
    objc_setAssociatedObject(self, &jcsInjectConfigKey, jcs_configInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSDictionary *)jcs_configInfo {
    return objc_getAssociatedObject(self, &jcsInjectConfigKey);
}

@end
