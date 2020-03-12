//
//  JCS_TableViewProtocol.h
//  Pods
//
//  Created by 永平 on 2020/1/31.
//

#ifndef JCS_TableViewProtocol_h
#define JCS_TableViewProtocol_h
#import <UIKit/UIKit.h>
#import "JCS_BaseLib.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wnullability-completeness"

//这里避免继承 UICollectionViewDataSource 的原因是，UICollectionViewDataSource有两个方法是@required的
//但对于外部来说不是必须的。这样做避免外部没有实现@required而出现警告
@protocol JCS_TableViewProtocol <UITableViewDelegate,UIScrollViewDelegate>

@optional

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

#pragma clang diagnostic pop

#endif /* JCS_TableViewProtocol_h */
