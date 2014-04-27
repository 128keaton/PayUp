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
-(BOOL)prefersStatusBarHidden
{
    return YES;
}



- (void)viewDidLoad
{
    
    
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    self.statusBarHidden = YES;
    
    
[self setNeedsStatusBarAppearanceUpdate];
 
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationSlide];
    

    [self configureView];
    self.navigationController.navigationBar.translucent = NO;
    id delegate = [[UIApplication sharedApplication] delegate]; self.managedObjectContext = [delegate managedObjectContext];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];
   

    
    UIBarButtonItem *doneItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed2:)];
    UIBarButtonItem *flexableItem2= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];

    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    
     [toolbar2 setItems:[NSArray arrayWithObjects:flexableItem2,doneItem2, nil]];
    
    
    [toolbar2 setBarTintColor:cell1.backgroundColor];
    [toolbar setBarTintColor:cell1.backgroundColor];

    //  _picker.tintColor = [UIColor whiteColor];
    
    doneItem2.tintColor = [UIColor whiteColor];
  
    doneItem.tintColor = [UIColor whiteColor];

    
    dueField.inputAccessoryView = toolbar2;
      oField.inputAccessoryView = toolbar;
    
    [oField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [iField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    iLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    oLabel.font =[UIFont fontWithName:@"ClearSans-Bold" size:12];
    mLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    dueLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    iField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
     oField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
     dueField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    iField.textColor = [UIColor whiteColor];
      oField.textColor = [UIColor whiteColor];
      dueField.textColor = [UIColor whiteColor];
    
    [super viewDidLoad];
  /*  id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];*/

    
    // Do any additional setup after loading the view.
  //  UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 120.0)];
    _picker = [[UIDatePicker alloc]init];

    _picker.datePickerMode = UIDatePickerModeDate;
      dueField.inputView = _picker;
    [_picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
  _picker.backgroundColor = [UIColor whiteColor];
    cell1.layer.cornerRadius = 2;
    cell1.layer.borderWidth = 1;
    cell1.layer.borderColor = cell1.backgroundColor.CGColor;
    
    cell2.layer.cornerRadius = 2;
    cell2.layer.borderWidth = 1;
    cell2.layer.borderColor = cell2.backgroundColor.CGColor;

    cell3.layer.cornerRadius = 2;
    cell3.layer.borderWidth = 1;
    cell3.layer.borderColor = cell3.backgroundColor.CGColor;

    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    //take snapshot, then move off screen once complete


    
    
}
-(IBAction)addAlarm:(UIButton*)sender{


    
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut
     
                     animations:^{
                     
                         sender.alpha = 0;
                         dueLabel.alpha = 1;
                         dueField.alpha = 1;
                         
                         
                         yes = NO;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    [dueField becomeFirstResponder];
}
-(IBAction)textFieldDidChange:(UITextField*)sender{
    NSString *s = oField.text;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSString *newS = [NSString stringWithFormat:@"$%@", s];
    oField.text = newS;

    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
     _picker.frame = CGRectMake(0, 50, 300, 162);
}

- (void)configureView
{

  yes = YES;



    
    
    
    [oField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Update the user interface for the detail item.
    self.view.superview.bounds = CGRectMake(0, 0, 350, 250);
    if (self.detailItem) {
        if ([[_detailItem description]  isEqual: @"Owed"]){
            
            iLabel.hidden = true;
            oLabel.hidden = true;
            iField.center = CGPointMake(iField.center.x, iField.center.y -3);
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
    
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
     UIDatePicker *picker = (UIDatePicker*)dueField.inputView;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        NSString *wow = [[NSString alloc]init];
    
    NSString *editedMoney = [[NSString alloc]init];
    [formatter setDateFormat:@"MM/dd"];
  //  [formatter setDateStyle:NSDateFormatterFullStyle];
    NSDate *dt = picker.date;
    NSString *dateAsString = [formatter stringFromDate:dt];
    


    
    NSLog(@"DATE STRING 2: %@", dateAsString);
    NSString *s = oField.text;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
   
    

  
    if ([_detailItem  isEqual: @"Owed"]) {
                wow = @"someoneowes";
    editedMoney = [NSString stringWithFormat:@"$%@", s];
 
    }else{
       editedMoney = [NSString stringWithFormat:@"$%@", s];
        wow=@"nope";

    }
    

    NSLog(@"Nope Input: %@",wow);



    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *details = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"OweDetails"
                                       inManagedObjectContext:context];
    [details setValue:editedMoney  forKey:@"money"];
    [details setValue:picker.date forKey:@"date"];

    NSManagedObject *info = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"OweInfo"
                                          inManagedObjectContext:context];
   if (yes == YES) {
        dateAsString = @"";
        
   }else{
       
       NSDate *alertTime = dt;
       UIApplication* app = [UIApplication sharedApplication];
       UILocalNotification* notifyAlarm = [[UILocalNotification alloc]init];
       if (notifyAlarm) {
           notifyAlarm.fireDate = alertTime;
           notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
           notifyAlarm.repeatInterval = 0;
           //notifyAlarm.soundName = @"dingping.mp3";
           
           if ([wow isEqualToString:@"someoneowes"]) {
               notifyAlarm.alertBody = [NSString stringWithFormat:@"%@ owes you %@ today", iField.text, editedMoney];
           }else{
                notifyAlarm.alertBody = [NSString stringWithFormat:@"You owe %@ %@ today", iField.text, editedMoney];
           }
           [app scheduleLocalNotification:notifyAlarm];

    
       }
   }
    
    
    [info setValue:dateAsString forKey:@"dateString"];
    [info setValue:iField.text forKey:@"name"];
    [info setValue:wow forKey:@"whooweswhat"];
    [info setValue:[NSNumber numberWithInt:1] forKey:@"dateowed"];
    [details setValue:info forKey:@"info"];
    [info setValue: details forKey:@"details"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
 
   
    


    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
     
                     animations:^{
                        self.view.frame = CGRectMake(0, -358, self.view.frame.size.width, self.view.frame.size.height);

                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];

        [self dismissViewControllerAnimated:YES completion:nil];
    [self.view.superview removeFromSuperview];
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == iField) {
        [textField resignFirstResponder];
        [oField becomeFirstResponder];
    } else if (textField == oField) {
        [oField resignFirstResponder];

    } else if (textField == dueField){
        [self performSelector:@selector(submit:) withObject:nil];
    }
    return YES;
}
- (void)doneButtonDidPressed:(id)sender {
    NSLog(@"Sender: %@", sender);
    if (sender == dueField) {
            [dueField resignFirstResponder];
           [self performSelector:@selector(submit:) withObject:nil];
    }else{
        
        [oField resignFirstResponder];
        
    }
 
}


- (void)doneButtonDidPressed2:(id)sender {
    NSLog(@"Sender: %@", sender);
 
        [dueField resignFirstResponder];
        [self performSelector:@selector(submit:) withObject:nil];
   
        
    
    
}

+ (CGFloat)toolbarHeight {
    // This method will handle the case that the height of toolbar may change in future iOS.
    return 44.f;
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
