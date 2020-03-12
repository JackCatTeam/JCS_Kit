//
//  JCS_CollectionViewFlowLayout.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewFlowLayout.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"

#import "JCS_CollectionViewModel.h"
#import "UICollectionViewLayoutAttributes+JCS_DecorationView.h"
#import "JCS_CollectionViewCustomerLayoutSectionMaxFrameItem.h"
#import "JCS_Create_Common.h"

@interface JCS_CollectionViewFlowLayout()
/** 装饰视图数组 **/
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> *decorationLayoutArray;
@end

@implementation JCS_CollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    if(!(self.jcs_layoutDelegate && [self.jcs_layoutDelegate respondsToSelector:@selector(jcs_FlowLayout:sectionWithIndexPath:)])){
        return;
    }
    
    //清空装饰视图
    [self.decorationLayoutArray removeAllObjects];
    
    for (NSInteger section = 0; section < self.collectionView.numberOfSections; section++) {
        
        JCS_CollectionViewCustomerLayoutSectionMaxFrameItem *maxFrameItem = [[JCS_CollectionViewCustomerLayoutSectionMaxFrameItem alloc] init];

        UICollectionViewLayoutAttributes *layoutAttributes = nil;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        
        //Header or Footer是否参数了计算
        BOOL headerOrFooterCaluated = NO;

        //Section Header LayoutAttributes
        layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if(layoutAttributes.frame.size.width > 0 && layoutAttributes.frame.size.height > 0){
            [maxFrameItem configWithAttributesIfNeed:layoutAttributes];
            headerOrFooterCaluated = YES;
        }
        
        //Section Items LayoutAttributes
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        for( NSInteger item = 0; item < itemCount; item++ ){
            layoutAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:item inSection:section]];
            if(layoutAttributes.frame.size.width > 0 && layoutAttributes.frame.size.height > 0){
                [maxFrameItem configWithAttributesIfNeed:layoutAttributes];
            }
        }
       
        
        //Section Footer LayoutAttributes
        layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        if(layoutAttributes.frame.size.width > 0 && layoutAttributes.frame.size.height > 0){
            [maxFrameItem configWithAttributesIfNeed:layoutAttributes];
            headerOrFooterCaluated = YES;
        }
        
        //DecorationView
        id<JCS_CollectionViewSectionProtocol> sectionModel = [self.jcs_layoutDelegate jcs_FlowLayout:self sectionWithIndexPath:section];

        if([sectionModel respondsToSelector:@selector(jcs_getDecorationClass)] && sectionModel.jcs_getDecorationClass.jcs_isValid){
            Class clazz = NSClassFromString(sectionModel.jcs_getDecorationClass);
            NSAssert(clazz != nil, @"DecorationView class %@ 未识别 ",sectionModel.jcs_getDecorationClass);
            if(clazz){

                //计算Decoration frame
                CGFloat x = maxFrameItem.left;
                CGFloat y = maxFrameItem.top;
                CGFloat width = maxFrameItem.right - maxFrameItem.left;
                CGFloat height = maxFrameItem.bottom - maxFrameItem.top;
                //Section Header or Footer参与了计算，则不处理下面代码
                if(headerOrFooterCaluated == NO && self.collectionView.delegate){
                    id<UICollectionViewDelegateFlowLayout> flowDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
                    if(flowDelegate){
                        UIEdgeInsets inserts = [flowDelegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
                        x -= inserts.left;
                        y -= inserts.top;
                        width = width + inserts.left + inserts.right;
                        height = height + inserts.top + inserts.bottom;
                    }
                }

                UIEdgeInsets marginInset = UIEdgeInsetsZero;
                if([sectionModel respondsToSelector:@selector(jcs_getDecorationMarginInset)]){
                    marginInset = sectionModel.jcs_getDecorationMarginInset;
                }
                
                
                x += marginInset.left;
                y += marginInset.top;
                width = width - marginInset.left - marginInset.right;
                height = height - marginInset.top - marginInset.bottom;
                
                [self registerClass:clazz forDecorationViewOfKind:sectionModel.jcs_getDecorationClass];
                layoutAttributes = [self layoutAttributesForDecorationViewOfKind:sectionModel.jcs_getDecorationClass atIndexPath:indexPath];
                layoutAttributes.frame = CGRectMake(x, y, width, height);
                
                if([sectionModel respondsToSelector:@selector(jcs_getDecorationData)]){
                    layoutAttributes.jcs_data = sectionModel.jcs_getDecorationData;
                }
                
                //zIndex 默认 -1
                layoutAttributes.zIndex = kUICollectionViewDefaulDecorationZIndex;
                if([sectionModel respondsToSelector:@selector(jcs_getDecorationZIndex)]  && sectionModel.jcs_getDecorationZIndex > 0){
                    layoutAttributes.zIndex = sectionModel.jcs_getDecorationZIndex;
                }
                
                [self.decorationLayoutArray addObject:layoutAttributes];
            }
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layouts = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    for (UICollectionViewLayoutAttributes *decorationLayout in self.decorationLayoutArray) {
        if(CGRectContainsRect(rect, decorationLayout.frame)) {
            [layouts addObject:decorationLayout];
        }
    }
    return layouts;
}

JCS_LAZY(NSMutableArray, decorationLayoutArray)

@end
