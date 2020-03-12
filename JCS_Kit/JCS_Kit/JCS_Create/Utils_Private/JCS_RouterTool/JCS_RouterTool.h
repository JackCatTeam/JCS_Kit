//
//  JCS_RouterTool.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/10.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_RouterTool : NSObject

+ (void)executeRouter:(NSString*)router data:(id)data;

@end

NS_ASSUME_NONNULL_END
