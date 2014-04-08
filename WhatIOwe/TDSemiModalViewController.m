//
//  TDSemiModalViewController.m
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//
#import "AppDelegate.h"
#import "TDSemiModalViewController.h"
#import "MasterViewController.h"
#import "UIViewController+TDSemiModalExtension.h"
#import "OweInfo.h"
#import "OweDetails.h"
@implementation TDSemiModalViewController
@synthesize coverView;



- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.name.text = [self.detailItem description];
    }
}


-(IBAction)cancel:(id)sender{

    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];

    
    NSLog(@"Sent!");
 //   [self dismissViewControllerAnimated:YES completion:nil];
//    [self.view.superview removeFromSuperview];
   
    
   
    NSString *s = oField.text;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSLog(@"%@", s);
    if ([s  isEqual: @"9001"]){
        s = @"ITS OVER 9000";
        [self.info.details setValue:s forKey:@"money"];

    }else{
        [self.info.details setValue:[NSString stringWithFormat:@"$%@", s] forKey:@"money"];

    }
    
    NSManagedObjectContext *context = [self managedObjectContext];

    [self.info setValue:iField.text forKey:@"name"];
            NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }


  

    
   

  
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                             [oField resignFirstResponder];
                                               [self dismissSemiModalViewController:self];
                       
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    
    
    
    
}



-(void)viewDidLoad {
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    iLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    oLabel.font =[UIFont fontWithName:@"ClearSans-Bold" size:12];
    mLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
 
    iField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    oField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    dueField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    iField.textColor = [UIColor whiteColor];
    oField.textColor = [UIColor whiteColor];
    dueField.textColor = [UIColor whiteColor];
    [super viewDidLoad];

    
    iField.text = self.info.name;
    oField.text = self.info.details.money;
    dueField.text = self.info.dateString;
    NSLog(details.money);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    [button addTarget:self
               action:@selector(cancel:)
     forControlEvents:UIControlEventTouchUpInside];
    

    
	self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
button.frame = coverView.frame;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	coverView.backgroundColor = UIColor.blackColor;
   [self.coverView addSubview:button];
	self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (self.detailItem) {
        self.navBar.title = [self.detailItem description];
        self.name.text = [self.detailItem description];
     
    }
    
    
   view1.layer.cornerRadius = 2;
   view1.layer.borderWidth = 1;
   view1.layer.borderColor = view1.backgroundColor.CGColor;
    view2.layer.cornerRadius = 2;
    view2.layer.borderWidth = 1;
    view2.layer.borderColor = view2.backgroundColor.CGColor;
    
    view3.layer.cornerRadius = 2;
    view3.layer.borderWidth = 1;
    view3.layer.borderColor = view2.backgroundColor.CGColor;
    
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
