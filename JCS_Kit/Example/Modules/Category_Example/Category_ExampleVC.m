//
//  Category_ExampleVC.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Category_ExampleVC.h"
#import "JCS_Kit.h"

@interface Category_ExampleVC ()

@end

@implementation Category_ExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = JCS_COLOR_HEX_String(@"FF0000");
    self.view.jcs_whiteBackgroundColor();
    
    [UIView jcs_createAndLayout:self constraintBlock:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
//        make.width.height.mas_equalTo(100);
//        make.height.jcs_width_e(100);
//        make.height.jcs_width_e(10);
//        make.jcs_width_e(100);
//        make.jcs_height_e(100);
        make.width.jcs_height_e(200);
//        make.left
//        make.top
//        make.right
//        make.bottom
//        make.center
//        make.centerX
//        make.centerY
//        make.edges
    }].jcs_backgroundColor(UIColor.redColor);
}


@end
