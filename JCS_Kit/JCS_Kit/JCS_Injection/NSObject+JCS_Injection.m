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
        [NSObject jcs_swizzleInstanceMethod:@selector(mj_setKeyValues:context:) withMethod:@selector(jcs_mj_setKeyValues:context:)];
        [NSObject jcs_swizzleClassMethod:@selector(mj_objectArrayWithKeyValuesArray:context:) withMethod:@selector(jcs_mj_objectArrayWithKeyValuesArray:context:)];
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

/**
 核心代码：
 */
- (instancetype)jcs_mj_setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context {
    // 获得JSON对象
    keyValues = [keyValues mj_JSONObject];
    
//    MJExtensionAssertError([keyValues isKindOfClass:[NSDictionary class]], self, [self class], @"keyValues参数不是一个字典");
    
    id target = self;
    Class clazz = [self class];
    //r
    if([keyValues isKindOfClass:NSDictionary.class]){
        Class __class = [keyValues jcs_getModelClass];
        if(__class){
            //类型切换
            clazz = __class;
            target = [[__class alloc] init];
        }
    }
    
    NSArray *allowedPropertyNames = [clazz mj_totalAllowedPropertyNames];
    NSArray *ignoredPropertyNames = [clazz mj_totalIgnoredPropertyNames];
    
    NSLocale *numberLocale = nil;
    if ([clazz respondsToSelector:@selector(mj_numberLocale)]) {
        numberLocale = clazz.mj_numberLocale;
    }
    
    //通过封装的方法回调一个通过运行时编写的，用于返回属性列表的方法。
    [clazz mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        @try {
            // 0.检测是否被忽略
            if (allowedPropertyNames.count && ![allowedPropertyNames containsObject:property.name]) return;
            if ([ignoredPropertyNames containsObject:property.name]) return;
            
            // 1.取出属性值
            id value;
            NSArray *propertyKeyses = [property propertyKeysForClass:clazz];
            for (NSArray *propertyKeys in propertyKeyses) {
                value = keyValues;
                for (MJPropertyKey *propertyKey in propertyKeys) {
                    value = [propertyKey valueInObject:value];
                }
                if (value) break;
            }
            
            // 值的过滤
            id newValue = [clazz mj_getNewValueFromObject:target oldValue:value property:property];
            if (newValue != value) { // 有过滤后的新值
                [property setValue:newValue forObject:target];
                return;
            }
            
            // 如果没有值，就直接返回
            if (!value || value == [NSNull null]) return;
            
            // 2.复杂处理
            MJPropertyType *type = property.type;
            Class propertyClass = type.typeClass;
            Class objectClass = [property objectClassInArrayForClass:clazz];
            
            // 不可变 -> 可变处理
            if (propertyClass == [NSMutableArray class] && [value isKindOfClass:[NSArray class]]) {
                value = [NSMutableArray arrayWithArray:value];
            } else if (propertyClass == [NSMutableDictionary class] && [value isKindOfClass:[NSDictionary class]]) {
                value = [NSMutableDictionary dictionaryWithDictionary:value];
            } else if (propertyClass == [NSMutableString class] && [value isKindOfClass:[NSString class]]) {
                value = [NSMutableString stringWithString:value];
            } else if (propertyClass == [NSMutableData class] && [value isKindOfClass:[NSData class]]) {
                value = [NSMutableData dataWithData:value];
            }
            
            if(!propertyClass && [value isKindOfClass:NSDictionary.class]){ //id类型
                Class __class = [value jcs_getModelClass];
                if(__class){
                    propertyClass = __class;
                }
            }
            
            if (!type.isFromFoundation && propertyClass) { // 模型属性
                value = [propertyClass mj_objectWithKeyValues:value context:context];
            } else if (objectClass) {
                if (objectClass == [NSURL class] && [value isKindOfClass:[NSArray class]]) {
                    // string array -> url array
                    NSMutableArray *urlArray = [NSMutableArray array];
                    for (NSString *string in value) {
                        if (![string isKindOfClass:[NSString class]]) continue;
                        [urlArray addObject:string.mj_url];
                    }
                    value = urlArray;
                } else { // 字典数组-->模型数组
                    
                    value = [objectClass mj_objectArrayWithKeyValuesArray:value context:context];
                }
            } else if (propertyClass == [NSArray class] && [value isKindOfClass:[NSArray class]]) { //根据__class获取类型 devjackcat添加
                NSArray *arrayValue = value;
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *subValue in arrayValue) {
                    if([subValue isKindOfClass:NSDictionary.class]){
                        Class __class = [subValue jcs_getModelClass];
                        if(__class){
                            [array addObject:[__class mj_objectWithKeyValues:subValue]];
                            continue;
                        }
                    }
                    [array addObject:subValue];
                }
                
                value = array;
                
            } else if (propertyClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    // NSNumber -> NSString
                    value = [value description];
                } else if ([value isKindOfClass:[NSURL class]]) {
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            } else if ([value isKindOfClass:[NSString class]]) {
                if (propertyClass == [NSURL class]) {
                    // NSString -> NSURL
                    // 字符串转码
                    value = [value mj_url];
                } else if (type.isNumberType) {
                    NSString *oldValue = value;
                    
                    // NSString -> NSDecimalNumber, 使用 DecimalNumber 来转换数字, 避免丢失精度以及溢出
                    NSDecimalNumber *decimalValue = [NSDecimalNumber decimalNumberWithString:oldValue
                                                                                      locale:numberLocale];
                    
                    // 检查特殊情况
                    if (decimalValue == NSDecimalNumber.notANumber) {
                        value = @(0);
                    }else if (propertyClass != [NSDecimalNumber class]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
                        [decimalValue performSelector:NSSelectorFromString(@"standardValueWithTypeCode:") withObject:type.code];
#pragma clang diagnostic pop
//                        value = [decimalValue standardValueWithTypeCode:type.code];
                    } else {
                        value = decimalValue;
                    }
                    
                    // 如果是BOOL
                    if (type.isBoolType) {
                        // 字符串转BOOL（字符串没有charValue方法）
                        // 系统会调用字符串的charValue转为BOOL类型
                        NSString *lower = [oldValue lowercaseString];
                        if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"]) {
                            value = @YES;
                        } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
                            value = @NO;
                        }
                    }
                }
            } else if ([value isKindOfClass:[NSNumber class]] && propertyClass == [NSDecimalNumber class]){
                // 过滤 NSDecimalNumber类型
                if (![value isKindOfClass:[NSDecimalNumber class]]) {
                    value = [NSDecimalNumber decimalNumberWithDecimal:[((NSNumber *)value) decimalValue]];
                }
            }
            
            // 经过转换后, 最终检查 value 与 property 是否匹配
            if (propertyClass && ![value isKindOfClass:propertyClass]) {
                value = nil;
            }
            
            // 3.赋值
            [property setValue:value forObject:target];
        } @catch (NSException *exception) {
            MJExtensionLog(@"%@", exception);
        }
    }];
    
    // 转换完毕
    if ([target respondsToSelector:@selector(mj_didConvertToObjectWithKeyValues:)]) {
        [target mj_didConvertToObjectWithKeyValues:keyValues];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if ([target respondsToSelector:@selector(mj_keyValuesDidFinishConvertingToObject)]) {
        [target mj_keyValuesDidFinishConvertingToObject];
    }
    if ([target respondsToSelector:@selector(mj_keyValuesDidFinishConvertingToObject:)]) {
        [target mj_keyValuesDidFinishConvertingToObject:keyValues];
    }
#pragma clang diagnostic pop
    return target;
}

