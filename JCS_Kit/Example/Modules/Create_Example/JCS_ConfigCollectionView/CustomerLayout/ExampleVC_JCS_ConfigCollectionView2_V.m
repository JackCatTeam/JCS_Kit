//
//  ExampleVC_JCS_ConfigCollectionView2.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/11.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_JCS_ConfigCollectionView2_V.h"
#import "JCS_Create.h"

@interface ExampleVC_JCS_ConfigCollectionView2_V ()<JCS_CollectionViewProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewSectionModel*> *sections;

@end

@implementation ExampleVC_JCS_ConfigCollectionView2_V

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.jcs_whiteBackgroundColor();
    
    [UICollectionView jcs_createWithWaterFallLayout:^(JCS_CollectionViewWaterFallLayout * _Nonnull layout) {

    }].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(340);
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(-100);
    }).jcs_toCollectionView()
//    .jcs_registerClasses(@[
//       @"DemoCollectionViewCell"
//    ])
//    .jcs_registerSectionHeaderClass(@"DemoCollectionSectionHeaderView")
//    .jcs_registerSectionFooterClass(@"DemoCollectionSectionFooterView")
    .jcs_customerSections(self.sections)
    .jcs_customerDelegate(self)
//    .jcs_contentInset(UIEdgeInsetsMake(20, 20, 20, 20))
    .jcs_backgroundColor(UIColor.blueColor)
    .jcs_associated(&_collectionView);
    
}

- (NSMutableArray<JCS_CollectionViewSectionModel *> *)sections {
    if(!_sections){
        _sections = [NSMutableArray array];
        
        CGFloat width = 340;
        
        JCS_CollectionViewSectionModel *section = nil;
        JCS_CollectionViewItemModel *item = nil;
        
        for (NSInteger index = 0; index < 20; index++) {
            
            {
                section = [JCS_CollectionViewSectionModel jcs_create];
                section.headerClass = @"DemoCollectionSectionHeaderView";
                section.footerClass = @"DemoCollectionSectionFooterView";
                section.headerSize = CGSizeMake(width, 50);
                section.footerSize = CGSizeMake(width, 100);
                section.headerMarginInsets = UIEdgeInsetsMake(10, 10, 10, 0);
                section.footerMarginInsets = UIEdgeInsetsMake(10, 10, 10, 0);
                section.headerData = @{@"title":@"header - 1"};
                section.footerData = @{@"title":@"footer - 1"};
//                section.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
                
//                section.sectionInset = UIEdgeInsetsMake(10, 10, 10, 0);
                section.minimumLineSpacing = CGFLOAT_MIN;
                section.minimumInteritemSpacing = CGFLOAT_MIN;
//                section.decorationClass = @"DemoCollectionDecorationVIew";
//                section.decorationMarginInset = UIEdgeInsetsMake(10, 10, 10, 10);
//                section.decorationZIndex = 100;
//                section.decorationData = @{@"decoration":@"decoration data"};
                
                section.columnCount = 4;
                [_sections addObject:section];
            
                for (NSInteger jndex = 0; jndex < 10; jndex++) {
                    item = [JCS_CollectionViewItemModel jcs_create];
                    item.cellClass = @"DemoCollectionViewCell";
                    item.cellSize = CGSizeMake(JCS_SCREEN_WIDTH/4.0, 100);
                    item.data = @{@"title":[NSString stringWithFormat:@"%zd-%zd",index,jndex]};
                    [section.items addObject:item];
                }
            }
            
         }
        
    }
    return _sections;
}


@end
