//
//  JCS_CollectionViewWaterFallLayout.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/11.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewWaterFallLayout.h"
#import "JCS_BaseLib.h"
#import "JCS_Category.h"
#import "JCS_CollectionViewModel.h"

#import "JCS_CollectionViewCustomerLayoutSectionMaxFrameItem.h"
#import "UICollectionViewLayoutAttributes+JCS_DecorationView.h"
#import "JCS_Create_Defines.h"

@interface JCS_CollectionViewWaterFallLayout()

/** 每个Section.Top距离UICollectionView.top的偏移量 **/
@property (nonatomic, strong) NSMutableArray *sectionItemMargins;

@end

@implementation JCS_CollectionViewWaterFallLayout

+ (instancetype)jcs_create{
    return [[self alloc]init];
}

#pragma mark - 配置

- (JCS_CollectionViewWaterFallLayout *(^)(id<JCS_CollectionViewWaterFallLayoutDelegate> delegate))jcs_customerDelegate{
    return ^id(id<JCS_CollectionViewWaterFallLayoutDelegate> delegate) {
        self.customerDelegate = delegate;
        return self;
    };
}

- (JCS_CollectionViewWaterFallLayout *(^)(void))jcs_scrollDirectionVertical{
    return ^id{
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        return self;
    };
}
- (JCS_CollectionViewWaterFallLayout *(^)(void))jcs_scrollDirectionHorizontal{
    return ^id{
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return self;
    };
}

#pragma mark - calculateSectionItemsMargin

//计算每个Section下Item的Margin
- (void)calculateSectionItemsMargin:(NSIndexPath*)indexPath {
    if(self.scrollDirection == UICollectionViewScrollDirectionVertical){
        [self vertical_calculateSectionItemsMargin:indexPath];
    } else {
        [self horizontal_calculateSectionItemsMargin:indexPath];
    }
}
//计算每个Section下Item的Margin
//计算思路如下
//1. 第一个Section,sectionItemMargin = SectionHeader.height + sectionModel.sectionInset.top
//2. 反之取self.layoutAttributes最后一个元素SectionFooter(一定是SectionFooter)，则取其作为基准
- (void)vertical_calculateSectionItemsMargin:(NSIndexPath*)indexPath {
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    //1. 第一个Section,sectionItemMargin = SectionHeader.height + sectionModel.sectionInset.top
    CGSize headerSize = kUICollectionViewDefaultHeaderSize;
    UIEdgeInsets sectionInset = kUICollectionViewDefaulSectionInset;
    if([sectionModel respondsToSelector:@selector(jcs_getHeaderSize)]){
        headerSize = sectionModel.jcs_getHeaderSize;
    }
    if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)]){
        sectionInset = sectionModel.jcs_getSectionInset;
    }
    
    if(indexPath.section == 0){
        self.sectionItemMargins[indexPath.section] = @(headerSize.height + sectionInset.top);
        return;
    }
    
    //2. 反之取self.layoutAttributes最后一个元素SectionFooter(一定是SectionFooter)，则取其作为基准
    UICollectionViewLayoutAttributes *lastLayout = self.layoutAttributes.lastObject;
    //上一个SectionFooter的最大 Y + 当前SectionHeader高度 + 当前Section上边距
    self.sectionItemMargins[indexPath.section] = @(CGRectGetMaxY(lastLayout.frame) + headerSize.height  + sectionInset.top);
    return;
    
}
//计算每个Section下Item的Margin
//计算思路如下
//1. 第一个Section,sectionItemMargin = SectionHeader.height + sectionModel.sectionInset.top
//2. 反之取self.layoutAttributes最后一个元素SectionFooter(一定是SectionFooter)，则取其作为基准
- (void)horizontal_calculateSectionItemsMargin:(NSIndexPath*)indexPath {
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    //1. 第一个Section,sectionItemMargin = SectionHeader.width + sectionModel.sectionInset.left
    CGSize headerSize = kUICollectionViewDefaultHeaderSize;
    UIEdgeInsets sectionInset = kUICollectionViewDefaulSectionInset;
    if([sectionModel respondsToSelector:@selector(jcs_getHeaderSize)]){
        headerSize = sectionModel.jcs_getHeaderSize;
    }
    if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)]){
        sectionInset = sectionModel.jcs_getSectionInset;
    }
    
    if(indexPath.section == 0){
        self.sectionItemMargins[indexPath.section] = @(headerSize.width + sectionInset.left);
        return;
    }
    
    //2. 反之取self.layoutAttributes最后一个元素SectionFooter(一定是SectionFooter)，则取其作为基准
    UICollectionViewLayoutAttributes *lastLayout = self.layoutAttributes.lastObject;
    //上一个SectionFooter的最大 Y + 当前SectionHeader高度 + 当前Section上边距
    self.sectionItemMargins[indexPath.section] = @(CGRectGetMaxX(lastLayout.frame) + headerSize.width  + sectionInset.left);
    return;
    
}

