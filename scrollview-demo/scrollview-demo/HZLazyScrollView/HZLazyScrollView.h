//
//  HZLazyScrollView.h
//  scrollview-demo
//
//  Created by holyenzou on 13-5-26.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZLazyScrollView;

@protocol HZLazyScrollViewDelegate <UIScrollViewDelegate>

@optional

@end

@protocol HZLazyScrollViewDataSource <NSObject>

@required

- (NSInteger)lazyScrollView:(HZLazyScrollView *)lazyScrollView numberOfCount:(NSInteger)aCount;

- (UIViewController *)lazyScrollView:(HZLazyScrollView *)lazyScrollView viewAtIndex:(NSInteger)aIndex;

@end

@interface HZLazyScrollView : UIScrollView
{
    NSMutableArray *_viewControllersInUI;
    NSArray *_positionsOfViewController;//5个位置的x坐标.
    NSUInteger _countOfPosition;//总共设定5个位置.
}

@property (nonatomic, assign) id<HZLazyScrollViewDelegate> delegate;
@property (nonatomic, assign) id<HZLazyScrollViewDataSource> dataSourceDelegate;

- (void)reloadData;

@end
