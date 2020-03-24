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

@interface Injection_ExampleVC ()

@end

@implementation Injection_ExampleVC

- (void)jcs_setup {
    self.view.jcs_whiteBackgroundColor();
    [[[Person alloc] init] say];
}

@end