#pragma mark - calculateSectionHeaderLayoutAttribute

///计算SectionHeader layoutAttribute
- (void)calculateSectionHeaderLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    if(self.scrollDirection == UICollectionViewScrollDirectionVertical){
        [self vertical_calculateSectionHeaderLayoutAttribute:indexPath layoutAttribute:layoutAttribute];
    } else {
        [self horizontal_calculateSectionHeaderLayoutAttribute:indexPath layoutAttribute:layoutAttribute];
    }
}
///计算SectionHeader layoutAttribute
- (void)vertical_calculateSectionHeaderLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    
    UICollectionViewLayoutAttributes *preLayoutAttribute = nil;
    if(indexPath.section > 0){
        preLayoutAttribute = self.layoutAttributes.lastObject;
    }

    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize headerSize =  [layoutDelegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
    
    CGFloat itemWidth = headerSize.width;
    CGFloat itemHeight = itemHeight = headerSize.height;
    CGFloat cellX = 0;//sectionModel.sectionInset.left;
    CGFloat cellYInCollectioinView = preLayoutAttribute?CGRectGetMaxY(preLayoutAttribute.frame):0;
    
    //SectionHeader顶部和上一个SectionFooter之间没有缝隙，所以不用加间距
    layoutAttribute.frame = CGRectMake(cellX, cellYInCollectioinView, itemWidth, itemHeight);
    //记录内容的高度
    self.contentHeight = MAX(self.contentHeight,CGRectGetMaxY(layoutAttribute.frame));
}
///计算SectionHeader layoutAttribute
- (void)horizontal_calculateSectionHeaderLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    
    UICollectionViewLayoutAttributes *preLayoutAttribute = nil;
    if(indexPath.section > 0){
        preLayoutAttribute = self.layoutAttributes.lastObject;
    }
    
    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize headerSize =  [layoutDelegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];

    CGFloat itemWidth = headerSize.width;
    CGFloat itemHeight = headerSize.height;

    CGFloat cellXInCollectioinView = preLayoutAttribute?CGRectGetMaxX(preLayoutAttribute.frame):0;
    CGFloat cellY = 0;//sectionModel.sectionInset.top;
    
    //SectionHeader顶部和上一个SectionFooter之间没有缝隙，所以不用加间距
    layoutAttribute.frame = CGRectMake(cellXInCollectioinView, cellY, itemWidth, itemHeight);
    //记录内容的宽度
    self.contentWidth = MAX(self.contentWidth,CGRectGetMaxX(layoutAttribute.frame));
}

#pragma mark - calculateSectionFooterLayoutAttribute

