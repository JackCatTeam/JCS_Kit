//
//  JCS_ConfigTableViewDatasource.h
//  JCS_BaseLib
//
//  Created by 永平 on 2020/1/31.
//

#import <UIKit/UIKit.h>
#import "JCS_EventBus.h"
#import "UITableView+JCSCreate.h"
#import "JCS_TableViewProtocol.h"
#import "JCS_TableViewRowProtocol.h"
#import "JCS_TableViewSectionProtocol.h"

#import "JCS_Create_Defines.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_ConfigTableViewDatasource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray<id<JCS_TableViewSectionProtocol>> *sections;
/** 用户自定义delegate **/
@property (nonatomic, weak) id<JCS_TableViewProtocol> customerDelegate;
/** 默认点击路由 **/
@property (nonatomic, copy) NSString *defaultRowClickRouter;
/** 默认CellClassName **/
@property (nonatomic, copy) NSString *defaultCellClassName;
/** Event Bus **/
@property (nonatomic, strong) JCS_EventBus *eventBus;
/** cell点击事件 **/
@property (nonatomic, copy) void (^customerDidSelectRowBlock)(NSIndexPath*indexPath,id<JCS_TableViewRowProtocol> selecedModel);

/** 选择模式 **/
@property (nonatomic, assign) JCS_SelectMode selectMode ;

@end

NS_ASSUME_NONNULL_END
