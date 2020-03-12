//
//  NSArray+JCS_Create.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSArray+JCS_Create.h"
#import "JCS_ConvertTool.h"

@implementation NSArray (JCS_Create)

+ (CGSize)jcs_arrayToSize:(NSArray*)value {
    if(value && [value isKindOfClass:NSArray.class]){
        if(value.count > 1){
            id width = value[0];
            id height = value[1];
            return CGSizeMake([JCS_ConvertTool valueToFloat:width], [JCS_ConvertTool valueToFloat:height]);
        }
    }
    
    return CGSizeZero;
}
- (CGSize)jcs_toSize {
    return [[self class] jcs_arrayToSize:self];
}

+ (UIEdgeInsets)jcs_arrayToInsets:(NSArray*)value {
    if(value && [value isKindOfClass:NSArray.class]){
        if(value.count > 3){
            id top = value[0];
            id left = value[1];
            id bottom = value[2];
            id right = value[3];
            return UIEdgeInsetsMake([JCS_ConvertTool valueToFloat:top],
                                    [JCS_ConvertTool valueToFloat:left],
                                    [JCS_ConvertTool valueToFloat:bottom],
                                    [JCS_ConvertTool valueToFloat:right]);
        }
    }
    return UIEdgeInsetsZero;
}
- (UIEdgeInsets)jcs_toInsets {
    return [[self class] jcs_arrayToInsets:self];
}

@end
