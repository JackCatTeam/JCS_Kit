//
//  UICollectionViewFlowLayout+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UICollectionViewFlowLayout+JCSCreate.h"

@implementation UICollectionViewFlowLayout (JCSCreate)

- (UICollectionViewFlowLayout *(^)(CGSize))jcs_itemSize{
    return ^id(CGSize value) {
        self.itemSize = value;
        return self;
    };
}

- (UICollectionViewFlowLayout *(^)(CGFloat))jcs_minimumLineSpacing{
    return ^id(CGFloat value) {
        self.minimumLineSpacing = value;
        return self;
    };
}

- (UICollectionViewFlowLayout *(^)(CGFloat))jcs_minimumInteritemSpacing{
    return ^id(CGFloat value) {
        self.minimumInteritemSpacing = value;
        return self;
    };
}

- (UICollectionViewFlowLayout *(^)(CGSize))jcs_headerReferenceSize{
    return ^id(CGSize value) {
        self.headerReferenceSize = value;
        return self;
    };
}
- (UICollectionViewFlowLayout *(^)(CGSize))jcs_footerReferenceSize{
    return ^id(CGSize value) {
        self.footerReferenceSize = value;
        return self;
    };
}

- (UICollectionViewFlowLayout *(^)(void))jcs_scrollDirectionVertical{
    return ^id{
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        return self;
    };
}
- (UICollectionViewFlowLayout *(^)(void))jcs_scrollDirectionHorizontal{
    return ^id{
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return self;
    };
}

- (UICollectionViewFlowLayout *(^)(UIEdgeInsets inset))jcs_sectionInset{
    return ^id(UIEdgeInsets inset){
        self.sectionInset = inset;
        return self;
    };
}

//- (UICollectionViewFlowLayout *(^)(id<UICollectionViewDelegateFlowLayout> delegate))jcs_delegate{
//    return ^id(id<UICollectionViewDelegateFlowLayout> delegate){
//        self.scrollDirection = UICollectionViewScrollDirectionVertical;
//        return self;
//    };
//}

@end
