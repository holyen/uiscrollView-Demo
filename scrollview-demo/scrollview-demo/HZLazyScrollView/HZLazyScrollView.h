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
    NSUInteger _count;
    NSUInteger _currentPage;
    NSArray *_positionInfos;//每个cell的位置信息
}

@property (nonatomic, assign) id<HZLazyScrollViewDataSource> dataSourceDelegate;

- (void)reloadData;

@end
