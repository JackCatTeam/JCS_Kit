//
//  NSObject+JCS_Router.h
//  Classes
//
//  Created by 永平 on 2020/1/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JCS_Router)

/** 路由自动注入的参数 **/
@property (nonatomic, strong) NSDictionary *jcs_params;

@end

NS_ASSUME_NONNULL_END
