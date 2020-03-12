//
//  NSObject+JCS_Router.m
//  Classes
//
//  Created by 永平 on 2020/1/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSObject+JCS_Router.h"
#import <objc/runtime.h>

static char jcsParamsKey;

@implementation NSObject (JCS_Router)

- (void)setJcs_params:(NSDictionary*)jcs_params {
    objc_setAssociatedObject(self, &jcsParamsKey, jcs_params, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary*)jcs_params {
    return objc_getAssociatedObject(self, &jcsParamsKey);
}

@end
