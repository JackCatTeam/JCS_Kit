//
//  JCS_TableViewRowProtocol.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_TableViewRowProtocol_h
#define JCS_TableViewRowProtocol_h

@protocol JCS_TableViewRowProtocol <NSObject>

@required

/// 获取Cell Height
- (CGFloat)jcs_getCellHeight;
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

#endif /* JCS_TableViewRowProtocol_h */
