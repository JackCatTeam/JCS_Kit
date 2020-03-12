//
//  NSData+JCS_Extension.h
//  JCS_Category
//
//  Created by 永平 on 2020/2/8.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (JCS_Extension)

///是否是JSON对象
- (BOOL)isJSONData;

@end

NS_ASSUME_NONNULL_END
