//
//  ViewController.m
//  scrollview-demo
//
//  Created by holyenzou on 13-5-5.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import "ViewController.h"

#define ARC4RANDOM_MAX	0x100000000

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viewControllers = [NSMutableArray arrayWithCapacity:500];
    _lazyScrollView = [[HZLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    _lazyScrollView.dataSourceDelegate = self;
    [self.view addSubview:_lazyScrollView];
    [_lazyScrollView reloadData];
}

- (NSInteger)numberCountOfLazyScrollView:(HZLazyScrollView *)lazyScrollView
{
    return [_viewControllers count];
}

- (UIViewController *)lazyScrollView:(HZLazyScrollView *)lazyScrollView
                         viewAtIndex:(NSInteger)aIndex
{
    UIViewController *contr = [[UIViewController alloc] init];
    contr.view.backgroundColor = [UIColor colorWithRed: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                 green: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                  blue: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                 alpha: 1.0f];
    
    UILabel* label = [[UILabel alloc] initWithFrame:contr.view.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.text = [NSString stringWithFormat:@"%d",aIndex];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:50];
    [contr.view addSubview:label];
    return contr;
}

@end
