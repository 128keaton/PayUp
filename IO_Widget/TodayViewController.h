//
//  TodayViewController.h
//  IO_Widget
//
//  Created by Keaton Burleson on 9/22/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OweTableViewCell.h"
@interface TodayViewController :  UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *widgetArray;
    NSArray *localList;
   // MasterViewController *masterViewController;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
