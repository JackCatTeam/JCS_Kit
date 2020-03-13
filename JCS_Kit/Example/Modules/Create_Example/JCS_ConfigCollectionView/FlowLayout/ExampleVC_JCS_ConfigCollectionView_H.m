//
//  ExampleVC_JCS_ConfigCollectionView_H.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_JCS_ConfigCollectionView_H.h"
#import "JCS_Create.h"
#import "DemoCollectionViewCell.h"

@interface ExampleVC_JCS_ConfigCollectionView_H ()<JCS_CollectionViewProtocol>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewSectionModel*> *sections;

@end

@interface ExampleVC_JCS_ConfigCollectionView_H ()

@end

@implementation ExampleVC_JCS_ConfigCollectionView_H

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.jcs_whiteBackgroundColor();
    
    [UICollectionViewFlowLayout jcs_create]
    .jcs_minimumLineSpacing(10)
    .jcs_minimumInteritemSpacing(10)
    .jcs_itemSize(CGSizeMake(100, 100))
    .jcs_scrollDirectionHorizontal()
    .jcs_associated(&_layout);
    
    [UICollectionView jcs_createWithLayout:self.layout].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(300);
        make.centerY.equalTo(self.view);
    }).jcs_toCollectionView()
    .jcs_registerCellClasses(@[
        @"DemoCollectionViewCell"
    ])
    .jcs_registerSectionHeaderClass(@"DemoCollectionSectionHeaderView")
    .jcs_registerSectionFooterClass(@"DemoCollectionSectionFooterView")
    .jcs_customerSections(self.sections)
    .jcs_associated(&_collectionView);
}
 
- (NSMutableArray<JCS_CollectionViewSectionModel *> *)sections {
    if(!_sections){
        _sections = [NSMutableArray array];
        
        JCS_CollectionViewSectionModel *section = nil;
        JCS_CollectionViewItemModel *item = nil;
        
        for (NSInteger index = 0; index < 10; index++) {
            section = [JCS_CollectionViewSectionModel jcs_create];
//            section.headerClass = @"DemoCollectionSectionHeaderView";
//            section.footerClass = @"DemoCollectionSectionFooterView";
//            section.headerSize = CGSizeMake(30, 300);
//            section.footerSize = CGSizeMake(50, 300);
//            section.minimumLineSpacing = 30;
//            section.minimumInteritemSpacing = 30;
//            section.sectionInset = UIEdgeInsetsMake(50, 0, 50, 0);
//            section.headerData = @{@"title":@"header"};
//            section.footerData = @{@"title":@"footer"};
            [_sections addObject:section];
            
            for (NSInteger index = 0; index < 10; index++) {
                item = [JCS_CollectionViewItemModel jcs_create];
                item.cellClass = @"DemoCollectionViewCell";
                item.cellSize = CGSizeMake(80, 80);
                item.data = @{@"title":@(index)};
                [section.items addObject:item];
            }
        }
    }
    return _sections;
}

@end
