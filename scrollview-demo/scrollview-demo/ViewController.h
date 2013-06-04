//
//  ViewController.h
//  scrollview-demo
//
//  Created by holyenzou on 13-5-5.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLazyScrollView.h"
#import "NSDate+Helper.h"
#import "CustomViewController.h"
#import "HeaderView.h"

@interface ViewController : UIViewController <HZLazyScrollViewDataSource>
{
    NSMutableArray *_viewControllers;
    HZLazyScrollView *_lazyScrollView;
    NSArray *_dates;
    HeaderView *_headerView;
}
@end
