//
//  InputViewController.h
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MasterViewController;

@interface InputViewController : UIViewController{
    IBOutlet UILabel *dueLabel;
    IBOutlet UIDatePicker *dueDate;
    IBOutlet UILabel *iLabel;
    IBOutlet UITextField *dueField;
    IBOutlet UILabel *oLabel;
    IBOutlet UITextField *oField;
    IBOutlet UITextField *iField;
    IBOutlet UILabel *mLabel;
    IBOutlet UIBarButtonItem *theButton;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIView *cell1;
    IBOutlet UIView *cell2;
    IBOutlet UIView *cell3;
BOOL shouldHideStatusBar;

   bool dateOwed;
}

@property (strong, nonatomic) id detailItem;
- (void)setDetailItem:(id)newDetailItem;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
@protocol InputViewControllerDelegate <NSObject>
- (void)InputViewControllerDidCancel:(InputViewController*)controller;
@property (strong,nonatomic) MasterViewController *masterView;

@end