//
//  JCS_CollectionViewSectionEmptyView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewSectionEmptyView.h"
#import "JCS_Create.h"

@interface JCS_CollectionViewSectionHeaderEmptyView()
/** 标题 **/
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JCS_CollectionViewSectionHeaderEmptyView

/// 设置UI
- (void)jcs_setupUI {
    self.clipsToBounds = YES;
    self.backgroundColor = JCS_COLOR_HEX(0xdddddd);
    [UILabel jcs_create].jcs_layout(self, ^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self);
    }).jcs_toLabel()
    .jcs_fontSize(14)
    .jcs_text(@"未设置footerClass")
    .jcs_textColorHex(0x222222)
    .jcs_associated(&_titleLabel);
}

- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    self.titleLabel.text = [jcs_data valueForKey:@"title"];
}

@end



@interface JCS_CollectionViewSectionFooterEmptyView()
/** 标题 **/
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JCS_CollectionViewSectionFooterEmptyView

- (void)jcs_setupUI {
    self.clipsToBounds = YES;
    self.backgroundColor = JCS_COLOR_HEX(0xdddddd);
    [UILabel jcs_create].jcs_layout(self, ^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self);
    }).jcs_toLabel()
    .jcs_fontSize(14)
    .jcs_text(@"未设置headerClass")
    .jcs_textColorHex(0x222222)
    .jcs_associated(&_titleLabel);
}


- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    self.titleLabel.text = [jcs_data valueForKey:@"title"];
}

@end
