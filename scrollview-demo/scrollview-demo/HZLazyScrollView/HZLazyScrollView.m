//
//  HZLazyScrollView.m
//  scrollview-demo
//
//  Created by holyenzou on 13-5-26.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import "HZLazyScrollView.h"

@interface HZLazyScrollView ()

@end

@implementation HZLazyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = NO;
        self.delegate = self;
        self.alwaysBounceHorizontal = NO;
    }
    return self;
}

- (void)reloadData
{
    _viewControllersInUI = [NSMutableArray arrayWithObjects:[NSNull null],
                                                            [NSNull null],
                                                            [NSNull null], nil];
    _numberOfCount = [_dataSourceDelegate numberCountOfLazyScrollView:self];
    _countOfPosition = 5;//设定5个位置
    _centerIndex = (_countOfPosition - 1) / 2;
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
    
    [self scrollToIndex:_centerIndex animated:NO];//scroll to center.
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

- (void)scrollToIndex:(NSUInteger)aIndex animated:(BOOL)aAnimated
{
    _currentSelectedIndex = aIndex;
    [self scrollRectToVisible:[self rectOfPositionWithIndex:aIndex] animated:aAnimated];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isUp) {
        [self scrollRectToVisible:CGRectMake(_xWhenUp, 0, 320, self.bounds.size.height) animated:NO];
        return;
    }
    int currentPosition = scrollView.contentOffset.x;
    if (currentPosition - _lastPosition > 25) {
        //指向右
        _lastPosition = currentPosition;
        if (_currentSelectedIndex <= 0) {
            NSLog(@"_currentSelectedIndex <= 0");
            [self scrollToIndex:_centerIndex animated:YES];
        }
    } else if (_lastPosition - currentPosition > 25) {
        //左
        _lastPosition = currentPosition;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isUp = YES;
    _xWhenUp = scrollView.contentOffset.x;
    int currentPosition = scrollView.contentOffset.x;
    if (currentPosition >= 800) {
        [self scrollToIndex:_currentSelectedIndex + 1 animated:YES];
    } else if (currentPosition <= 480) {
        [self scrollToIndex:_currentSelectedIndex - 1 animated:YES];
    } else {
        [self scrollToIndex:_currentSelectedIndex animated:YES];
    }
    NSLog(@"scrollViewDidEndDragging currentPosition:%d",currentPosition);
    _isUp = NO;
}

@end
