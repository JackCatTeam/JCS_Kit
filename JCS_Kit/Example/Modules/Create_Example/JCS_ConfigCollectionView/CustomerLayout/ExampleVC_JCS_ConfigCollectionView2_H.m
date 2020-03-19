//
//  ExampleVC_JCS_ConfigCollectionView2_H.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/12.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_JCS_ConfigCollectionView2_H.h"
#import "JCS_Create.h"

@interface ExampleVC_JCS_ConfigCollectionView2_H ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewSectionModel*> *sections;

@end

@implementation ExampleVC_JCS_ConfigCollectionView2_H

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.jcs_whiteBackgroundColor();
    
    [UICollectionView jcs_createWithWaterFallLayout:^(JCS_CollectionViewWaterFallLayout *layout) {
        layout.jcs_scrollDirectionHorizontal();
    }].jcs_layout(self.view, ^(MASConstraintMaker *make) {
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
    .jcs_hideBothScrollIndicator()
    .jcs_backgroundColor(UIColor.redColor)
    .jcs_associated(&_collectionView);
    
}

- (NSMutableArray<JCS_CollectionViewSectionModel *> *)sections {
    if(!_sections){
        _sections = [NSMutableArray array];
        
        JCS_CollectionViewSectionModel *section = nil;
        JCS_CollectionViewItemModel *item = nil;
        for(NSInteger index=0;index < 5; index++)
        {
            section = [JCS_CollectionViewSectionModel jcs_create];
            section.headerClass = @"DemoCollectionSectionHeaderView";
            section.footerClass = @"DemoCollectionSectionFooterView";
            section.headerSize = CGSizeMake(50, 300);
            section.footerSize = CGSizeMake(50, 300);
            section.headerMarginInsets = UIEdgeInsetsMake(10, 10, 0, 10);
            section.footerMarginInsets = UIEdgeInsetsMake(10, 10, 0, 10);
            section.headerData = @{@"title":@"header - 1"};
            section.footerData = @{@"title":@"footer - 1"};
//            section.sectionInset = UIEdgeInsetsMake(10, 10, 10, 0);
            section.minimumLineSpacing = CGFLOAT_MIN;
            section.minimumInteritemSpacing = CGFLOAT_MIN;
            
//            section.decorationClass = @"DemoCollectionDecorationVIew";
//            section.decorationMarginInset = UIEdgeInsetsMake(10, 10, 10, 10);
//            section.decorationZIndex = 100;
//            section.decorationData = @{@"decoration":@"decoration data"};
            
            section.columnCount = 3;
            [_sections addObject:section];
        
            for (NSInteger index = 0; index < 9; index++) {
                item = [JCS_CollectionViewItemModel jcs_create];
                item.cellClass = @"DemoCollectionViewCell";
                item.cellSize = CGSizeMake(100,100);
                item.data = @{@"title":[NSString stringWithFormat:@"%d-%zd",1,index]};
                [section.items addObject:item];
            }
        }
    }
    return _sections;
}

@end
