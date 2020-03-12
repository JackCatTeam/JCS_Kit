//
//  JCS_RouterTool.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/10.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_RouterTool.h"
#import "JCS_Router.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"

@implementation JCS_RouterTool

+ (void)executeRouter:(NSString*)router data:(id)data {
    if(router.jcs_isValid) {
        NSDictionary *routerParams = nil;
        if(data){
            if(![data isKindOfClass:NSDictionary.class]){
                routerParams = @{@"JCS_DATA":data};
            } else {
                routerParams = data;
            }
        }
        [JCS_RouterCenter router2Url:router args:routerParams completion:nil];
    }
}

@end
