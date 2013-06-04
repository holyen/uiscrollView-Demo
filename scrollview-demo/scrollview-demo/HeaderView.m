//
//  HeaderView.m
//  scrollview-demo
//
//  Created by Holyen Zou on 13-6-4.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame dates:(NSArray *)aDates
{
    self = [super initWithFrame:frame];
    if (self) {
        _dates = aDates;
        _widthLabel = 70;
        _totalContentWidth = 300;
        NSMutableArray *labelsT = [NSMutableArray arrayWithCapacity:[_dates count]];
        NSMutableArray *positionArray = [NSMutableArray arrayWithCapacity:[_dates count]];
        for (int i = 0; i < [_dates count]; i ++) {
            [labelsT addObject:[NSNull null]];
            NSValue *rectValue = [NSValue valueWithCGRect:CGRectMake(_totalContentWidth, 0, _widthLabel, 15)];
            [positionArray addObject:rectValue];
            _totalContentWidth += _widthLabel + _widthMargin;
        }
        _labels = labelsT;
        _positionInfos = positionArray;
    }
    return self;
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0) {
        return;
    }
    if (page >= [_dates count]) {
        return;
    }
    UILabel *label = [self labelByIndex:page];
    if (label.superview == nil) {
        [self addSubview:label];
    }
}

- (void)updateUIByOffset:(float)aOffset
{
    
}

- (void)reloadData
{
    _currentIndex = 0;
    [self loadScrollViewWithPage:_currentIndex - 1];
    [self loadScrollViewWithPage:_currentIndex];
    [self loadScrollViewWithPage:_currentIndex + 1];
    self.contentSize = CGSizeMake(_totalContentWidth, 15);
}

- (UILabel *)labelByIndex:(int)aIndex
{
    if (aIndex >= [_labels count] || aIndex < 0) {
        return nil;
    }
    id res = [_labels objectAtIndex:aIndex];
    if (res == [NSNull null]) {
        CGRect rectValue = [((NSValue *)[_positionInfos objectAtIndex:aIndex]) CGRectValue];
        UILabel *label = [[UILabel alloc] initWithFrame:rectValue];
        label.text = [[_dates objectAtIndex:aIndex] toString];
        label.textColor = [UIColor blackColor];
        [_labels replaceObjectAtIndex:aIndex withObject:label];
        return label;
    }
    return res;
}

@end
