//
//  JCS_CollectionViewItemProtocol.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/25.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_CollectionViewItemProtocol_h
#define JCS_CollectionViewItemProtocol_h

#import <UIKit/UIKit.h>

@protocol JCS_CollectionViewItemProtocol <NSObject>

@required

// 获取Cell Size
- (CGSize)jcs_getCellSize;
/// 获取CellClass
- (NSString*)jcs_getCellClass;

@optional

/// 获取数据
- (id)jcs_getData;
/// 获取点击路由
- (NSString*)jcs_getClickRouter;
/** 是否被选中 **/
@property (nonatomic, assign) BOOL jcs_checked;

@end

#endif /* JCS_CollectionViewItemProtocol_h */
