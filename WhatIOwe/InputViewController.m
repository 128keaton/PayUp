//
//  InputViewController.m
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "InputViewController.h"
#import "OweInfo.h"
#import "OweDetails.h"
#import "MasterViewController.h"
#import "UIViewController+TDSemiModalExtension.h"

@interface InputViewController ()

@end

@implementation InputViewController
@synthesize detailItem = _detailItem;
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
        
       NSLog(@"THIS: %@", _detailItem);
        [self configureView];
        
         }

}
-(IBAction)cancel:(id)sender{
    
    
}

- (IBAction)unwindToRed:(id)sender{
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.superview cache:YES];
    [UIView commitAnimations];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view.superview removeFromSuperview];
    
 
    
}


- (void)textFieldChanged:(UITextField *)textField
{
    if (textField.text.length == 0) {
   
        theButton.enabled = false;
        
    }else {
        
        theButton.enabled = true;
    }
}




- (void)viewDidLoad
{
    [oField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [iField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    iField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
     oField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
     dueField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    iField.textColor = [UIColor whiteColor];
      oField.textColor = [UIColor whiteColor];
      dueField.textColor = [UIColor whiteColor];
    [super viewDidLoad];
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    UIView *fixItView = [[UIView alloc] init];
    fixItView.frame = CGRectMake(0, 0, 320, 20);
    fixItView.backgroundColor = [UIColor blackColor]; //change this to match your navigation bar
    [self.view addSubview:fixItView];
    
    // Do any additional setup after loading the view.
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    dueField.inputView = picker;
    [picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];

    cell1.layer.cornerRadius = 2;
    cell1.layer.borderWidth = 1;
    cell1.layer.borderColor = cell1.backgroundColor.CGColor;
    
    cell2.layer.cornerRadius = 2;
    cell2.layer.borderWidth = 1;
    cell2.layer.borderColor = cell2.backgroundColor.CGColor;

    cell3.layer.cornerRadius = 2;
    cell3.layer.borderWidth = 1;
    cell3.layer.borderColor = cell3.backgroundColor.CGColor;


    //take snapshot, then move off screen once complete


    
    
}
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        if ([[_detailItem description]  isEqual: @"Owed"]){
            
            iLabel.hidden = true;
            oLabel.hidden = true;
            mLabel.text = @"owes me the sum of";
            
        }else{
            iLabel.hidden = false;
            oLabel.hidden = false;
            
            mLabel.text = @"the sum of";
        }
    }
}
- (IBAction)submit:(id)sender
{
    
     UIDatePicker *picker = (UIDatePicker*)dueField.inputView;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        NSString *wow = [[NSString alloc]init];
    
    NSString *editedMoney = [[NSString alloc]init];
    [formatter setDateFormat:@"ddMMyyyy"];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    NSDate *dt = picker.date;
    NSString *dateAsString = [formatter stringFromDate:dt];
    dateOwed = YES;
    id delegate = [[MasterViewController alloc] init];
    self.managedObjectContext = [delegate managedObjectContext];
    if ([_detailItem  isEqual: @"Owed"]) {
                wow = @"someoneowes";
    editedMoney = [NSString stringWithFormat:@"+$%@", oField.text];
 
    }else{
       editedMoney = [NSString stringWithFormat:@"-$%@", oField.text];    wow=@"nope";

    }
      MasterViewController *topViewController = [[MasterViewController alloc]init];
    topViewController.managedObjectContext = self.managedObjectContext;

    NSLog(@"Nope Input: %@",wow);
    MasterViewController *master = [[MasterViewController alloc]init];
    bool OwedYes = dateOwed;
    [master setData:iField.text :editedMoney :picker.date :OwedYes :wow :dateAsString];
    NSManagedObjectContext *context = [self managedObjectContext];

    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.superview cache:YES];
    [UIView commitAnimations];
        [self dismissViewControllerAnimated:YES completion:nil];
    [self.view.superview removeFromSuperview];
    
    
    NSLog(@"TEH %@", context);
}



- (IBAction)changeSwitch:(id)sender{
    
    if([sender isOn]){
        dueLabel.text = @"which is due";
        dueField.enabled = YES;
        dateOwed = YES;
NSLog(dateOwed ? @"Yes" : @"No");
    } else{
        dueLabel.text = @"which can be repayed at any time.";
        dueField.enabled = NO;
        dateOwed = NO;
  NSLog(dateOwed ? @"Yes" : @"No");
    }
    
}
-(void)updateTextField:(id)sender
{
    
    
    UIDatePicker *picker = (UIDatePicker*)dueField.inputView;
    
    
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    
    [formatter setDateFormat:@"ddMMyyyy"];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    NSDate *dt = picker.date;
    NSString *dateAsString = [formatter stringFromDate:dt];

    
    NSLog(@"%@", dateAsString);

    

    

    
    
    dueField.text = [NSString stringWithFormat:@"%@",dateAsString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerView:(UIDatePicker*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    dueField.text = [NSString stringWithFormat:@"%@", pickerView.date];
    
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
