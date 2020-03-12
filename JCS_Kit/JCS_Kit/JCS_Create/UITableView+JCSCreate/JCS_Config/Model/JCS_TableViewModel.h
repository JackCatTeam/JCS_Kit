//
//  JCS_TableViewModel.h
//  JCS_Monitor
//
//  Created by 永平 on 2020/1/21.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_TableViewRowProtocol.h"
#import "JCS_TableViewSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_TableViewRowModel : NSObject<JCS_TableViewRowProtocol>

/** 数据 **/
@property (nonatomic, strong) id data;
/** Cell Class **/
@property (nonatomic, copy) NSString *cellClass;
/** Cell Height **/
@property (nonatomic, assign) CGFloat cellHeight;
/** 点击路由 **/
@property (nonatomic, copy) NSString *clickRouter;
/** 是否被选中 **/
@property (nonatomic, assign) BOOL jcs_checked;

@end


@interface JCS_TableViewSectionModel : NSObject<JCS_TableViewSectionProtocol>

/** 数据行 **/
@property (nonatomic, strong) NSMutableArray<id<JCS_TableViewRowProtocol>> *rows;

/** Header Class **/
@property (nonatomic, copy) NSString *headerClass;
/** Header Title **/
@property (nonatomic, copy) NSString *headerTitle;
/** Header Height **/
@property (nonatomic, assign) CGFloat headerHeight;

/** Footer Class **/
@property (nonatomic, copy) NSString *footerClass;
/** Footer TItle **/
@property (nonatomic, copy) NSString *footerTitle;
/** Footer Height **/
@property (nonatomic, assign) CGFloat footerHeight;

/** HeaderData **/
@property (nonatomic, strong) id headerData;
/** FooterData **/
@property (nonatomic, strong) id footerData;

@end

NS_ASSUME_NONNULL_END
