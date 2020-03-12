//
//  JCS_ConfigCollectionViewDatasource.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/9.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCS_CollectionViewProtocol.h"
#import "JCS_CollectionViewItemProtocol.h"
#import "JCS_CollectionViewSectionProtocol.h"
#import "JCS_Create_Defines.h"
#import "JCS_EventBus.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCS_ConfigCollectionViewDatasource : NSObject<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<id<JCS_CollectionViewSectionProtocol>> *sections;
/** 用户自定义delegate **/
@property (nonatomic, weak) id<JCS_CollectionViewProtocol> customerDelegate;
/* 布局 **/
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
/** 默认点击路由 **/
@property (nonatomic, copy) NSString *defaultItemClickRouter;
/** 默认CellClassName **/
@property (nonatomic, copy) NSString *defaultCellClassName;
/** Event Bus **/
@property (nonatomic, strong) JCS_EventBus *eventBus;
/** cell点击事件 **/
@property (nonatomic, copy) void (^customerDidSelectRowBlock)(NSIndexPath*indexPath,id<JCS_CollectionViewItemProtocol> selecedModel);

/** 选择模式 **/
@property (nonatomic, assign) JCS_SelectMode selectMode ;

@end

NS_ASSUME_NONNULL_END
