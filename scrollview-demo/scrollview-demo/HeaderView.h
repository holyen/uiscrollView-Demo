//
//  HeaderView.h
//  scrollview-demo
//
//  Created by Holyen Zou on 13-6-4.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Helper.h"

@interface HeaderView : UIScrollView
{
    NSArray *_dates;
    NSArray *_positionInfos;
    NSMutableArray *_labels;

    float _widthLabel;
    float _widthMargin;
    float _totalContentWidth;
    NSUInteger _currentIndex;
}

- (void)updateUIByOffset:(float)aOffset;

- (id)initWithFrame:(CGRect)frame dates:(NSArray *)aDates;

- (void)reloadData;

@end
