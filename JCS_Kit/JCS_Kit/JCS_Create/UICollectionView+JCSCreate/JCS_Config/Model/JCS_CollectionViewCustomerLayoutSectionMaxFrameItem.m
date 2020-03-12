//
//  JCS_CollectionViewCustomerLayoutSectionMaxFrameItem.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/28.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_CollectionViewCustomerLayoutSectionMaxFrameItem.h"

@implementation JCS_CollectionViewCustomerLayoutSectionMaxFrameItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.left = -1;
        self.top = -1;
        self.right = - 1;
        self.bottom = -1;
    }
    return self;
}

- (CGRect)getSectionFrame {
    return CGRectMake(self.left,self.top,self.right - self.left,self.bottom-self.top);
}

- (void)configWithAttributesIfNeed:(UICollectionViewLayoutAttributes*)layoutAttributes {
    CGFloat left = CGRectGetMinX(layoutAttributes.frame);
    CGFloat top = CGRectGetMinY(layoutAttributes.frame);
    CGFloat right = CGRectGetMaxX(layoutAttributes.frame);
    CGFloat bottom = CGRectGetMaxY(layoutAttributes.frame);

    if(self.left <= -1 || (left < self.left)){ self.left = left; }
    if(self.top <= -1 || (top < self.top)){ self.top = top; }
    if(self.right <= -1 || (right > self.right)){ self.right = right; }
    if(self.bottom <= -1 || (bottom > self.bottom)){ self.bottom = bottom; }
}

@end
