//
//  TDSemiModalViewController.m
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "TDSemiModalViewController2.h"
#import "InputViewController.h"
#import "MasterViewController.h"
#import "UIViewController+TDSemiModalExtension.h"
@implementation TDSemiModalViewController2
@synthesize coverView;

-(void)viewDidLoad {
    [super viewDidLoad];
	self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];

	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	coverView.backgroundColor = UIColor.blackColor;
	self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(cancel:)
     forControlEvents:UIControlEventTouchUpInside];
  
    button.frame = coverView.frame;
    [self.coverView addSubview:button];
    
    
    button1.layer.cornerRadius = 2;
    button1.layer.borderWidth = 1;
    button1.layer.borderColor = button1.backgroundColor.CGColor;
    button2.layer.cornerRadius = 2;
    button2.layer.borderWidth = 1;
    button2.layer.borderColor = button2.backgroundColor.CGColor;
   button2.titleLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
       button1.titleLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];

}

#pragma mark -
#pragma mark Memory Management
-(IBAction)cancel:(id)sender{
     [self dismissSemiModalViewController:self];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)NotOwed:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    self.tdModal = (InputViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VDI"];
    [self presentViewController:self.tdModal animated:YES completion:nil];
     [self.tdModal setDetailItem:@"NotOwed"];
    
    // do any setup you need for myNewVC
    [self dismissSemiModalViewController:self];

    
}

-(IBAction)Owed:(id)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    self.tdModal = (InputViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VDI"];
    [self presentViewController:self.tdModal animated:YES completion:nil];
    [self.tdModal setDetailItem:@"Owed"];
    
    // do any setup you need for myNewVC
    [self dismissSemiModalViewController:self];

}


- (void)viewDidUnload {
    [super viewDidUnload];
	self.coverView = nil;
}


@end
