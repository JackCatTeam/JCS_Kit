//
//  Router_ExampleVC.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Router_ExampleVC.h"
#import "JCS_Kit.h"

@interface Router_ExampleVC ()

@end

@implementation Router_ExampleVC

- (void)jcs_setup {
    self.view.jcs_whiteBackgroundColor();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NSString *router = @"jcs://SecondVC?title=张三";
//    NSString *router = @"ylt://PersonRouter/say:?title=张三";
//    NSString *router = @"sms://10086&&body=123";
        NSString *router = @"telprompt://4008887381";
    
    id result = [JCS_RouterCenter router2Url:router args:@{@"c":@"3"} completion:^(NSError * _Nullable error, id  _Nullable response) {
        NSLog(@"completion = %@",response);
    }];
    
    NSLog(@"");
    
    /**
     1. 路由selName同时兼容instance方法和class方法，内部会自动识别
     2. 路由参数args只能为NSDictionary类型
     */
    
    //instance方法，参数非NSDictionary，错误
//    id returnValue = [JCS_RouterCenter router2ClassName:@"PersonRouter" selName:@"say:" args:@"张三" completion:nil];
    
    //instance方法，参数NSDictionary，正确
//    id returnValue = [JCS_RouterCenter router2ClassName:@"PersonRouter" selName:@"say:" args:@{@"name":@"张三"} completion:nil];
    
    //class方法，非参数NSDictionary，正确
//    id returnValue = [JCS_RouterCenter router2ClassName:@"PersonRouter" selName:@"classFunc:" args:@"张三" completion:nil];
    
    //class方法，参数NSDictionary，正确
//    id returnValue = [JCS_RouterCenter router2ClassName:@"PersonRouter" selName:@"classFunc:" args:@{@"name":@"张三"} completion:^(NSError * _Nullable error, id  _Nullable response) {
//        NSLog(@"completion response = %@",response);
//    }];
    
//    id returnValue = [JCS_RouterCenter router2Url:@"jcs://PersonRouter/say:" args:@{@"name":@"张三"} completion:nil];
        
//    NSLog(@"returnValue = %@",returnValue);
}


@end