+ (NSMutableArray *)jcs_mj_objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context {
    // 如果是JSON字符串
    keyValuesArray = [keyValuesArray mj_JSONObject];
    
    // 1.判断真实性
//    MJExtensionAssertError([keyValuesArray isKindOfClass:[NSArray class]], nil, [self class], @"keyValuesArray参数不是一个数组");
    
    // 如果数组里面放的是NSString、NSNumber等数据
//    if ([MJFoundation isClassFromFoundation:self]) return [NSMutableArray arrayWithArray:keyValuesArray];
    

    // 2.创建数组
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 3.遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        if ([keyValues isKindOfClass:[NSArray class]]){
            [modelArray addObject:[self mj_objectArrayWithKeyValuesArray:keyValues context:context]];
        } else if ([keyValues isKindOfClass:[NSDictionary class]]){
            Class __class = [keyValues jcs_getModelClass];
            id model = nil;
            if(__class){
                //识别__class
                model = [__class mj_objectWithKeyValues:keyValues context:context];
            } else {
                //MJ 原来功能
                model = [self mj_objectWithKeyValues:keyValues context:context];
            }
            if (model) [modelArray addObject:model];
        } else {
            [modelArray addObject:keyValues];
        }
    }
    
    return modelArray;
}

#pragma mark - getter and setter

- (void)setJcs_configInfo:(NSDictionary * _Nonnull)jcs_configInfo {
    objc_setAssociatedObject(self, &jcsInjectConfigKey, jcs_configInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSDictionary *)jcs_configInfo {
    return objc_getAssociatedObject(self, &jcsInjectConfigKey);
}

@end
