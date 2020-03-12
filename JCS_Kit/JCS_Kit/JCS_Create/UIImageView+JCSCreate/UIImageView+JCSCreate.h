//
//  UIImageView+JCSCreate.h
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JCSCreate)
/**
 设置图片
 */
@property (nonatomic,copy,readonly) UIImageView*(^jcs_image)(UIImage *image);
@property (nonatomic,copy,readonly) UIImageView*(^jcs_imageWithName)(NSString *imageName);
@property (nonatomic,copy,readonly) UIImageView*(^jcs_imageWithUrlString)(NSString *url);
@property (nonatomic,copy,readonly) UIImageView*(^jcs_imageWithUrl)(NSURL *url);
@end
