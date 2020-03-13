//
//  ExampleSectionHeaderView.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleSectionHeaderView.h"
#import "JCS_Kit.h"

@interface ExampleSectionHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ExampleSectionHeaderView

- (void)jcs_setupUI {
    //Title
    [UILabel jcs_create].jcs_layout(self.contentView, ^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.equalTo(self.contentView);
    }).jcs_toLabel()
    .jcs_fontSize(14)
    .jcs_textColorHex(0x222222)
    .jcs_associated(&_titleLabel);
}

- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    if([jcs_data isKindOfClass:NSString.class]){
        self.titleLabel.text = jcs_data;
    } else if([jcs_data isKindOfClass:NSDictionary.class]){
        self.titleLabel.text = [jcs_data valueForKey:@"title"];
    }
}


@end
