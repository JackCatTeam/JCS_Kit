//
//  JCS_Macros.h
//  StarCard
//
//  Created by 永平 on 2020/1/16.
//  Copyright © 2020 youye. All rights reserved.
//

#ifndef JCS_Macros_h
#define JCS_Macros_h

#pragma mark - 颜色

#define JCS_COLOR_RGB(R, G, B) JCS_COLOR_RGBA(R, G, B,1)
#define JCS_COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define JCS_COLOR_HEXA(__HEX__,__ALPHA__) [UIColor jcs_colorWithHex:__HEX__ alpha:__ALPHA__]
#define JCS_COLOR_HEX(__HEX__) JCS_COLOR_HEXA(__HEX__,1)
#define JCS_COLOR_HEXA_String(__HEX__,__ALPHA__) [UIColor jcs_colorWithHexString:__HEX__ alpha:__ALPHA__]
#define JCS_COLOR_HEX_String(__HEX__) JCS_COLOR_HEXA_String(__HEX__,1)


#pragma mark - 屏幕

#define JCS_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define JCS_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define JCS_SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define JCS_SCREEN_SCALE [UIScreen mainScreen].scale

#pragma mark - 状态栏

///状态栏颜色(黑色)
#define JCS_STATUS_BAR_DARK() - (UIStatusBarStyle)preferredStatusBarStyle { if (@available(iOS 13.0, *)) { return UIStatusBarStyleDarkContent; } else { return UIStatusBarStyleDefault; } }
///状态栏颜色(白色)
#define JCS_STATUS_BAR_LIGHT() - (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }

/// iOS设备信息
#define JCS_iPad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define JCS_iPhone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)

//屏幕信息
#define JCS_iPhone4 (([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==480) || ([UIScreen mainScreen].bounds.size.width==480&&[UIScreen mainScreen].bounds.size.height==320))
#define JCS_iPhone5 (([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==568) || ([UIScreen mainScreen].bounds.size.width==568&&[UIScreen mainScreen].bounds.size.height==320))
#define JCS_iPhone6 (([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==667) || ([UIScreen mainScreen].bounds.size.width==667&&[UIScreen mainScreen].bounds.size.height==375))
#define JCS_iPhone6P (([UIScreen mainScreen].bounds.size.width==414&&[UIScreen mainScreen].bounds.size.height==736) || ([UIScreen mainScreen].bounds.size.width==736&&[UIScreen mainScreen].bounds.size.height==414))
#define JCS_iPhoneX (([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==812) || ([UIScreen mainScreen].bounds.size.width==812&&[UIScreen mainScreen].bounds.size.height==375))
#define JCS_iPhoneXS iPhoneX
#define JCS_iPhoneXR (([UIScreen mainScreen].bounds.size.width==414&&[UIScreen mainScreen].bounds.size.height==896) || ([UIScreen mainScreen].bounds.size.width==896&&[UIScreen mainScreen].bounds.size.height==414))
#define JCS_iPhoneXSMAX iPhoneXR

#define JCS_iPhoneXLater (JCS_iPhoneX || JCS_iPhoneXR )

// 状态栏高度
#define JCS_STATUS_BAR_HEIGHT (JCS_iPhoneXLater ? 44.f : 20.f)
// 导航栏高度
#define JCS_NAVIGATION_BAR_HEIGHT (JCS_iPhoneXLater ? 88.f : 64.f)
// tabBar高度
#define JCS_TAB_BAR_HEIGHT (JCS_iPhoneXLater ? (49.f + 34.f) : 49.f)
// 导航栏不带statusbar
#define JCS_NAVIGATION_BAR_WITHOUTSTATUS_HEIGHT 44
// home indicator hone按钮高度
#define JCS_HOME_INDICATOR_HEIGHT (JCS_iPhoneXLater ? 34.f : 0.f)

// iOS系统信息
#define JCS_iOS_VERSION [[UIDevice currentDevice] systemVersion]

#define JCS_iOS7 ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 8.0)
#define JCS_iOS7Later ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0)

#define JCS_iOS8 ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 9.0)
#define JCS_iOS8Later ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)

#define JCS_iOS9 ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 10.0)
#define JCS_iOS9Later ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)

#define JCS_iOS10 ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 11.0)
#define JCS_iOS10Later ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0)

#define JCS_iOS11 ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 12.0)
#define JCS_iOS11Later ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0)

