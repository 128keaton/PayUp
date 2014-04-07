//
//  TDSemiModalViewController.m
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "TDSemiModalViewController.h"
#import "MasterViewController.h"
#import "UIViewController+TDSemiModalExtension.h"
@implementation TDSemiModalViewController
@synthesize coverView;
@synthesize name;
@synthesize navBar;
@synthesize stepper;
@synthesize delegate;
@synthesize money;
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self configureView];
             
        
    }
    
}


- (void)setMoneyItem:(NSString*)newMoneyItem
{

    _moneyItem = newMoneyItem;
    
        [self configureView];
    
        
        
        
}
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.name.text = [self.detailItem description];
    }
}

- (IBAction)valueChanged:(UIStepper *)sender {
    double value = [sender value];
    
    [self.money setText:[NSString stringWithFormat:@"%d", (int)value]];
}


-(void)viewDidLoad {
    [super viewDidLoad];
    

	self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];

	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	coverView.backgroundColor = UIColor.blackColor;
  
	self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (self.detailItem) {
        self.navBar.title = [self.detailItem description];
        self.name.text = [self.detailItem description];
       [self.money setText:[NSString stringWithFormat:@"%@", self.moneyItem]];
        double xD = [self.moneyItem doubleValue];
        self.stepper.value = xD;
    }

}

-(IBAction)exitModally:(id)sender{
    
    NSLog(@"Tried to exit :(");
    MasterViewController *theMaster = [[MasterViewController alloc]init];

	[self dismissSemiModalViewController:self];
    
        UITableView *tableView = theMaster.tableView;
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];

    

}


-(CGPoint) offscreenCenter {
    CGPoint offScreenCenter = CGPointZero;
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
	if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		offScreenCenter = CGPointMake(offSize.height / 2.0, offSize.width * 1.5);
	} else {
		offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
	}
    
    return offScreenCenter;
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.coverView = nil;
    self.view = nil;
}


@end
