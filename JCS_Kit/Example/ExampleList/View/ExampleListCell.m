//
//  ExampleListCell.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleListCell.h"
#import "ExampleListItem.h"
#import "JCS_Kit.h"

@interface ExampleListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation ExampleListCell

- (void)jcs_setupUI {
    //Title
    [UILabel jcs_create].jcs_layout(self.contentView, ^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(8);
    }).jcs_toLabel()
    .jcs_fontSize(14)
    .jcs_textColorHex(0x222222)
    .jcs_associated(&_titleLabel);
    
    //Sub Title
    [UILabel jcs_create].jcs_layout(self.contentView, ^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(6);
        make.bottom.mas_equalTo(-8);
    }).jcs_toLabel()
    .jcs_fontSize(12)
    .jcs_textColorHex(0x999999)
    .jcs_associated(&_subTitleLabel);
    
}

- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    ExampleListItem *item = jcs_data;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",item.title];
    self.subTitleLabel.text = item.jumpClass;
}

//- (void)setJcs_checked:(BOOL)jcs_checked {
//    [super setJcs_checked:jcs_checked];
//    if(jcs_checked){
//        self.titleLabel.jcs_fontSize(25);
//        self.titleLabel.text = self.titleLabel.text;
//    } else {
//        self.titleLabel.jcs_fontSize(17);
//    }
//}



@end