///计算SectionFooter layoutAttribute
- (void)calculateSectionFooterLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    if(self.scrollDirection == UICollectionViewScrollDirectionVertical){
        [self vertical_calculateSectionFooterLayoutAttribute:indexPath layoutAttribute:layoutAttribute];
    } else {
        [self horizontal_calculateSectionFooterLayoutAttribute:indexPath layoutAttribute:layoutAttribute];
    }
}
///计算SectionFooter layoutAttribute
- (void)vertical_calculateSectionFooterLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {

    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];

    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize footerSize = [layoutDelegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
    
    CGFloat itemWidth = footerSize.width;
    CGFloat itemHeight = footerSize.height;
    
    NSInteger columnCount = kUICollectionViewDefaulColumnCount;
    if([sectionModel respondsToSelector:@selector(jcs_columnCount)] && sectionModel.jcs_columnCount > 0){
        columnCount = sectionModel.jcs_columnCount;
    }
    
    UIEdgeInsets sectionInset = kUICollectionViewDefaulSectionInset;
    if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)]){
        sectionInset = sectionModel.jcs_getSectionInset;
    }
    
    //找出最大的columnHeight
    CGFloat maxColumnHeight = 0;
    NSMutableArray *columnMaxHeightArray = self.sectionColumnMaxLengthArray[indexPath.section];
    if(columnMaxHeightArray.count > 0){
        //默认该Section第一个item最大
        maxColumnHeight = [columnMaxHeightArray[0] doubleValue];
        for (int i = 1; i < columnCount ; i++) {
            //取得第i列的高度
            CGFloat columnHeight = [columnMaxHeightArray[i] doubleValue];
            if (maxColumnHeight < columnHeight) {
                maxColumnHeight = columnHeight;
            }
        }
    }

    CGFloat cellX = 0;//sectionModel.sectionInset.left;
    //sectionItemMargin + maxColumnHeight + sectionInset.bottom
    CGFloat cellYInCollectioinView = [self.sectionItemMargins[indexPath.section] floatValue] + maxColumnHeight + sectionInset.bottom;
    layoutAttribute.frame = CGRectMake(cellX, cellYInCollectioinView, itemWidth, itemHeight);
    //记录内容的高度
    self.contentHeight = MAX(self.contentHeight,CGRectGetMaxY(layoutAttribute.frame));
}
///计算SectionFooter layoutAttribute
- (void)horizontal_calculateSectionFooterLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {

    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize footerSize = [layoutDelegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];

    CGFloat itemWidth = footerSize.width;
    CGFloat itemHeight = footerSize.height;
    
    NSInteger columnCount = kUICollectionViewDefaulColumnCount;
   if([sectionModel respondsToSelector:@selector(jcs_columnCount)] && sectionModel.jcs_columnCount > 0){
       columnCount = sectionModel.jcs_columnCount;
   }
   
   UIEdgeInsets sectionInset = kUICollectionViewDefaulSectionInset;
   if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)]
      && !UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, sectionModel.jcs_getSectionInset)){
       sectionInset = sectionModel.jcs_getSectionInset;
   }

    //找出最大的maxColumnLength
    CGFloat maxColumnLength = 0;
    NSMutableArray *columnMaxLengthArray = self.sectionColumnMaxLengthArray[indexPath.section];
    if(columnMaxLengthArray.count > 0){
        //默认该Section第一个item最大
        maxColumnLength = [columnMaxLengthArray[0] doubleValue];
        for (int i = 1; i < columnCount ; i++) {
            //取得第i列的高度
            CGFloat columnHeight = [columnMaxLengthArray[i] doubleValue];
            if (maxColumnLength < columnHeight) {
                maxColumnLength = columnHeight;
            }
        }
    }

    //sectionItemMargin + maxColumnLength + sectionInset.right
    CGFloat cellXInCollectioinView = [self.sectionItemMargins[indexPath.section] floatValue] + maxColumnLength + sectionInset.right;
    CGFloat cellY = 0;//sectionModel.sectionInset.top;
    
    layoutAttribute.frame = CGRectMake(cellXInCollectioinView, cellY, itemWidth, itemHeight);
    //记录内容的宽度
    self.contentWidth = MAX(self.contentWidth,CGRectGetMaxX(layoutAttribute.frame));
    
}

#pragma mark - calculateCellLayoutAttribute

