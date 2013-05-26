//
//  ViewController.h
//  scrollview-demo
//
//  Created by holyenzou on 13-5-5.
//  Copyright (c) 2013年 HolyenZou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLazyScrollView.h"

@interface ViewController : UIViewController <HZLazyScrollViewDelegate, HZLazyScrollViewDataSource>
{
    NSMutableArray *_viewControllers;
    HZLazyScrollView *_lazyScrollView;
}
@end
