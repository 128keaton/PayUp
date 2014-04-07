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

@interface MasterViewController : UITableViewController
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSDate *date;
@property ( nonatomic) BOOL dateOwed;
@property (strong, nonatomic) IBOutlet UIView *flipView;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) TDSemiModalViewController *tdModal;
@property (strong, nonatomic) TDSemiModalViewController2 *tdModal2;
@property (strong, nonatomic) FooterViewController *footer;
-(void)setData:(NSString *)name :(NSString *)money :(NSDate *)date :(BOOL)dateOwed :(NSString *)whooweswhat :(NSString *) dateString;
-(void)dismissSemiMD;
-(void)addSemi;
-(void)presentInput;
@end
