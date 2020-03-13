//
//  ExampleVC_InjectCollectionView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/22.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_InjectCollectionView.h"
#import "JCS_Kit.h"

@interface ExampleVC_InjectCollectionView ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewSectionModel*> *sections;

@property (nonatomic, copy) NSString *headerData1;
@property (nonatomic, strong) JCS_CollectionViewSectionModel *sectionModel;
@property (nonatomic, strong) JCS_CollectionViewItemModel *itemModel;

@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewItemModel*> *sectionItems1;
@property (nonatomic, strong) NSMutableArray<JCS_CollectionViewItemModel*> *sectionItems2;

@property (nonatomic, copy) NSString *type;
@end

@implementation ExampleVC_InjectCollectionView

- (BOOL)jcs_propertyInjectEnable {
    return YES;
}

- (NSString*)jcs_propertyConfigFileName {
    return @"ExampleVC_InjectCollectionView2.geojson";
}

- (void)jcs_setup {
    [super jcs_setup];
    
    self.headerData1 = @"ref headerData";
    self.view.jcs_backgroundColor(UIColor.grayColor);
    
    [UICollectionView jcs_createWithWaterFallLayout:nil].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
    }).jcs_toCollectionView()
    .jcs_customerSections(self.sections)
    .jcs_associated(&_collectionView);
    
    @weakify(self)
    
    [UIButton jcs_create].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(-JCS_HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo((JCS_SCREEN_WIDTH - 16 * 3)/2);
    }).jcs_toButton()
    .jcs_normalTitle(@"Add to One")
    .jcs_clickBlock(^(UIButton *sender) {
        @strongify(self)
        
        self.headerData1 = @"ref headerData update";
        
        JCS_CollectionViewItemModel *itemModel = [JCS_CollectionViewItemModel jcs_create];
        itemModel.cellClass = @"DemoCollectionViewCell";
        itemModel.cellSize = CGSizeMake(80, 80);
        itemModel.data = [NSString stringWithFormat:@"%d",arc4random_uniform(300)];
        [self.sectionItems1 addObject:itemModel];
        self.collectionView.jcs_customerSections(self.sections);
    })
    .jcs_normalTitleColor(UIColor.blackColor);
    
    [UIButton jcs_create].jcs_layout(self.view, ^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-JCS_HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo((JCS_SCREEN_WIDTH - 16 * 3)/2);
    }).jcs_toButton()
    .jcs_normalTitle(@"Add to Two")
    .jcs_clickBlock(^(UIButton *sender) {
        @strongify(self)
        JCS_CollectionViewItemModel *itemModel = [JCS_CollectionViewItemModel jcs_create];
        itemModel.cellClass = @"DemoCollectionViewCell";
        itemModel.cellSize = CGSizeMake(80, 80);
        itemModel.data = [NSString stringWithFormat:@"%d",arc4random_uniform(300)];
        [self.sectionItems2 addObject:itemModel];
        self.collectionView.jcs_customerSections(self.sections);
    })
    .jcs_normalTitleColor(UIColor.blackColor);
}

- (void)jcs_request {
    self.sections = [self jcs_generateCollectionViewSections];
    self.collectionView.jcs_customerSections(self.sections);
}

JCS_LAZY(NSMutableArray, sections)
JCS_LAZY(NSMutableArray, sectionItems1)
JCS_LAZY(NSMutableArray, sectionItems2)

- (JCS_CollectionViewSectionModel *)sectionModel {
    if(!_sectionModel){
        _sectionModel = [JCS_CollectionViewSectionModel jcs_create];
        _sectionModel.columnCount = 3;
        _sectionModel.headerClass = @"DemoCollectionSectionHeaderView";
        _sectionModel.footerClass = @"DemoCollectionSectionFooterView";
        _sectionModel.headerSize = CGSizeMake(JCS_SCREEN_WIDTH, 20);
        _sectionModel.footerSize = CGSizeMake(JCS_SCREEN_WIDTH, 100);
        for (NSInteger index = 0; index < 10; index++) {
            JCS_CollectionViewItemModel *item = [JCS_CollectionViewItemModel jcs_create];
            item.cellClass = @"DemoCollectionViewCell";
            item.cellSize = CGSizeMake(80, 80);
            item.data = @{@"title":@(index)};
            if(index == 0){
                item.clickRouter = @"ylt://PersonRouter/say2:?name=李四";
            }
            [_sectionModel.items addObject:item];
        }
    }
    return _sectionModel;
}

- (JCS_CollectionViewItemModel *)itemModel {
    if(!_itemModel){
        _itemModel = [JCS_CollectionViewItemModel jcs_create];
        _itemModel.cellClass = @"DemoCollectionViewCell";
        _itemModel.cellSize = CGSizeMake(80, 80);
        _itemModel.data = @{@"title":@"李五"};
        _itemModel.clickRouter = @"jcs://PersonRouter/say2:?name=李五";
    }
    return _itemModel;
}

@end