#define JCS_iOS12  ([[UIDevice currentDevice] systemVersion].floatValue >= 12.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 13.0)
#define JCS_iOS12Later  ([[UIDevice currentDevice] systemVersion].floatValue >= 12.0)

#define JCS_iOS13  ([[UIDevice currentDevice] systemVersion].floatValue >= 13.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 14.0)
#define JCS_iOS13Later  ([[UIDevice currentDevice] systemVersion].floatValue >= 13.0)

#define JCS_iOSNew ([[UIDevice currentDevice] systemVersion].floatValue >= 14.0)

#define JCS_IsDark (JCS_iOS12Later ? (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) : NO)

/// 获取系统对象
#define JCS_Application        [UIApplication sharedApplication]
#define JCS_AppWindow          [UIApplication sharedApplication].keyWindow
#define JCS_AppDelegate        [UIApplication sharedApplication].delegate
#define JCS_RootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define JCS_NotificationCenter [NSNotificationCenter defaultCenter]
#define JCS_FileManager        [NSFileManager defaultManager]

//获取图片资源
// NSString To NSURL
#define JCS_URL(urlString)    [NSURL URLWithString:urlString]
#define JCS_GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

// iOS沙盒目录
#define JCS_DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define JCS_CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//当前语言
#define JCS_CURRENT_LANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]
//info.plist 文件信息
#define JCS_INFO_DICTIONARY [[NSBundle mainBundle] infoDictionary]
//当前应用程序的 bundle ID

// app名称
#define JCS_APP_NAME [JCS_INFO_DICTIONARY objectForKey:@"CFBundleDisplayName"]
// app版本
#define JCS_APP_VERSION [JCS_INFO_DICTIONARY objectForKey:@"CFBundleShortVersionString"]
// app build版本
#define JCS_BUILD_VERSION [JCS_INFO_DICTIONARY objectForKey:@"CFBundleVersion"]
// device Model
#define JCS_DEVICE_TYPE  [[UIDevice currentDevice] model]
// app bundle id
#define JCS_BUNDLE_ID [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define JCS_DEVICE_NAME [[UIDevice currentDevice] name]
#define JCS_MAIN_BUNDLE [NSBundle mainBundle]

//快速生成单例对象
//#define YLT_ShareInstanceHeader(cls)    + (cls *)shareInstance;\
//                                        + (void)resetInstance;
//#define YLT_ShareInstance(cls)          static cls *share_cls = nil;\
//                                        static dispatch_once_t share_onceToken;\
//                                        static dispatch_once_t ylt_init_onceToken;\
//                                        + (cls *)shareInstance {\
//                                                share_cls = [[cls alloc] init];\
//                                                dispatch_once(&ylt_init_onceToken, ^{\
//                                                    if ([share_cls respondsToSelector:@selector(ylt_init)]) {\
//                                                        [share_cls performSelector:@selector(ylt_init) withObject:nil];\
//                                                    }\
//                                                });\
//                                                return share_cls;\
//                                            }\
//                                            + (instancetype)allocWithZone:(struct _NSZone *)zone {\
//                                                if (share_cls == nil) {\
//                                                    dispatch_once(&share_onceToken, ^{\
//                                                        share_cls = [super allocWithZone:zone];\
//                                                    });\
//                                                }\
//                                                return share_cls;\
//                                            }\
//                                            + (void)resetInstance {\
//                                                share_onceToken = 0;\
//                                                ylt_init_onceToken = 0;\
//                                                share_cls = nil;\
//                                            }\
//                                            YLT_THREAD_SAFE

//#define JCS_LazyCategory(cls, fun) - (cls *)fun {\
//                                        cls *result = objc_getAssociatedObject(self, @selector(fun));\
//                                        if (result == nil) {\
//                                            result = [[cls alloc] init];\
//                                            objc_setAssociatedObject(self, @selector(fun), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
//                                        }\
//                                        return result;\
//                                    }

#pragma mark - 线程切换

#define JCS_MAIN(block)  if ([NSThread isMainThread]) {\
                            block();\
                         } else {\
                            dispatch_async(dispatch_get_main_queue(),block);\
                         }
#define JCS_MAINDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define JCS_GLOBAL_(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define JCS_BACKDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#pragma mark - NSUserDefaults

#define JCS_UserDefaults [NSUserDefaults standardUserDefaults]

