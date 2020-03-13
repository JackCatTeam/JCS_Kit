//
//  ExampleTableSectionFooterView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleTableSectionFooterView.h"
#import "JCS_Create.h"

#import "ExampleListItem.h"

@interface ExampleTableSectionFooterView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ExampleTableSectionFooterView


- (void)jcs_setupUI {
    [UILabel jcs_create].jcs_layout(self, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }).jcs_toLabel()
    .jcs_textAlignment_Center()
    .jcs_associated(&_titleLabel);
}

- (void)setJcs_data:(id)jcs_data {
    [super setJcs_data:jcs_data];
    //TODO: 使用jcs_data进行显示赋值
    
    if(!jcs_data){
        return;
    }
    if([jcs_data isKindOfClass:NSDictionary.class]){
        self.titleLabel.text = [NSString stringWithFormat:@"%@",[jcs_data valueForKey:@"title"]];
    } else if([jcs_data isKindOfClass:NSString.class]){
        self.titleLabel.text = jcs_data;
    } else if([jcs_data isKindOfClass:ExampleListItem.class]){
           self.titleLabel.text = ((ExampleListItem*)jcs_data).title;
       }
}

@end
