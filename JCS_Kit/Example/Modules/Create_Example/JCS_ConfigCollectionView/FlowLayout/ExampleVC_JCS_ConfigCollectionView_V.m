//
//  ExampleVC_JCS_ConfigCollectionView_V.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_JCS_ConfigCollectionView_V.h"
#import "JCS_Create.h"
#import "DemoCollectionViewCell.h"
#import "GoodsModel.h"
#import "JCS_EventBus.h"

@interface ExampleVC_JCS_ConfigCollectionView_V ()<JCS_CollectionViewProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
/** <#备注#> **/
@property (nonatomic, strong) JCS_CollectionViewSectionModel *section;

@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewSectionModel*> *sections;
/** <#备注#> **/
@property (nonatomic, strong) JCS_EventBus *eventBus;

@end

@implementation ExampleVC_JCS_ConfigCollectionView_V

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.jcs_backgroundColor(UIColor.grayColor);
    
    [UICollectionView jcs_createWithFlowLayout:^(UICollectionViewFlowLayout * _Nonnull layout) {
        layout.minimumLineSpacing = CGFLOAT_MIN;
        layout.minimumInteritemSpacing = CGFLOAT_MIN;
//        layout.itemSize = CGSizeMake(120, 120);
    }].jcs_layout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
    }).jcs_toCollectionView()
    .jcs_eventBus(self.eventBus)
    .jcs_defaultCellClassName(@"DemoCollectionViewCell")
    .jcs_customerSections(self.sections)
    .jcs_defaultItemClickRouter(@"jcs://PersonRouter/say:?name=张三") //默认点击路由
    .jcs_associated(&_collectionView);
    
    [self.eventBus registerAction:@"CellClick" executeBlock:^(id  _Nonnull params) {
        NSLog(@" params = %@",params);
    }];
}

 
- (NSMutableArray<JCS_CollectionViewSectionModel *> *)sections {
    if(!_sections){
        _sections = [NSMutableArray array];
        
        [_sections addObject:self.section];
        
        JCS_CollectionViewSectionModel *section = nil;
        JCS_CollectionViewItemModel *item = nil;

        for (NSInteger index = 0; index < 2; index++) {
            section = [JCS_CollectionViewSectionModel jcs_create];
//            section.headerClass = @"DemoCollectionSectionHeaderView";
//            section.footerClass = @"DemoCollectionSectionFooterView";
//            section.headerSize = CGSizeMake(JCS_SCREEN_WIDTH, 20);
//            section.footerSize = CGSizeMake(JCS_SCREEN_WIDTH, 100);
//            section.minimumLineSpacing = 30;
//            section.minimumInteritemSpacing = 20;
//            section.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//            section.headerData = @{@"title":@"header"};
//            section.footerData = @{@"title":@"footer"};
//            section.decorationClass = @"DemoCollectionDecorationVIew";
//            section.decorationMarginInset = UIEdgeInsetsMake(10, 10, 10, 10);
//            section.decorationZIndex = -1;
//            section.decorationData = @{@"decoration":@"decoration data"};

            [_sections addObject:section];

            for (NSInteger index = 0; index < 10; index++) {
                item = [JCS_CollectionViewItemModel jcs_create];
                item.cellSize = CGSizeMake(80, 80);
                item.data = @{@"title":@(index)};
                if(index == 0){
                    item.clickRouter = @"ylt://PersonRouter/say2:?name=李四";
                }
                [section.items addObject:item];
            }
        }
    }
    return _sections;
}

JCS_LAZY(JCS_CollectionViewSectionModel, section)
JCS_LAZY(JCS_EventBus, eventBus)

- (void)dealloc {
    NSLog(@"---ExampleVC_JCS_ConfigCollectionView_V -- dealloc");
}

@end
