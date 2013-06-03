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
    _dates = [self calculateDateInfo];
    _viewControllers = [NSMutableArray arrayWithCapacity:[_dates count]];
    for (int i = 0; i < [_dates count]; i ++) {
        [_viewControllers addObject:[NSNull null]];
    }
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _lazyScrollView = [[HZLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    _lazyScrollView.dataSourceDelegate = self;
    _lazyScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_lazyScrollView];
    [_lazyScrollView reloadData];
}

- (NSArray *)calculateDateInfo
{
    /* gain the 2years date **/
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *dateComponents = [currentCalendar components:(NSYearCalendarUnit |
                                                                    NSMonthCalendarUnit |
                                                                    NSDayCalendarUnit)
                                                          fromDate:currentDate];
    NSInteger iCurYear = [dateComponents year];
    NSInteger iCurMonth = [dateComponents month];
    NSInteger iCurDay = [dateComponents day];
    
    NSMutableArray *totalDate = [NSMutableArray array];
    NSUInteger yearsAmount = 2;
    
    for (int i = iCurYear - (yearsAmount - 1); i <= iCurYear; i ++) {
        
        NSRange monthsOfOneYear;
        NSDate *dateForRange;
        if (i == iCurYear) {
            //current year:
            dateForRange = currentDate;
        } else
        {
            dateForRange = [NSDate dateWithYear:i month:1 day:1];
        }
        monthsOfOneYear = [currentCalendar rangeOfUnit:NSMonthCalendarUnit
                                                inUnit:NSYearCalendarUnit
                                               forDate:dateForRange];
        for (int j = 1; j <= monthsOfOneYear.length; j ++) {
            //calculate days in month.
            NSRange daysOfOneMonth = [currentCalendar rangeOfUnit:NSDayCalendarUnit
                                                           inUnit:NSMonthCalendarUnit
                                                          forDate:[NSDate dateWithYear:i month:j day:1]];
            for (int z = 1; z <= daysOfOneMonth.length; z ++) {
                if (i < iCurYear || (i == iCurYear && j < iCurMonth) || (i == iCurYear && j == iCurMonth && z < iCurDay)) {
                    [totalDate addObject:[NSDate dateWithYear:i month:j day:z]];
                }
            }
        }
        
    }
    return totalDate;
}


- (NSInteger)numberCountOfLazyScrollView:(HZLazyScrollView *)lazyScrollView
{
    return [_viewControllers count];
}

- (UIViewController *)lazyScrollView:(HZLazyScrollView *)lazyScrollView
                         viewAtIndex:(NSInteger)aIndex
{
    if (aIndex > _viewControllers.count || aIndex < 0) return nil;
    id res = [_viewControllers objectAtIndex:aIndex];
    if (res == [NSNull null]) {
        CustomViewController *contr = [[CustomViewController alloc] initWithNibName:nil bundle:nil];
        contr.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        contr.view.backgroundColor = [UIColor colorWithRed: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                     green: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                      blue: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                     alpha: 1.0f];
        contr.dateLabel.text = [NSString stringWithFormat:@"%@",[_dates objectAtIndex:aIndex]];
        [_viewControllers replaceObjectAtIndex:aIndex withObject:contr];
        return contr;
    }
    return res;
}

@end
