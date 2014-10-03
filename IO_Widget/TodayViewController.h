//
//  TodayViewController.h
//  IO_Widget
//
//  Created by Keaton Burleson on 9/22/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController :  UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *widgetArray;
    NSArray *localList;
   // MasterViewController *masterViewController;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
