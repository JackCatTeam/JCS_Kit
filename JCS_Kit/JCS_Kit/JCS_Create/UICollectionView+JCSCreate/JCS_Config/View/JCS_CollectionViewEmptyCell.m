//
//  JCS_CollectionViewEmptyCell.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewEmptyCell.h"
#import "JCS_Create.h"

@interface JCS_CollectionViewEmptyCell()
/** 标题 **/
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JCS_CollectionViewEmptyCell

/// 设置UI
- (void)jcs_setupUI {
    self.contentView.backgroundColor = JCS_COLOR_HEX(0xdddddd);
    [UILabel jcs_create].jcs_layout(self.contentView, ^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self.contentView);
    }).jcs_toLabel()
    .jcs_fontSize(14)
    .jcs_textColorHex(0x222222)
    .jcs_associated(&_titleLabel);
}

///绑定信号
- (void)jcs_bindingSignal {}

- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    self.titleLabel.text = [jcs_data valueForKey:@"title"];
}

@end

