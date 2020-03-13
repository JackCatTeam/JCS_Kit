//
//  DemoCollectionDecorationVIew.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/15.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "DemoCollectionDecorationVIew.h"
#import "JCS_Create.h"

@implementation DemoCollectionDecorationVIew

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.3;
        self.jcs_randomBackgroundColor();
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    NSLog(@"---decoration.data = %@",layoutAttributes.jcs_data);
}

@end
