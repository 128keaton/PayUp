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
} // or whatever you want, make sure to declare it somewhere outside of the scope of a method.  I generally declare mine at the top of the file.
-(IBAction)addPerson:(id)sender{
 
        self.tdModal2 = [[TDSemiModalViewController2 alloc]init];
    self.tdModal2.delegate = self;
    
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




- (void)viewDidLoad
{
    
  
    self.test  = [[MasterViewController alloc]init];
    self.test.delegate = self;
    
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
