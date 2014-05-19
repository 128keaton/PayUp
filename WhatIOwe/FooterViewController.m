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
#import "SBJson4.h"
#import <AVFoundation/AVFoundation.h>

@interface FooterViewController ()
@property (strong, nonatomic) MasterViewController *Mvc;
@end

@implementation FooterViewController
@synthesize footercontroller = _footer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.test  = [[MasterViewController alloc]init];
    self.test.delegate = self;
    
    
    UIDynamicItemBehavior *elasticityBehavior =
    [[UIDynamicItemBehavior alloc] initWithItems:@[self.view]];
    elasticityBehavior.elasticity = 0.7f;
    [self.animator addBehavior:elasticityBehavior];
}



-(void)moveBack{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    NSLog(@"%f", self.view.frame.origin.y);
    
    NSLog(@"I tried moving back!");
    [UIView animateWithDuration: 0.25 animations: ^(void) {
        self.view.transform = CGAffineTransformIdentity;
    }];
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [name resignFirstResponder];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:name.text forKey:@"name"];
    [defaults synchronize];
    return YES;
}

-(IBAction)addPerson:(id)sender{
    [name resignFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:name.text forKey:@"name"];
    [defaults synchronize];
    
        self.tdModal2 = [[TDSemiModalViewController2 alloc]init];
    self.tdModal2.delegate = self;
    [self.pop play];
    
    [UIView animateWithDuration:0.5
     
                          delay:0
                        usingSpringWithDamping:0.8
                        initialSpringVelocity:1.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                           [self presentSemiModalViewController2:self.tdModal2];
                           self.view.transform = CGAffineTransformMakeTranslation(0, -150);
                         
                                         
                         
        
                         
           
                     

                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    

 
    
    
}



-(IBAction)actionButtonItemTapped:(id)sender
{
    NSURL *myURL = [NSURL URLWithString:@"io://hello?10#200806231300"];
    [[UIApplication sharedApplication] openURL:myURL];
}

- (void)viewDidLoad
{
    
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"slow"
                                               ofType:@"aif"]];
    self.pop = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    [self.pop prepareToPlay];
    
    
    NSURL* musicFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"pop"
                                                ofType:@"aif"]];
    self.card = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile2 error:nil];
    [self.card prepareToPlay];
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"name"];
    
    if (![firstName isEqual:@""]) {
        name.text = firstName;
    }
   
    
 //   self.test  = [[MasterViewController alloc]init];
  //  self.test.delegate = self;
    
       // self.view.frame = CGRectMake(0,0,320,200);
    [super viewDidLoad];
  //  MasterViewController *testTrans = [[MasterViewController alloc]init];
   //  self.originalCenter = testTrans.view.center;
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 1;
    button.layer.borderColor = button.backgroundColor.CGColor;
    button.titleLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    
    
    iLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    
  
    name.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
       name.textColor = [UIColor whiteColor];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
