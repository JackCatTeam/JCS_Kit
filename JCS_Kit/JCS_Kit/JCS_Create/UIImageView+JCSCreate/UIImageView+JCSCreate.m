//
//  UIImageView+JCCreate.m
//  NingTai
//
//  Created by 永平 on 2018/4/9.
//  Copyright © 2018年 yongping. All rights reserved.
//

#import "UIImageView+JCSCreate.h"
#import <SDWebImage/SDWebImage.h>

@implementation UIImageView (JCSCreate)

- (UIImageView *(^)(NSString *imageName))jcs_imageWithName{
    return ^id(NSString *imageName) {
        self.image = [UIImage imageNamed:imageName];
        return self;
    };
}

- (UIImageView *(^)(UIImage *image))jcs_image{
    return ^id(UIImage *image) {
        self.image = image;
        return self;
    };
}

- (UIImageView *(^)(NSString *url))jcs_imageWithUrlString{
    return ^id(NSString *url) {
        [self sd_setImageWithURL:[NSURL URLWithString:url]];
        return self;
    };
}

- (UIImageView *(^)(NSURL *url))jcs_imageWithUrl{
    return ^id(NSURL *url) {
        [self sd_setImageWithURL:url];
        return self;
    };
}

@end
