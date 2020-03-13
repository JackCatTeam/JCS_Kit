//
//  ExampleVC_EmptyDemo.m
//  JCS_Create
//
//  Created by 永平 on 2020/3/4.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ExampleVC_EmptyDemo.h"
#import "JCS_Create.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ExampleVC_EmptyDemo ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ExampleVC_EmptyDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.jcs_whiteBackgroundColor();
    
    [UITableView jcs_createAndLayout:self constraintBlock:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }]
    .jcs_tableFooterView_Empty()
    .jcs_associated(&_tableView);
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"hotel_bill"];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Please Allow Photo Access";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
                                 
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};

    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
}

//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    return [UIImage imageNamed:@"hotel_bill"];
//}

//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIColor blueColor];
//}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
    return nil;
}

//未生效
//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
//{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
//
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
//
//    animation.duration = 0.25;
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//
//    return animation;
//}
//- (BOOL)emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
//{
//    return YES;
//}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -100;
}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return 50.0f;
//}

//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
//{
//    return YES;
//}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    // Do something
    JCS_LogInfo(@"didTapView");
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    // Do something
    JCS_LogInfo(@"didTapButton");
}

@end
