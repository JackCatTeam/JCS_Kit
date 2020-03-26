//
//  NSObject+JCS_Injection.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/20.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JCS_Injection)

/** JSON配置文件 **/
@property (nonatomic, strong,readonly) NSDictionary *jcs_configInfo;

///是否开启属性动态注入, 默认NO
- (BOOL)jcs_propertyInjectEnable;
///注入配置文件名，默认 ${ClassName}.geojson
- (NSString*)jcs_propertyConfigFileName;

#pragma mark - 公共方法

///使用默认配置进行注入
- (void)jcs_injectProperties;
/// 使用字典进行注入，字典内直接是属性内容，无需放在data属性中， 格式如下
/// {
///     "username":"",
///     "profile":""
/// }
- (void)jcs_injectPropertiesWithPureDictionary:(NSDictionary*)dictionary;
/// 使用字典进行注入, 需要注入的属性需要放在data属性下， 格式如下
/// {
///     "data":{
///         ...
///         ...
///     }
/// }
- (void)jcs_injectPropertiesWithDictionary:(NSDictionary*)dictionary;
/// 使用JSON字符串进行注入，json内直接是属性内容，无需放在data属性中， 格式如下
/// {
///     "username":"",
///     "profile":""
/// }
- (void)jcs_injectPropertiesWithPureJSONString:(NSString*)jsonString;
/// 使用JSON字符串进行注入, 需要注入的属性需要放在data属性下， 格式如下
/// {
///     "data":{
///         ...
///         ...
///     }
/// }
- (void)jcs_injectPropertiesWithJSONString:(NSString*)jsonString;
/// 使用配置文件进行注入
- (void)jcs_injectPropertiesWithConfigFile:(NSString*)configFileName;

@end

NS_ASSUME_NONNULL_END
