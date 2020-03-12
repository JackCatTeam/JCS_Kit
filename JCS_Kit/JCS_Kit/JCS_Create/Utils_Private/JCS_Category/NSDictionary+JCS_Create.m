//
//  NSDictionary+JCS_Create.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSDictionary+JCS_Create.h"
#import "NSString+JCS_Create.h"
#import "JCS_ConvertTool.h"

@implementation NSDictionary (JCS_Create)

+ (CGSize)jcs_dictionaryToSize:(NSDictionary*)value {
    if(value && [value isKindOfClass:NSDictionary.class]){
        id width = [value valueForKey:@"width"];
        id height = [value valueForKey:@"height"];
        return CGSizeMake([JCS_ConvertTool valueToFloat:width],
                          [JCS_ConvertTool valueToFloat:height]);
    }
    return CGSizeZero;
}
- (CGSize)jcs_toSize {
    return [[self class] jcs_dictionaryToSize:self];
}

+ (UIEdgeInsets)jcs_dictionaryToInsets:(NSDictionary*)value {
    if(value && [value isKindOfClass:NSDictionary.class]){
            id top = [value valueForKey:@"top"];
            id left = [value valueForKey:@"left"];
            id bottom = [value valueForKey:@"bottom"];
            id right = [value valueForKey:@"right"];
            return UIEdgeInsetsMake([JCS_ConvertTool valueToFloat:top],
                                    [JCS_ConvertTool valueToFloat:left],
                                    [JCS_ConvertTool valueToFloat:bottom],
                                    [JCS_ConvertTool valueToFloat:right]);
    }
    return UIEdgeInsetsZero;
}
- (UIEdgeInsets)jcs_toInsets {
    return [[self class] jcs_dictionaryToInsets:self];
}

@end
