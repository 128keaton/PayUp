//
//  DetailViewController.h
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController{
    IBOutlet UILabel *money;
    IBOutlet UILabel *name;
    IBOutlet UILabel *date;
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id moneyItem;
@property (strong, nonatomic) id dateItem;
@property (nonatomic, strong) UIView *coverView;
- (void)setDetailItem:(id)newDetailItem;
- (void)setDateItem:(id)newDateItem;
- (void)setMoneyItem:(id)newMoneyItem;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@end
