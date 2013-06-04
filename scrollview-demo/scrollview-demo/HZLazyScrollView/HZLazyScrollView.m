//
//  HZLazyScrollView.m
//  scrollview-demo
//
//  Created by holyenzou on 13-5-26.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import "HZLazyScrollView.h"
#import "CustomViewController.h"

@interface HZLazyScrollView ()

@end

@implementation HZLazyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.alwaysBounceHorizontal = NO;
    }
    return self;
}

- (void)reloadData
{
    NSLog(@"self.bounds.size.width: %f &&& numbers: %d" ,self.bounds.size.width, [self.dataSourceDelegate numberCountOfLazyScrollView:self]);
    _count = [self.dataSourceDelegate numberCountOfLazyScrollView:self];
    [self setContentSize:CGSizeMake(self.bounds.size.width * _count, self.bounds.size.height)];
    [self setContentOffset:CGPointMake(0, 0)];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = YES;
    NSMutableArray *posiInfos = [NSMutableArray arrayWithCapacity:_count];
    for (int i = 0; i < _count; i ++) {
        CGRect rect = CGRectMake(320 * i, 0, 320, self.bounds.size.height);
        NSValue *rectValue = [NSValue valueWithCGRect:rect];
        [posiInfos addObject:rectValue];
    }
    _positionInfos = posiInfos;
    
}

- (UIViewController *)viewControllerByIndex:(NSInteger)aIndex
{
    return [_dataSourceDelegate lazyScrollView:self viewAtIndex:aIndex];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0) {
        return;
    }
    if (page >= _count) {
        return;
    }
    UIViewController *viewController = [_dataSourceDelegate lazyScrollView:self viewAtIndex:page];
    if (viewController.view.superview == nil) {
        CGRect frame = self.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        //frame.size.height = frame.size.height;
        viewController.view.frame = frame;
        [self addSubview:viewController.view];
    }
}

- (void)removeViewWithPage:(NSNumber *)aIndex
{
    int page = [aIndex integerValue];
    if (page < 0) {
        return;
    }
    if (page >= _count) {
        return;
    }
    UIViewController *viewController = [_dataSourceDelegate lazyScrollView:self viewAtIndex:page];
    if (viewController.view.superview != nil) {
        [viewController.view removeFromSuperview];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float pageWidth = self.bounds.size.width;
    float currentOff = self.contentOffset.x;
    _currentPage = ((currentOff - pageWidth / 2) / pageWidth) + 1;
    UIViewController *viewController = [_dataSourceDelegate lazyScrollView:self viewAtIndex:_currentPage];

    NSLog(@"page = %d date = %@",_currentPage,((CustomViewController *)viewController).dateLabel.text);
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self loadScrollViewWithPage:_currentPage - 1];
    [self loadScrollViewWithPage:_currentPage];
    [self loadScrollViewWithPage:_currentPage + 1];
    NSLog(@"current chirdens: %d",[self.subviews count]);
    
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    NSLog(@"layoutSubviews");
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeSubs) object:nil];
//    [self performSelector:@selector(removeSubs) withObject:nil afterDelay:0.25];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)removeSubs
{
    UIViewController *viewController = [_dataSourceDelegate lazyScrollView:self viewAtIndex:_currentPage];
    NSLog(@"will remove: page = %d,%d, date = %@",_currentPage - 1,_currentPage + 1,((CustomViewController *)viewController).dateLabel.text);
    
    [self performSelector:@selector(removeViewWithPage:) withObject:[NSNumber numberWithInt:_currentPage - 2] afterDelay:0.25];
    [self performSelector:@selector(removeViewWithPage:) withObject:[NSNumber numberWithInt:_currentPage + 2] afterDelay:0.25];
}

@end
