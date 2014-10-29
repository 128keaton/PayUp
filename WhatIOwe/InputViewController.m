//
//  InputViewController.m
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@import AddressBook;
#import "InputViewController.h"
#import "OweInfo.h"
#import "OweDetails.h"
#import "MasterViewController.h"
#import "WYPopoverController.h"
#import "WYStoryboardPopoverSegue.h"

@interface InputViewController () <ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate>

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
        
       NSLog(@"Detail Item: %@", _detailItem);
        [self configureView];
        
         }

}
-(IBAction)cancel:(id)sender{
    
    
}

- (IBAction)unwindToRed:(id)sender{
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
       [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

    
 
    
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
    
   
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica Neue" size:12], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    self.statusBarHidden = YES;
  /*  oField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.1)) {
        oField.keyboardType = UIKeyboardTypeDecimalPad;
    }*/
      
[self setNeedsStatusBarAppearanceUpdate];
 
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationSlide];
    

    [self configureView];
    self.navigationController.navigationBar.translucent = NO;
    id delegate = [[UIApplication sharedApplication] delegate]; self.managedObjectContext = [delegate managedObjectContext];
    
    UIBarButtonItem *doneItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];
   

    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(moveFromMoneyToWhat:)];
    UIBarButtonItem *flexableItem2= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];

    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    
     [toolbar2 setItems:[NSArray arrayWithObjects:flexableItem2,doneItem2, nil]];
    
    
    [toolbar2 setBarTintColor:[UIColor colorWithRed:0.9333 green:0.3647 blue:0.3843 alpha:1.0]];
    [toolbar setBarTintColor:[UIColor colorWithRed:0.2275 green:0.8549 blue:0.6078 alpha:1.0]];
    //  _picker.tintColor = [UIColor whiteColor];
    
    doneItem2.tintColor = [UIColor whiteColor];
  
    doneItem.tintColor = [UIColor whiteColor];

    
    dueField.inputAccessoryView = toolbar2;
      oField.inputAccessoryView = toolbar;
    

    
    [super viewDidLoad];
  /*  id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];*/

    
    // Do any additional setup after loading the view.
  //  UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 120.0)];
    _picker = [[UIDatePicker alloc]init];

    _picker.datePickerMode = UIDatePickerModeDateAndTime;
     // dueField.inputView = _picker;
    [_picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [iField addTarget:self action:@selector(updateButtonState:) forControlEvents:UIControlEventEditingChanged];
        [oField addTarget:self action:@selector(updateButtonState:) forControlEvents:UIControlEventEditingChanged];
        [wField addTarget:self action:@selector(updateButtonState:) forControlEvents:UIControlEventEditingChanged];
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
    NSLog(@"changed!");
    
   
    
}

