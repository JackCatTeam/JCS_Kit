//
//  JCS_Create_Defines.h
//  JCS_Create
//
//  Created by 永平 on 2020/2/15.
//  Copyright © 2020 yongping. All rights reserved.
//

#ifndef JCS_Create_Defines_h
#define JCS_Create_Defines_h

typedef enum : NSUInteger {
    JCS_SelectModeSingle = 0,
    JCS_SelectModeSectionSingle = 1,
    JCS_SelectModeMultiple = 2,
} JCS_SelectMode;

#define kUICollectionViewDefaultHeaderClass @"JCS_CollectionViewSectionHeaderEmptyView"
#define kUICollectionViewDefaultFooterClass @"JCS_CollectionViewSectionFooterEmptyView"
#define kUICollectionViewDefaultHeaderSize CGSizeZero
#define kUICollectionViewDefaultFooterSize CGSizeZero
#define kUICollectionViewDefaultMinimumInteritemSpacing 10
#define kUICollectionViewDefaultMinimumLineSpacing 10
#define kUICollectionViewDefaulSectionInset UIEdgeInsetsZero
#define kUICollectionViewDefaulColumnCount 1
#define kUICollectionViewDefaulDecorationZIndex -1

#endif /* JCS_Create_Defines_h */
