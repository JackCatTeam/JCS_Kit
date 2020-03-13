//
//  ExampleTableViewCell.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleTableViewCell.h"
#import "JCS_Create.h"

#import "ExampleService.h"

@interface ExampleTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ExampleTableViewCell

- (void)jcs_setupUI {
    self.jcs_backgroundColor(UIColor.jcs_randomColor);
    [UILabel jcs_create].jcs_layout(self.contentView, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }).jcs_toLabel()
    .jcs_textAlignment_Center()
    .jcs_associated(&_titleLabel);
}

- (void)setJcs_data:(id)jcs_data {
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

- (void)setJcs_checked:(BOOL)jcs_checked {
    [super setJcs_checked:jcs_checked];
    NSLog(@"------jcs_checked %p %d",self,jcs_checked);
    if(jcs_checked){
        self.titleLabel.jcs_fontSize(25);
    } else {
        self.titleLabel.jcs_fontSize(17);
    }
}

@end
