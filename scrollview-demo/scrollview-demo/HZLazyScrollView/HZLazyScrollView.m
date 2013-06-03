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
    NSLog(@"self.bounds.size.width: %f &&& numbers: %d" ,self.bounds.size.width, [self.dataSourceDelegate numberCountOfLazyScrollView:self]);
    _count = [self.dataSourceDelegate numberCountOfLazyScrollView:self];
    [self setContentSize:CGSizeMake(self.bounds.size.width * _count, self.bounds.size.height)];
    [self setContentOffset:CGPointMake(0, 0)];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = YES;
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
        frame.size.height = frame.size.height - 80;
        viewController.view.frame = frame;
        [self addSubview:viewController.view];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float pageWidth = self.bounds.size.width;
    float currentOff = self.contentOffset.x;
    int page = ((currentOff - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"page = %d",page);
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

@end
