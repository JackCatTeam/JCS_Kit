//
//  Injection_ExampleVC.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Injection_ExampleVC.h"
#import "JCS_Kit.h"
#import "Person.h"
#import "HKGTOrderModel.h"
#import <MJExtension/MJExtension.h>

@interface Injection_ExampleVC ()

@end

@implementation Injection_ExampleVC

- (void)jcs_setup {
    self.view.jcs_whiteBackgroundColor();
//    [[[Person alloc] init] say];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testjson.geojson" ofType:nil];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dict = json.mj_JSONObject;
    HKGTOrderModel *model = [HKGTOrderModel mj_objectWithKeyValues:dict];
    
    NSLog(@"");
//    NSDictionary *data = [];
}

@end
