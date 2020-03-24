//
//  Person.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/24.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Person.h"
#import "JCS_Kit.h"

@interface Person()

/** 姓名 **/
@property (nonatomic, copy) NSString *name;
/** 年龄 **/
@property (nonatomic, assign) NSInteger age;
/** 爱好 **/
@property (nonatomic, strong) NSArray<NSString*> *likes;
/** 其他信息 **/
@property (nonatomic, strong) NSDictionary *profile;
/** <#备注#> **/
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceType;

@end

@implementation Person

/// 开启注入功能
- (BOOL)jcs_propertyInjectEnable {
    return YES;
}

- (NSString *)jcs_propertyConfigFileName {
    return @"customer-config-file.json";
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.name = @"张三";
//        self.age = 28;
//        self.likes = @[@"篮球",@"跑步",@"打架"];
//        self.profile = @{
//            @"blog":@"https://blogs.uvdog.com",
//            @"company":@"从不上班"
//        };
//    }
//    return self;
//}

- (void)say {
    NSLog(@"");
}

@end
