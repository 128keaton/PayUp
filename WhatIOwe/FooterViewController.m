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
-(IBAction)addPerson:(id)sender{
    self.tdModal2 = [[TDSemiModalViewController2 alloc]init];
    
    
    //    [self.view addSubview:test.view];
    [self presentSemiModalViewController2:self.tdModal2];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
