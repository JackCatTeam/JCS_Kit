//
//  DemoCollectionSectionHeaderView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "DemoCollectionSectionHeaderView.h"
#import "JCS_Create.h"

#import "GoodsModel.h"

@interface DemoCollectionSectionHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation DemoCollectionSectionHeaderView


- (void)jcs_setupUI {
    self.jcs_backgroundColor(JCS_COLOR_HEX(0xdddddd));
    [UILabel jcs_create].jcs_layout(self, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }).jcs_toLabel()
    .jcs_textAlignment_Center()
    .jcs_associated(&_titleLabel);
}

- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    if(!jcs_data){
        return;
    }
    if([jcs_data isKindOfClass:NSDictionary.class]){
        self.titleLabel.text = [NSString stringWithFormat:@"%@",[jcs_data valueForKey:@"title"]];
    } else if([jcs_data isKindOfClass:NSString.class]){
        self.titleLabel.text = jcs_data;
    } else if([jcs_data isKindOfClass:GoodsModel.class]){
           self.titleLabel.text = ((GoodsModel*)jcs_data).title;
       }
}

@end
