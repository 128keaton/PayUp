//
//  DetailViewController.m
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize coverView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        name.text = newDetailItem;
        
        
    }
    
}
- (void)setDateItem:(id)newDateItem
{
    if (_dateItem != newDateItem) {
        _dateItem = newDateItem;
        
        date.text = newDateItem;
        
    }
 
}
- (void)setMoneyItem:(id)newMoneyItem
{
    if (_moneyItem != newMoneyItem) {
        _moneyItem = newMoneyItem;
        
        
        
    }
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSString *myString = [_moneyItem stringValue];
    money.text =  [NSString stringWithFormat:@"$%@", myString];
    date.text = _dateItem;
    name.text = _detailItem;
    
    
    self.title = _detailItem;
    
    
    self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	coverView.backgroundColor = UIColor.blackColor;
	self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
