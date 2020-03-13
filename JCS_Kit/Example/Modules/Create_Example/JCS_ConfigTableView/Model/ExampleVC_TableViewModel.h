//
//  ExampleVC_TableViewModel.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/28.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_Create.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleVC_TableViewRowModel : NSObject<JCS_TableViewRowProtocol>

/** 数据 **/
@property (nonatomic, strong) id data2;
/** Cell Class **/
@property (nonatomic, copy) NSString *cellClass2;
/** Cell Height **/
@property (nonatomic, assign) CGFloat cellHeight2;
/** 点击路由 **/
@property (nonatomic, copy) NSString *clickRouter2;
/** 是否被选中 **/
@property (nonatomic, assign) BOOL jcs_checked;

@end


@interface ExampleVC_TableViewSectionModel : NSObject<JCS_TableViewSectionProtocol>

/** 数据行 **/
@property (nonatomic, strong) NSMutableArray<id<JCS_TableViewRowProtocol>> *rows2;

/** Header Class **/
@property (nonatomic, copy) NSString *headerClass2;
/** Header Title **/
@property (nonatomic, copy) NSString *headerTitle2;
/** Header Height **/
@property (nonatomic, assign) CGFloat headerHeight2;

/** Footer Class **/
@property (nonatomic, copy) NSString *footerClass2;
/** Footer TItle **/
@property (nonatomic, copy) NSString *footerTitle2;
/** Footer Height **/
@property (nonatomic, assign) CGFloat footerHeight2;


/** HeaderData **/
@property (nonatomic, strong) id headerData2;
/** FooterData **/
@property (nonatomic, strong) id footerData2;

@end

NS_ASSUME_NONNULL_END
