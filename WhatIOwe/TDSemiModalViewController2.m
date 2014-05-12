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
#import "FooterViewController.h"
@implementation TDSemiModalViewController2
   
@synthesize coverView, delegate;

-(void)viewDidLoad {
    
    
    [super viewDidLoad];
    
   
    
    NSURL* musicFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"pop"
                                                ofType:@"aif"]];
    self.card = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile2 error:nil];
    [self.card prepareToPlay];

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

    FooterViewController *FVC = [[FooterViewController alloc]init];
       self.footer.view = FVC.view;
   // self.footer.view.frame = CGRectMake(0,35,320,400);
  //  [self.footer moveBack];
  
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.delegate moveBack];
                              [self dismissSemiModalViewController:self];
                         
                         
                          
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];



    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)NotOwed:(id)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    self.tdModal = (InputViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VDI"];
 
     [self.tdModal setDetailItem:@"NotOwed"];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                                  [self presentViewController:self.tdModal animated:YES completion:nil];
                         [self.delegate moveBack];
                    [self dismissSemiModalViewController:self];
                   
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                  
                     }];
    // do any setup you need for myNewVC


    
}

-(IBAction)Owed:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    self.tdModal = (InputViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VDI"];
    
    [self.tdModal setDetailItem:@"Owed"];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                           [self presentViewController:self.tdModal animated:YES completion:nil];
                         [self.delegate moveBack];
                         [self dismissSemiModalViewController:self];
                       
                         
                     }
                     completion:^(BOOL finished){
                  
                     }];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	self.coverView = nil;
}


@end