///计算Cell Item layoutAttribute
- (void)calculateCellLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    if(self.scrollDirection == UICollectionViewScrollDirectionVertical){
        [self vertical_calculateCellLayoutAttribute:indexPath layoutAttribute:layoutAttribute];
    } else {
        [self horizontal_calculateCellLayoutAttribute:indexPath layoutAttribute:layoutAttribute];
    }
}
///计算Cell Item layoutAttribute
- (void)vertical_calculateCellLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize cellSize =  [layoutDelegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    CGFloat itemWidth = cellSize.width;
    CGFloat itemHeight = cellSize.height;
    
    NSInteger columnCount = kUICollectionViewDefaulColumnCount;
    if([sectionModel respondsToSelector:@selector(jcs_columnCount)] && sectionModel.jcs_columnCount > 0){
        columnCount = sectionModel.jcs_columnCount;
    }
    
    UIEdgeInsets sectionInset = kUICollectionViewDefaulSectionInset;
    if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)] && !UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, sectionModel.jcs_getSectionInset)){
        sectionInset = sectionModel.jcs_getSectionInset;
    }
    
    CGFloat minimumLineSpacing = kUICollectionViewDefaultMinimumLineSpacing;
    if([sectionModel respondsToSelector:@selector(jcs_getMinimumLineSpacing)]){
        minimumLineSpacing = sectionModel.jcs_getMinimumLineSpacing;
    }
    
    CGFloat minimumInteritemSpacing = kUICollectionViewDefaultMinimumInteritemSpacing;
    if([sectionModel respondsToSelector:@selector(jcs_getMinimumInteritemSpacing)]){
        minimumInteritemSpacing = sectionModel.jcs_getMinimumInteritemSpacing;
    }

    //找出最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = 0;
    NSMutableArray *columnMaxHeightArray = self.sectionColumnMaxLengthArray[indexPath.section];
    if(columnMaxHeightArray.count > 0){
        //默认该Section第一个item最小
        minColumnHeight = [columnMaxHeightArray[0] doubleValue];
        for (int i = 1; i < columnCount ; i++) {
            //取得第i列的高度
            CGFloat columnHeight = [columnMaxHeightArray[i] doubleValue];
            if (minColumnHeight > columnHeight) {
                minColumnHeight = columnHeight;
                destColumn = i;
            }
        }
    }
    CGFloat cellX = destColumn * (itemWidth + minimumInteritemSpacing) + sectionInset.left;;
    //当前Section中的Y,第一排不需要添加minimumLineSpacing
    CGFloat cellYInSection = minColumnHeight + (minColumnHeight > 0 ? minimumLineSpacing : 0);
    CGFloat cellYInCollectioinView = [self.sectionItemMargins[indexPath.section] floatValue] + cellYInSection;
    
    layoutAttribute.frame = CGRectMake(cellX, cellYInCollectioinView, itemWidth, itemHeight);
    //更新最短那一列的高度
    columnMaxHeightArray[destColumn] = @(cellYInSection + itemHeight);
    //记录内容的高度 - 即最长那一列的高度
    self.contentHeight = MAX(self.contentHeight,CGRectGetMaxY(layoutAttribute.frame));
    
}
///计算Cell Item layoutAttribute
- (void)horizontal_calculateCellLayoutAttribute:(NSIndexPath*)indexPath
                              layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize cellSize =  [layoutDelegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    CGFloat itemWidth = cellSize.width;
    CGFloat itemHeight = cellSize.height;
    
    NSInteger columnCount = kUICollectionViewDefaulColumnCount;
    if([sectionModel respondsToSelector:@selector(jcs_columnCount)] && sectionModel.jcs_columnCount > 0){
        columnCount = sectionModel.jcs_columnCount;
    }
    
    UIEdgeInsets sectionInset = kUICollectionViewDefaulSectionInset;
    if([sectionModel respondsToSelector:@selector(jcs_getSectionInset)] && !UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, sectionModel.jcs_getSectionInset)){
        sectionInset = sectionModel.jcs_getSectionInset;
    }
    
    CGFloat minimumLineSpacing = kUICollectionViewDefaultMinimumLineSpacing;
    if([sectionModel respondsToSelector:@selector(jcs_getMinimumLineSpacing)]){
        minimumLineSpacing = sectionModel.jcs_getMinimumLineSpacing;
    }
    
    CGFloat minimumInteritemSpacing = kUICollectionViewDefaultMinimumInteritemSpacing;
    if([sectionModel respondsToSelector:@selector(jcs_getMinimumInteritemSpacing)]){
        minimumInteritemSpacing = sectionModel.jcs_getMinimumInteritemSpacing;
    }

    //找出最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnLength = 0;
    NSMutableArray *columnMaxLengthArray = self.sectionColumnMaxLengthArray[indexPath.section];
    if(columnMaxLengthArray.count > 0){
        //默认该Section第一个item最小
        minColumnLength = [columnMaxLengthArray[0] doubleValue];
        for (int i = 1; i < columnCount ; i++) {
            //取得第i列的高度
            CGFloat columnHeight = [columnMaxLengthArray[i] doubleValue];
            if (minColumnLength > columnHeight) {
                minColumnLength = columnHeight;
                destColumn = i;
            }
        }
    }
    
    CGFloat cellY = destColumn * (itemHeight + minimumInteritemSpacing) + sectionInset.top;
    //当前Section中的Y,第一列无需加上间隙minimumLineSpacing
    CGFloat cellXInSection = minColumnLength + (minColumnLength > 0 ? minimumLineSpacing : 0);
    CGFloat cellXInCollectioinView = [self.sectionItemMargins[indexPath.section] floatValue] + cellXInSection;
    
    layoutAttribute.frame = CGRectMake(cellXInCollectioinView, cellY, itemWidth, itemHeight);
    //更新最短那一列的高度
    columnMaxLengthArray[destColumn] = @(cellXInSection + itemWidth);
    //记录内容的宽度
    self.contentWidth = MAX(self.contentWidth,CGRectGetMaxX(layoutAttribute.frame));
    
}

