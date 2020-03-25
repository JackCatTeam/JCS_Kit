//
//  DemoCollectionViewCell.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "DemoCollectionViewCell.h"
#import "JCS_Create.h"

#import "ExampleService.h"
#import "GoodsModel.h"

@interface DemoCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation DemoCollectionViewCell


- (void)jcs_setupUI {
//    self.jcs_backgroundColor(JCS_COLOR_HEX(0xdddddd));
    self.jcs_randomBackgroundColor();
    
    [UILabel jcs_create].jcs_layout(self.contentView, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
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

- (void)setJcs_checked:(BOOL)jcs_checked {
    [super setJcs_checked:jcs_checked];
    if(jcs_checked){
        self.titleLabel.jcs_fontSize(25);
        self.titleLabel.text = self.titleLabel.text;
    } else {
        self.titleLabel.jcs_fontSize(17);
    }
    if(self.titleLabel.text.jcs_isValid){
        JCS_EventBus *eventBus = self.jcs_eventBus;
        [eventBus postEvent:@"CellClick" params:@{@"title":self.titleLabel.text}];
    }
}

- (void)dealloc {
    NSLog(@"---DemoCollectionViewCell -- dealloc");
}

@end
