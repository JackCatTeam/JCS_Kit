//
//  UICollectionView+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UICollectionView+JCSCreate.h"
#import "JCS_Category.h"

@implementation UICollectionView (JCSCreate)

- (void)registerDefaultClass {
    self.jcs_registerCellClass(@"JCS_CollectionViewEmptyCell");
    self.jcs_registerSectionHeaderClass(@"JCS_CollectionViewSectionHeaderEmptyView");
    self.jcs_registerSectionFooterClass(@"JCS_CollectionViewSectionFooterEmptyView");
}

+ (instancetype)jcs_createWithLayout:(UICollectionViewLayout *)layout{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = UIColor.whiteColor;
    [collectionView registerDefaultClass];
    return collectionView;
}

- (UICollectionView *(^)(NSString *className))jcs_registerCellClass{
    return ^id(NSString *className) {
        self.jcs_registerCellClassWithIdentifier(className, className);
        return self;
    };
}
- (UICollectionView *(^)(NSArray<NSString*> *classNames))jcs_registerCellClasses{
    return ^id(NSArray<NSString*> *classNames) {
        for (NSString *className in classNames) {
            self.jcs_registerCellClassWithIdentifier(className, className);
        }
        return self;
    };
}
- (UICollectionView *(^)(NSString *className,NSString *identifier))jcs_registerCellClassWithIdentifier{
    return ^id(NSString *className,NSString *identifier) {
        if(className.jcs_isValid){
            Class cellClass = NSClassFromString(className);
            NSAssert1(cellClass != NULL,@"JCS: UICollectionView CellClassName %@ 异常",className);
            [self registerClass:cellClass forCellWithReuseIdentifier:identifier];
        }
        return self;
    };
}

- (UICollectionView *(^)(NSString *className))jcs_registerSectionHeaderClass{
    return ^id(NSString *className) {
        self.jcs_registerSectionHeaderClassWithIdentifier(className, className);
        return self;
    };
}
- (UICollectionView *(^)(NSArray<NSString*> *classNames))jcs_registerSectionHeaderClasses{
    return ^id(NSArray<NSString*> *classNames) {
        for (NSString *className in classNames) {
            self.jcs_registerSectionHeaderClassWithIdentifier(className, className);
        }
        return self;
    };
}
- (UICollectionView *(^)(NSString *className,NSString *identifier))jcs_registerSectionHeaderClassWithIdentifier{
    return ^id(NSString *className,NSString *identifier) {
        if(className.jcs_isValid){
            Class cellClass = NSClassFromString(className);
            NSAssert1(cellClass != NULL,@"JCS: UICollectionView SectionHeaderClassName %@ 异常",className);
            [self registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        }
        return self;
    };
}

- (UICollectionView *(^)(NSString *className))jcs_registerSectionFooterClass{
    return ^id(NSString *className) {
        self.jcs_registerSectionFooterClassWithIdentifier(className, className);
        return self;
    };
}
- (UICollectionView *(^)(NSArray<NSString*> *classNames))jcs_registerSectionFooterClasses{
    return ^id(NSArray<NSString*> *classNames) {
        for (NSString *className in classNames) {
            self.jcs_registerSectionFooterClassWithIdentifier(className, className);
        }
        return self;
    };
}
- (UICollectionView *(^)(NSString *className,NSString *identifier))jcs_registerSectionFooterClassWithIdentifier{
    return ^id(NSString *className,NSString *identifier) {
        if(className.jcs_isValid){
            Class cellClass = NSClassFromString(className);
            NSAssert1(cellClass != NULL,@"JCS: UICollectionView SectionFooterClassName %@ 异常",className);
            [self registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
        }
        return self;
    };
}


- (UICollectionView *(^)(id<UICollectionViewDelegate>))jcs_delegate{
    return ^id(id<UICollectionViewDelegate> value) {
        self.delegate = value;
        return self;
    };
}
- (UICollectionView *(^)(id<UICollectionViewDataSource>))jcs_dataSource{
    return ^id(id<UICollectionViewDataSource> value) {
        self.dataSource = value;
        return self;
    };
}

- (UICollectionView *(^)(UICollectionViewLayout *layout,BOOL animated))jcs_customerLayout{
    return ^id(UICollectionViewLayout *layout,BOOL animated) {
        [self setCollectionViewLayout:layout animated:animated];
        return self;
    };
}

@end