#pragma mark - calculateDecorationLayoutAttribute
///计算Decoration Item layoutAttribute
- (void)calculateDecorationLayoutAttribute:(NSIndexPath*)indexPath
                              sectionFrame:(CGRect)sectionFrame
                           layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    if(self.scrollDirection == UICollectionViewScrollDirectionVertical){
        [self vertical_calculateDecorationLayoutAttribute:indexPath sectionFrame:sectionFrame layoutAttribute:layoutAttribute];
    } else {
        [self horizontal_calculateDecorationLayoutAttribute:indexPath sectionFrame:sectionFrame layoutAttribute:layoutAttribute];
    }
}
///计算Decoration Item layoutAttribute
- (void)vertical_calculateDecorationLayoutAttribute:(NSIndexPath*)indexPath
                                       sectionFrame:(CGRect)sectionFrame
                                    layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    UIEdgeInsets decorationMarginInset = UIEdgeInsetsZero;
    if([sectionModel respondsToSelector:@selector(jcs_getDecorationMarginInset)]){
        decorationMarginInset = sectionModel.jcs_getDecorationMarginInset;
    }
    
    CGFloat marginLeft = decorationMarginInset.left;
    CGFloat marginTop = decorationMarginInset.top;
    CGFloat marginRight = decorationMarginInset.right;
    CGFloat marginBottom = decorationMarginInset.bottom;
    
    CGFloat x = marginLeft;
    CGFloat y = CGRectGetMinY(sectionFrame) + marginTop;
    CGFloat width = self.collectionView.bounds.size.width - marginLeft - marginRight;
    CGFloat height = CGRectGetMaxY(sectionFrame) - y - marginBottom;
    
    layoutAttribute.frame = CGRectMake(x, y, width, height);
    
}
///计算Decoration Item layoutAttribute
- (void)horizontal_calculateDecorationLayoutAttribute:(NSIndexPath*)indexPath
                                         sectionFrame:(CGRect)sectionFrame
                                      layoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttribute {
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    UIEdgeInsets decorationMarginInset = UIEdgeInsetsZero;
    if([sectionModel respondsToSelector:@selector(jcs_getDecorationMarginInset)]){
        decorationMarginInset = sectionModel.jcs_getDecorationMarginInset;
    }
    
    CGFloat marginLeft = decorationMarginInset.left;
    CGFloat marginTop = decorationMarginInset.top;
    CGFloat marginRight = decorationMarginInset.right;
    CGFloat marginBottom = decorationMarginInset.bottom;
    
    CGFloat y = marginTop;
    CGFloat x = CGRectGetMinX(sectionFrame) + marginLeft;
    CGFloat height = self.collectionView.bounds.size.height - marginTop - marginBottom;
    CGFloat width = CGRectGetMaxX(sectionFrame) - x - marginRight;
    
    layoutAttribute.frame = CGRectMake(x, y, width, height);
    
}

#pragma mark - UICollectionViewLayout Required Methods

