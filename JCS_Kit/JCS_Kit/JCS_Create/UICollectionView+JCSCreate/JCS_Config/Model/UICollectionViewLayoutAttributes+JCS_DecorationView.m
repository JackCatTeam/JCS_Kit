//
//  UICollectionViewLayoutAttributes+JCS_DecorationView.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/15.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "UICollectionViewLayoutAttributes+JCS_DecorationView.h"
#import <objc/runtime.h>

@implementation UICollectionViewLayoutAttributes (JCS_DecorationView)

@dynamic jcs_data;

static char config_UICollectionViewLayoutAttributes_JCS_DecorationView_key;

- (void)setJcs_data:(id)jcs_data {
    objc_setAssociatedObject(self, &config_UICollectionViewLayoutAttributes_JCS_DecorationView_key, jcs_data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)jcs_data {
    return objc_getAssociatedObject(self, &config_UICollectionViewLayoutAttributes_JCS_DecorationView_key);
}

@end
