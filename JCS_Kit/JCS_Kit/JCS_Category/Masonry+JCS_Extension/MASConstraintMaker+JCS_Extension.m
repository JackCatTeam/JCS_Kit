//
//  MASConstraintMaker+JCS_Extension.m
//  JCS_Kit
//
//  Created by 永平 on 2020/3/31.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "MASConstraintMaker+JCS_Extension.h"

@implementation MASConstraintMaker (JCS_Extension)

- (MASConstraint * _Nonnull (^)(CGFloat))jcs_width_e {
    return ^id(CGFloat value){
        self.width.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_height_e {
    return ^id(CGFloat value){
        self.height.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_top_e {
    return ^id(CGFloat value){
        self.top.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_left_e {
    return ^id(CGFloat value){
        self.top.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_right_e {
    return ^id(CGFloat value){
        self.right.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_bottom_e {
    return ^id(CGFloat value){
        self.right.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGPoint))jcs_center_e {
    return ^id(CGPoint value){
        self.center.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_centerX_e {
    return ^id(CGFloat value){
        self.centerX.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_centerY_e {
    return ^id(CGFloat value){
        self.centerY.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(UIEdgeInsets))jcs_edges_e {
    return ^id(UIEdgeInsets value){
        self.edges.mas_equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(CGFloat))jcs_baseline_e {
    return ^id(CGFloat value){
        self.baseline.mas_equalTo(value);
        return self;
    };
}

- (MASConstraint * _Nonnull (^)(id))jcs_width_r {
    return ^id(id value){
        self.width.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_height_r {
    return ^id(id value){
        self.height.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_top_r {
    return ^id(id value){
        self.top.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_left_r {
    return ^id(id value){
        self.left.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_right_r {
    return ^id(id value){
        self.right.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_bottom_r {
    return ^id(id value){
        self.bottom.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_center_r {
    return ^id(id value){
        self.center.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_centerX_r {
    return ^id(id value){
        self.centerX.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_centerY_r {
    return ^id(id value){
        self.centerY.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_edges_r {
    return ^id(id value){
        self.edges.equalTo(value);
        return self;
    };
}
- (MASConstraint * _Nonnull (^)(id))jcs_baseline_r {
    return ^id(id value){
        self.baseline.equalTo(value);
        return self;
    };
}

@end
