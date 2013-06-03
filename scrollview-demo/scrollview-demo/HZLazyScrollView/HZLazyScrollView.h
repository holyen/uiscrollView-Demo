//
//  HZLazyScrollView.h
//  scrollview-demo
//
//  Created by holyenzou on 13-5-26.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZLazyScrollView;

@protocol HZLazyScrollViewDataSource <NSObject>

@required

- (NSInteger)numberCountOfLazyScrollView:(HZLazyScrollView *)lazyScrollView;

- (UIViewController *)lazyScrollView:(HZLazyScrollView *)lazyScrollView viewAtIndex:(NSInteger)aIndex;

@end

@interface HZLazyScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSMutableArray *_viewControllersInUI;
    NSArray *_positionsOfViewController;//5个位置的x坐标.
    NSUInteger _countOfPosition;//总共设定5个位置.
    int _lastPosition;
    NSInteger _currentSelectedIndex;
    NSUInteger _numberOfCount;
    NSUInteger _centerIndex;
    BOOL _isUp;
    float _xWhenUp;
}

@property (nonatomic, assign) id<HZLazyScrollViewDataSource> dataSourceDelegate;

- (void)reloadData;

@end
