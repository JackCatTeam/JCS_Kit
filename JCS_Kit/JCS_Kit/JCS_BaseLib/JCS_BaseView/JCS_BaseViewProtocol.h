//
//  JCS_BaseViewProtocol.h
//  StarCard
//
//  Created by 永平 on 2020/1/16.
//  Copyright © 2020 youye. All rights reserved.
//

#ifndef JCS_BaseViewProtocol_h
#define JCS_BaseViewProtocol_h

@protocol JCS_BaseViewProtocol <NSObject>

/// 设置UI
- (void)jcs_setupUI;
/// 绑定信号
- (void)jcs_bindingSignal;

@end

#endif /* JCS_BaseViewProtocol_h */
