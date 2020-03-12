//
//  JCS_TableViewSectionProtocol.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/27.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_TableViewSectionProtocol_h
#define JCS_TableViewSectionProtocol_h

@protocol JCS_TableViewRowProtocol;

@protocol JCS_TableViewSectionProtocol <NSObject>

@required

- (NSInteger)jcs_getRowsCount;
- (id<JCS_TableViewRowProtocol>)jcs_getRowAtIndex:(NSInteger)index;

@optional

- (NSString *)jcs_getHeaderViewClassName;
- (NSString *)jcs_getFooterViewClassName;

- (id)jcs_getHeaderData;
- (id)jcs_getFooterData;

- (NSString *)jcs_getHeaderTitle;
- (NSString *)jcs_getFooterTitle;

- (CGFloat)jcs_getHeaderHeight;
- (CGFloat)jcs_getFooterHeight;

@end

#endif /* JCS_TableViewSectionProtocol_h */