-(IBAction)updateButtonState:(UITextField*)sender{
 
    if (iField.text.length != 0) {
        if (oField.text.length != 0) {
            if (wField.text.length != 0) {
                theButton.enabled = YES;
            }
        }
    }
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
   //  _picker.frame = CGRectMake(0, 0, 300, 0);
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
        
            
        }else if([[_detailItem description] isEqual: @"NotOwed"]){
            iLabel.hidden = false;
            oLabel.hidden = false;
            NSLog(@"not owed");
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *datePickerDate = [defaults objectForKey:@"pickerDate"];
    
    NSString *dateAsString = [formatter stringFromDate:datePickerDate];
    
    

    
    NSLog(@"DATE STRING 2: %@", dateAsString);
    NSString *s = oField.text;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
   
    

  
    if ([_detailItem  isEqual: @"Owed"]) {
                wow = @"someoneowes";
    editedMoney = [NSString stringWithFormat:@"$%@", s];
 
    }else if([_detailItem isEqual:@"NotOwed"]){
       editedMoney = [NSString stringWithFormat:@"$%@", s];
        wow=@"nope";

    }
    

    NSLog(@"Nope Input: %@",wow);


    
  
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *details = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"OweDetails"
                                       inManagedObjectContext:context];
    [details setValue:editedMoney  forKey:@"money"];
  
    [details setValue:imageData forKey:@"image"];

    NSManagedObject *info = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"OweInfo"
                                          inManagedObjectContext:context];
   // self.info = info;
    
 if(tapped == YES){
       NSLog(@"Registering for notification");
     
      // NSDate *alertTime = picker.date;
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
       formatter.timeZone = [NSTimeZone localTimeZone];
 
       NSLog(@"Picker Date: %@", [datePickerDate descriptionWithLocale:[NSLocale currentLocale]]);
       UILocalNotification *localNotification = [[UILocalNotification alloc] init];
       NSDate *fireDate = picker.date;
       localNotification.fireDate = fireDate;
       NSString *uid =[[self class]generateRandomString:5];
       NSLog(@"Edit UUID: %@", uid);
       [info setValue:uid forKey:@"uid"];
     self.info.dateString = dateAsString;
     [details setValue:datePickerDate forKey:@"date"];
           localNotification.timeZone = [NSTimeZone defaultTimeZone];
       localNotification.soundName = UILocalNotificationDefaultSoundName;

       
           if ([wow isEqualToString:@"someoneowes"]) {
               localNotification.alertBody = [NSString stringWithFormat:@"%@ owes you %@ today", iField.text, editedMoney];
           }else{
               localNotification.alertBody = [NSString stringWithFormat:@"You owe %@ %@ today", iField.text, editedMoney];
               [details setValue:iField.text forKey:@"alert"];
           }
       [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];



    
       
   }
    
   
    
    NSString *firstName = [defaults objectForKey:@"name"];
    
    if (![firstName isEqual:@""]) {
 [details setValue:firstName forKey:@"name"];
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
    
    [info setValue:@"NotShared" forKey:@"shared"];
    [defaults setObject:iField.text forKey:@"firstName"];
      [info setValue:wField.text forKey:@"forwhat"];

    [wField resignFirstResponder];

    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
     [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];//    [self.view.superview removeFromSuperview];
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

+(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}
-(IBAction)moveFromMoneyToWhat:(id)sender{
    [wField becomeFirstResponder];
   // [theButton setEnabled:YES];
    //[oField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == iField) {
        [textField resignFirstResponder];
        [oField becomeFirstResponder];
    } else if (textField == oField) {
        [oField resignFirstResponder];
          [wField becomeFirstResponder];
    } else if (textField == wField){
          [wField resignFirstResponder];
        [theButton setEnabled:YES];
        //[oField becomeFirstResponder];
    }  else if (textField == dueField){
        NSLog(@"dueField");
               [theButton setEnabled:YES];
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


/*-(void)updateTextField:(id)sender
{
    
    
    UIDatePicker *picker = (UIDatePicker*)dueField.inputView;
    
    
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    
    [formatter setDateFormat:@"ddMMyyyy"];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    NSDate *dt = picker.date;
    NSString *dateAsString = [formatter stringFromDate:dt];

    
    NSLog(@"%@", dateAsString);

    

    

    
    
    dueField.text = [NSString stringWithFormat:@"%@",dateAsString];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerView:(UIDatePicker*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    dueField.text = [NSString stringWithFormat:@"%@", pickerView.date];
    
}

- (IBAction)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    _peoplePicker = picker;
    _peoplePicker.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:_peoplePicker animated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person{
    
    NSLog(@"last name:%@", (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty));
 //   NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if ((__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty) != Nil) {
        NSString* fullName = [NSString stringWithFormat:@"%@ %@", (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty), (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty)];
        iField.text = fullName;

    }else{
      
        iField.text = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);

    }
    
    
    
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *details = [NSEntityDescription
                                insertNewObjectForEntityForName:@"OweDetails"
                                inManagedObjectContext:context];
    NSData *contactImageData;

    
    if (ABPersonHasImageData(person)) {
        imageData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
     
        
        
        contactImageData = imageData;
        
        hasImage = YES;
         [details setValue:contactImageData forKey:@"image"];
        NSError *error;
        [self.managedObjectContext save:&error];
          NSLog(@"%@", error);
    }else{
    
        imageData= UIImagePNGRepresentation([UIImage imageNamed:@"user.png"]);
         [details setValue:contactImageData forKey:@"image"];
        NSError *error;
           contactImageData = imageData;
        [self.managedObjectContext save:&error];
        NSLog(@"%@", error);
        
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    

}



-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            if (obj != dueField) {
                
                if(![obj isEqualToString:@""]){
                    theButton.enabled = YES;
                }
                
            }
        }
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToEdit"])
    {
        
        
        NSLog(@"Going back home");
    }else if ([segue.identifier isEqual:@"pushToDate"]){
        datePicker  = [[DatePickerViewController alloc]init];
        WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
        popoverController = [popoverSegue popoverControllerWithSender:sender
                                             permittedArrowDirections:WYPopoverArrowDirectionDown
                                                             animated:YES
                                                              options:WYPopoverAnimationOptionFadeWithScale];
        popoverController.delegate = self;
        DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
        //   datePickerVC.picker.date = self.info.details.date;
        popoverController.popoverContentSize = CGSizeMake(349, 280);
  
            datePickerVC.date = [NSDate date];
            
    
        
    }
}

-(void)updateTextField:(NSDate *)pickerDate;

{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    
    
 
    
    
    [self.info.details setValue:pickerDate forKey:@"date"];
    
    
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    
    
    
    [formatter setDateFormat:@"ddMMyyyy"];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    NSDate *dt = pickerDate;
    
    NSString *dateAsString = [formatter stringFromDate:dt];
    
    
    
    self.info.details.date = pickerDate;
    self.info.dateString = dateAsString;
    
    NSLog(@"Date Updated: %@", dateAsString);
    
    
    NSError *error;
    
    
    
    
    if (![context save:&error]) {
        
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    
    
    
    
    

    [UIView animateWithDuration:0.1f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         [dueField setAlpha:1];
                         [dueLabel setAlpha:1];
                         [addDate setAlpha:0];
                         tapped = YES;
                             dueField.text = [NSString stringWithFormat:@"%@",dateAsString];
                        
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    
    
    
    
}





- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    NSLog(@"popdown");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self updateTextField:[defaults objectForKey:@"pickerDate"]];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == dueField){
        dueField.inputView = nil;
        [self performSegueWithIdentifier:@"pushToDate" sender:addDate];
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == dueField) {
             [self performSegueWithIdentifier:@"pushToDate" sender:addDate];
        return NO;
    }
    return YES;
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