- (void)prepareLayout {
    [super prepareLayout];
    
    self.contentWidth = 0;
    self.contentHeight = 0;
    [self.sectionColumnMaxLengthArray removeAllObjects];
    [self.layoutAttributes removeAllObjects];
    
    //设置每一列默认的高度/宽度
    for (NSInteger section = 0; section < self.collectionView.numberOfSections; section++) {
        id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:section];
        
        //默认每个Section.Top距离UICollectionView.top的偏移量为0
        self.sectionItemMargins[section] = @0;
        
        //该 Section 下的 columnMaxHeightArray
        NSMutableArray *columnMaxLengthArray = [NSMutableArray array];
        [self.sectionColumnMaxLengthArray addObject:columnMaxLengthArray];
        
        NSInteger columnCount = kUICollectionViewDefaulColumnCount;
        if([sectionModel respondsToSelector:@selector(jcs_columnCount)] && sectionModel.jcs_columnCount > 0){
            columnCount = sectionModel.jcs_columnCount;
        }
        
        //为每个列都设置初始初始MaxHeight = sectionModel.headerSize.height;
        //这里的循环最大为 sectionModel.columnCount
        for( NSInteger item = 0; item < columnCount; item++ ){
            [columnMaxLengthArray addObject:@(0)];
        }
    }
    
    //清除之前所有的布局属性
    //开始创建每一个cell对应的布局属性
    for (NSInteger section = 0; section < self.collectionView.numberOfSections; section++) {

        JCS_CollectionViewCustomerLayoutSectionMaxFrameItem *maxFrameItem = [[JCS_CollectionViewCustomerLayoutSectionMaxFrameItem alloc] init];
        
        UICollectionViewLayoutAttributes *layoutAttributes = nil;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];

        id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:section];
        //计算每个Section下Item的Margin
        [self calculateSectionItemsMargin:indexPath];

        //Section Header LayoutAttributes
        layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [self calculateSectionHeaderLayoutAttribute:indexPath layoutAttribute:layoutAttributes];
        [maxFrameItem configWithAttributesIfNeed:layoutAttributes];
        
        [self.layoutAttributes addObject:layoutAttributes];
        
        //Section Items LayoutAttributes
        for( NSInteger item = 0; item < sectionModel.jcs_getItemsCount; item++ ){
            layoutAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:item inSection:section]];
            [self calculateCellLayoutAttribute:[NSIndexPath indexPathForRow:item inSection:section] layoutAttribute:layoutAttributes];
            [self.layoutAttributes addObject:layoutAttributes];
        }

        //Section Footer LayoutAttributes
        layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        [self calculateSectionFooterLayoutAttribute:indexPath layoutAttribute:layoutAttributes];
        [maxFrameItem configWithAttributesIfNeed:layoutAttributes];
        [self.layoutAttributes addObject:layoutAttributes];
        
        //DecorationView
        if([sectionModel respondsToSelector:@selector(jcs_getDecorationClass)] && sectionModel.jcs_getDecorationClass.jcs_isValid){
            Class clazz = NSClassFromString(sectionModel.jcs_getDecorationClass);
            NSAssert(clazz != nil, @"DecorationView class %@ 未识别 ",sectionModel.jcs_getDecorationClass);
            if(clazz){
                [self registerClass:clazz forDecorationViewOfKind:sectionModel.jcs_getDecorationClass];
                layoutAttributes = [self layoutAttributesForDecorationViewOfKind:sectionModel.jcs_getDecorationClass atIndexPath:indexPath];
                [self calculateDecorationLayoutAttribute:indexPath sectionFrame:maxFrameItem.getSectionFrame layoutAttribute:layoutAttributes];
                [self.layoutAttributes addObject:layoutAttributes];
            }
        }
    }
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if([UICollectionElementKindSectionHeader isEqualToString:elementKind]){
        return [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
        
    } else if([UICollectionElementKindSectionFooter isEqualToString:elementKind]){
        return [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    }
    return nil;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    
    id<JCS_CollectionViewSectionProtocol> sectionModel = [self.customerDelegate jcs_waterFallLayout:self sectionWithIndexPath:indexPath.section];
    
    layoutAttributes.zIndex = kUICollectionViewDefaulDecorationZIndex;
    if([sectionModel respondsToSelector:@selector(jcs_getDecorationZIndex)] && sectionModel.jcs_getDecorationZIndex > 0){
        layoutAttributes.zIndex = sectionModel.jcs_getDecorationZIndex;
    }
    if([sectionModel respondsToSelector:@selector(jcs_getDecorationData)]){
        layoutAttributes.jcs_data = sectionModel.jcs_getDecorationData;
    }
    
    return layoutAttributes;
}
//FIXME: 这里的算法有待优化
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributes;
}
- (CGSize)collectionViewContentSize {
    //垂直滚动
    if(self.scrollDirection == UICollectionViewScrollDirectionVertical){
        return CGSizeMake(self.collectionView.bounds.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right, self.contentHeight);
    }
    //水平滚动
    return CGSizeMake(self.contentWidth,self.collectionView.bounds.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom);
}

#pragma mark - 懒加载

JCS_LAZY(NSMutableArray, layoutAttributes)
JCS_LAZY(NSMutableArray, sectionColumnMaxLengthArray)
JCS_LAZY(NSMutableArray, sectionItemMargins)

@end
