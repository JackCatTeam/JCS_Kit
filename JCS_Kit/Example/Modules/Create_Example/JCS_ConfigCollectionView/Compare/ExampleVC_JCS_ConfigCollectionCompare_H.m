//
//  ExampleVC_JCS_ConfigCollectionCompare_H.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_JCS_ConfigCollectionCompare_H.h"
#import "JCS_Create.h"

@interface ExampleVC_JCS_ConfigCollectionCompare_H ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewSectionModel*> *sections;

@end

@implementation ExampleVC_JCS_ConfigCollectionCompare_H


- (void)jcs_setup {
    
     self.view.jcs_whiteBackgroundColor();
        
    
    
    [UICollectionView jcs_createWithFlowLayout:^(UICollectionViewFlowLayout * _Nonnull layout) {
        layout.jcs_scrollDirectionHorizontal();
    }].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(120);
        make.height.mas_equalTo(300);
    }).jcs_toCollectionView()
    .jcs_registerCellClasses(@[
       @"DemoCollectionViewCell"
    ])
    .jcs_registerSectionHeaderClass(@"DemoCollectionSectionHeaderView")
    .jcs_registerSectionFooterClass(@"DemoCollectionSectionFooterView")
    .jcs_customerSections(self.sections)
    .jcs_backgroundColor(UIColor.redColor)
    .jcs_associated(&_collectionView);
    
    
    
    [UICollectionView jcs_createWithWaterFallLayout:^(JCS_CollectionViewWaterFallLayout * _Nonnull layout) {
        layout.jcs_scrollDirectionHorizontal();
    }].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.collectionView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(300);
    }).jcs_toCollectionView()
    .jcs_registerCellClasses(@[
       @"DemoCollectionViewCell"
    ])
    .jcs_registerSectionHeaderClass(@"DemoCollectionSectionHeaderView")
    .jcs_registerSectionFooterClass(@"DemoCollectionSectionFooterView")
    .jcs_customerSections(self.sections)
    .jcs_backgroundColor(UIColor.redColor);
    
}


- (NSMutableArray<JCS_CollectionViewSectionModel *> *)sections {
    if(!_sections){
        _sections = [NSMutableArray array];
        
        CGFloat height = 300;
        
        JCS_CollectionViewSectionModel *section = nil;
        JCS_CollectionViewItemModel *item = nil;
        {
            section = [JCS_CollectionViewSectionModel jcs_create];
            section.headerClass = @"DemoCollectionSectionHeaderView";
            section.footerClass = @"DemoCollectionSectionFooterView";
            section.headerSize = CGSizeMake(50, height);
            section.footerSize = CGSizeMake(60, height);
            section.headerData = @{@"title":@"header - 1"};
            section.footerData = @{@"title":@"footer - 1"};
            section.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
//            section.minimumLineSpacing = 20;
//            section.minimumInteritemSpacing = 30;
//            section.decorationClass = @"DemoCollectionDecorationVIew";
//            section.decorationMarginInset = UIEdgeInsetsMake(10, 10, 10, 10);
//            section.decorationZIndex = 100;
//            section.decorationData = @{@"decoration":@"decoration data"};
            
            section.columnCount = 4;
            [_sections addObject:section];
        
            for (NSInteger index = 0; index < 9; index++) {
                item = [JCS_CollectionViewItemModel jcs_create];
                item.cellClass = @"DemoCollectionViewCell";
                item.cellSize = CGSizeMake(60, 60);
                item.data = @{@"title":[NSString stringWithFormat:@"%d-%zd",1,index]};
                [section.items addObject:item];
            }
        }
        
    }
    return _sections;
}


@end
