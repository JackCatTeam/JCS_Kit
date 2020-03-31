//
//  MASConstraint+JCS_Extension.h
//  JCS_Kit
//
//  Created by 永平 on 2020/3/31.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASConstraint (JCS_Extension)

@property (nonatomic, copy,readonly) MASConstraint*(^jcs_width_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_height_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_top_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_left_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_right_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_bottom_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_centerX_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_centerY_e)(CGFloat value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_baseline_e)(CGFloat value);

@property (nonatomic, copy,readonly) MASConstraint*(^jcs_width_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_height_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_top_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_left_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_right_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_bottom_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_centerX_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_centerY_r)(id value);
@property (nonatomic, copy,readonly) MASConstraint*(^jcs_baseline_r)(id value);

@end

NS_ASSUME_NONNULL_END
