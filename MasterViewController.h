//
//  WIOMasterViewController.h
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//
#import "DetailViewController.h"
#import "TDSemiModalViewController.h"
#import "TDSemiModalViewController2.h"
#import "FooterViewController.h"
#import <UIKit/UIKit.h>
#import "CSAnimationView.h"
@interface MasterViewController : UITableViewController{
    id delegate;
    NSMutableArray *nameArray;
  IBOutlet UIView *footerview2;
    IBOutlet UIButton *addButton;
}
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet CSAnimationView *listView;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSDate *date;
@property ( nonatomic) BOOL dateOwed;
@property (nonatomic) BOOL paused;
@property (strong, nonatomic) IBOutlet UIView *flipView;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) TDSemiModalViewController *tdModal;
@property (strong, nonatomic) TDSemiModalViewController2 *tdModal2;
@property (strong, nonatomic) FooterViewController *footer;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)IBOutlet UIView *footerview;


@end
