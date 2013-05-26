//
//  HZLazyScrollView.m
//  scrollview-demo
//
//  Created by holyenzou on 13-5-26.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import "HZLazyScrollView.h"

#define NEW_VIEW_CONTROLLER         [[UIViewController alloc] initWithNibName:nil bundle:nil]

@interface HZLazyScrollView () <UIScrollViewDelegate>

@end

@implementation HZLazyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = NO;
    }
    return self;
}

- (void)reloadData
{
    _viewControllersInUI = [NSMutableArray arrayWithObjects:[NSNull null],
                                                     [NSNull null],
                                                     [NSNull null], nil];
    _countOfPosition = 5;//设定5个位置
    NSMutableArray *temOfPositionsArray = [NSMutableArray arrayWithCapacity:_countOfPosition];
    for (int i = 0; i < _countOfPosition; i ++) {
        [temOfPositionsArray addObject:[NSValue valueWithCGRect:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)]];
    }
    _positionsOfViewController = temOfPositionsArray;
    
    for (int j = 0; j < [_viewControllersInUI count]; j ++) {
        UIViewController *viewController = [self viewControllerByIndex:j];
        [_viewControllersInUI replaceObjectAtIndex:j withObject:viewController];
        NSInteger indexUsed = NSNotFound;
        if (j == 0) {
            indexUsed = 1;
        } else if (j == 1) {
            indexUsed = 2;
        } else if (j == 2) {
            indexUsed = 3;
        }
        viewController.view.frame = [self rectOfPositionWithIndex:indexUsed];//使用新的位置.
        [viewController.view removeFromSuperview];
        [self addSubview:viewController.view];
    }
    [self setContentSize:CGSizeMake([_positionsOfViewController count] * self.bounds.size.width, self.bounds.size.height)];
    self.showsHorizontalScrollIndicator = YES;
    
    [self scrollRectToVisible:[self rectOfPositionWithIndex:(_countOfPosition - 1) / 2] animated:YES];//scroll to center.
    UILabel *logLabel = [[UILabel alloc] initWithFrame:CGRectMake(640, 0, 320, 100)];
    logLabel.text = [NSString stringWithFormat:@"scrollView's contentSize:[%f,%f]; current x position:%f",self.contentSize.width,self.contentSize.height, self.contentOffset.x];
    logLabel.textColor = [UIColor blackColor];
    [self addSubview:logLabel];
}

- (UIViewController *)viewControllerByIndex:(NSInteger)aIndex
{
    return [_dataSourceDelegate lazyScrollView:self viewAtIndex:aIndex];
}

- (CGRect)rectOfPositionWithIndex:(NSInteger)aIndex
{
    return [((NSValue *)[_positionsOfViewController objectAtIndex:aIndex]) CGRectValue];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (<#condition#>) {
        <#statements#>
    }
}

@end