#define JCS_UserDefaults_SetUrl(__Value__,__Key__) [JCS_UserDefaults setURL:__Value__ forKey:__Key__]; [JCS_UserDefaults synchronize];
#define JCS_UserDefaults_SetInteger(__Value__,__Key__) [JCS_UserDefaults setInteger:__Value__ forKey:__Key__]; [JCS_UserDefaults synchronize];
#define JCS_UserDefaults_SetFloat(__Value__,__Key__) [JCS_UserDefaults setFloat:__Value__ forKey:__Key__]; [JCS_UserDefaults synchronize];
#define JCS_UserDefaults_SetDouble(__Value__,__Key__) [JCS_UserDefaults setDouble:__Value__ forKey:__Key__]; [JCS_UserDefaults synchronize];
#define JCS_UserDefaults_SetBool(__Value__,__Key__) [JCS_UserDefaults setBool:__Value__ forKey:__Key__]; [JCS_UserDefaults synchronize];
#define JCS_UserDefaults_SetObject(__Value__,__Key__) [JCS_UserDefaults setObject:__Value__ forKey:__Key__]; [JCS_UserDefaults synchronize];

#define JCS_UserDefaults_GetUrl(__Key__) [JCS_UserDefaults URLForKey:__Key__];
#define JCS_UserDefaults_GetInteger(__Key__) [JCS_UserDefaults integerForKey:__Key__];
#define JCS_UserDefaults_GetFloat(__Key__) [JCS_UserDefaults floatForKey:__Key__];
#define JCS_UserDefaults_GetDouble(__Key__) [JCS_UserDefaults doubleForKey:__Key__];
#define JCS_UserDefaults_GetBool(__Key__) [JCS_UserDefaults boolForKey:__Key__];
#define JCS_UserDefaults_GetObject(__Key__) [JCS_UserDefaults objectForKey:__Key__];

#pragma mark - 懒加载

#define JCS_LAZY(cls, sel) \
- (cls *)sel {\
    if (!_##sel) {\
        _##sel = [[cls alloc] init];\
    }\
    return _##sel;\
}

#define JCS_LAZY_SUBJECT(__NAME__) JCS_LAZY(RACSubject,__NAME__)

#pragma mark - 日志打印

// 表情符号地址
//https://bj.96weixin.com/tools/emoji

#define JCS_LogAll(type,format,...) NSLog(@"%@ %s %s+%d " format,type,__FILE__,__func__,__LINE__,##__VA_ARGS__)
#define JCS_LogDebug(format,...) JCS_LogAll(@"🐞🐞 ",format,##__VA_ARGS__)
#define JCS_LogInfo(format,...) JCS_LogAll(@"💬💬 ",format,##__VA_ARGS__)
#define JCS_LogWarning(format,...) JCS_LogAll(@"📡📡 ",format,##__VA_ARGS__)
#define JCS_LogError(format,...) JCS_LogAll(@"❌❌ ",format,##__VA_ARGS__)

#pragma mark - 消除警告

/// 警告消除宏
#define JCS_ArgumentToString(macro) #macro
#define JCS_ClangWarningConcat(warning_name) JCS_ArgumentToString(clang diagnostic ignored warning_name)
// 参数可直接传入 clang 的 warning 名，warning 列表参考：http://fuckingclangwarnings.com/
#define JCS_BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(JCS_ClangWarningConcat(#warningName))
#define JCS_EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define JCS_BeginIgnorePerformSelectorLeaksWarning JCS_BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define JCS_EndIgnorePerformSelectorLeaksWarning JCS_EndIgnoreClangWarning

#define JCS_BeginIgnoreAvailabilityWarning JCS_BeginIgnoreClangWarning(-Wpartial-availability)
#define JCS_EndIgnoreAvailabilityWarning JCS_EndIgnoreClangWarning

#define JCS_BeginIgnoreDeprecatedWarning JCS_BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define JCS_EndIgnoreDeprecatedWarning JCS_EndIgnoreClangWarning

#define JCS_BeginIgnoreUndeclaredSelecror JCS_BeginIgnoreClangWarning(-Wundeclared-selector)
#define JCS_EndIgnoreUndeclaredSelecror JCS_EndIgnoreClangWarning

#define JCS_BeginIgnoreUnusedVariable JCS_BeginIgnoreClangWarning(-Wunused-variable)
#define JCS_EndIgnoreUnusedVariable JCS_EndIgnoreClangWarning

#endif /* JCS_Macros_h */
