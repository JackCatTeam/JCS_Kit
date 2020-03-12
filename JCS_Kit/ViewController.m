//
//  ViewController.m
//  JCS_Kit
//
//  Created by 永平 on 2020/2/6.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ViewController.h"
#import "JCS_Kit.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showExampleListVC:(id)sender {
    [JCS_RouterCenter router2Url:@"jcs://ExampleListVC" args:nil completion:nil];
}
@end
