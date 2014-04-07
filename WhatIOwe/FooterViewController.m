//
//  FooterViewController.m
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "FooterViewController.h"
#import "MasterViewController.h"
#import "TDSemiModalViewController2.h"
#import "TDSemiModal.h"
#import <QuartzCore/QuartzCore.h>
@interface FooterViewController ()
@property (strong, nonatomic) MasterViewController *Mvc;
@end

@implementation FooterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
static int amountToMove = 10;
-(void)moveBack{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    NSLog(@"%f", self.view.frame.origin.y);
    
    NSLog(@"I tried moving back!");
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y + amountToMove);
    [UIView commitAnimations];
} // or whatever you want, make sure to declare it somewhere outside of the scope of a method.  I generally declare mine at the top of the file.
-(IBAction)addPerson:(id)sender{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    NSLog(@"%f", self.view.frame.origin.y);
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - amountToMove);
    [UIView commitAnimations];
    
    self.tdModal2 = [[TDSemiModalViewController2 alloc]init];
    
    
    //    [self.view addSubview:test.view];
    
    [self presentSemiModalViewController2:self.tdModal2];
    
}


- (void)viewDidLoad
{
    
        self.view.frame = CGRectMake(0,35,320,400);
    [super viewDidLoad];
    MasterViewController *testTrans = [[MasterViewController alloc]init];
     self.originalCenter = testTrans.view.center;
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 1;
    button.layer.borderColor = button.backgroundColor.CGColor;
    button.titleLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
