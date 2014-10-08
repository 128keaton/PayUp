//
//  WIOMasterViewController.h
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//
#import "DetailViewController.h"

#import "FooterViewController.h"
#import <UIKit/UIKit.h>
#import "LCZoomTransition.h"
#import <AVFoundation/AVFoundation.h>
#import "OweTableViewCell.h"
#import "EditViewController.h"
#import "SelectionViewController.h"
#import "WYPopoverController.h"
#import "IBActionSheet.h"
@class EditViewController;
@interface MasterViewController : UITableViewController <WYPopoverControllerDelegate, IBActionSheetDelegate>{
    id delegate;
    NSMutableArray *nameArray;
  IBOutlet UIView *footerview2;
    IBOutlet UIButton *addButton;
    BOOL flipped;
    int tableViewSize;
    NSIndexPath *globalIndex;
    int currentSelection;
    	NSMutableDictionary *selectedIndexes;
    NSMutableDictionary *selectedIndexes2;
    IBOutlet UIBarButtonItem *settingsButton;
  
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *titleSegmentedControl;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSDate *date;
@property ( nonatomic) BOOL dateOwed;
@property (strong, nonatomic) AVAudioPlayer *tap;
@property (strong, nonatomic) AVAudioPlayer *delete;
@property (nonatomic) BOOL paused;
@property (nonatomic, strong) LCZoomTransition *zoomTransition;
@property (strong, nonatomic) IBOutlet UIView *flipView;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(strong, nonatomic) OweTableViewCell *viewCell;
@property (strong, nonatomic) FooterViewController *footer;
@property (nonatomic, strong) EditViewController *editView;
@property (strong, nonatomic) IBActionSheet *addPerson;
@property (strong, nonatomic) InputViewController *inputViewController;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *plusButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)IBOutlet UIView *footerview;
- (void)handleOpenURL:(NSURL *)url;
@property (strong, nonatomic) id owedItem;
- (void)setOwedItem:(id)owedItem;
-(void)openInput;
@property(strong, nonatomic) NSString *publicName;
@property (strong, nonatomic) NSMutableArray *widgetArray;

@end
