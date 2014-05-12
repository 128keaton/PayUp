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

#import <AVFoundation/AVFoundation.h>

#import "CSAnimationView.h"

#import "PaymentViewController.h"

@implementation TDSemiModalViewController







@synthesize coverView, info, navBar, name, details = _details, managedObjectContext = _managedObjectContext;

















- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == iField) {
        
        [textField resignFirstResponder];
        
        [oField becomeFirstResponder];
        
    } else if (textField == oField) {
        
        [oField resignFirstResponder];
        
        
        
    } else if (textField == dueField){
        
        [self performSelector:@selector(cancel:) withObject:nil];
        
    }
    
    return YES;
    
}





- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    
    [UIView animateWithDuration:0.6
     
                          delay:0.0
     
                        options:UIViewAnimationOptionCurveEaseInOut
     
                     animations:^ {
                         
                         UIView* rootView = self.view;
                         
                         CGRect frame = rootView.frame;
                         
                         CGPoint oldOrigin = frame.origin;
                         
                         CGPoint newOrigin = CGPointMake(0, 100);
                         
                         frame.origin = newOrigin;
                         
                         [self dismissViewControllerAnimated:YES completion:nil];
                         
                         frame.size = CGSizeMake( frame.size.width - (newOrigin.x - oldOrigin.x), 284 );
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         rootView.frame = frame;
                         
                         
                         
                         
                         
                         
                         
                     }
     
                     completion:^(BOOL finished) {
                         
                     }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



- (IBAction)openMailComposer:(id)sender

{
    
    if (![MFMailComposeViewController canSendMail]) {
        
        return;
        
    }
    
    
    
    
    // Remove the mail view
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
  //  self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
    

    
    
    
    
    
    
    
    
    
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    
    
    
    
    
    [controller setSubject:@"You owe me"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // [dateFormatter setDateFormat:@"MMM dd, yyyy, hh:mm a"];
    
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *strDate = [dateFormatter stringFromDate:self.info.details.date];
    
    NSLog(@"%@", strDate);
    
    
    
    
    
    
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [delegate managedObjectContext];
    
    
    
    
    
    
    
    
    
    
    
    NSString *bodyString = [NSString stringWithFormat:@"<a href=io://%@?%@#%@>Add to IO</a>", name2, moneystring, strDate];
    
    //     CGFloat alpha = self.coverView.alpha;
    
    
    
    // mailer.view.alpha = s0;
    
    NSString *emailBody = bodyString;
    
    [controller setMessageBody:emailBody isHTML:YES];
    
    
    
    
    
    [controller setMailComposeDelegate:self];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)PlayClip:(NSString *)soundName

{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
    
    AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    
    
    [theAudio play];
    
    
    
    
    
    
    
}



-(IBAction)payupsukka:(id)sender{
    
    
    
    PaymentViewController *pay = [[PaymentViewController alloc]init];
    
    
    
  
    
    [self presentViewController:pay animated:YES completion:nil];
    
    [self.delegate dismissSemiModalViewController:self];
    
    pay.view.bounds = [[UIScreen mainScreen]bounds];
    
}






- (IBAction)openMail:(id)sender

{
    
    
    

    
    
    
    
    if ([MFMailComposeViewController canSendMail])
        
    {
        
        
        
        MasterViewController *master2 = [[MasterViewController alloc]init];
        
        self.master = master2;
        
        self.master.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        NSString *bodyString = nil;
        
        mailer.mailComposeDelegate = self;
        
        if ([self.info.whooweswhat  isEqual: @"someoneowes"]) {
            
            [mailer setSubject:[NSString stringWithFormat:@"I Owe You %@", self.info.details.money]];
            
            bodyString = [NSString stringWithFormat:@"I owe you %@.", moneystring];
            
            
            
            
            
        }else{
            
            
            
            [mailer setSubject:[NSString stringWithFormat:@"You Owe Me %@", self.info.details.money]];
            
            bodyString = [NSString stringWithFormat:@"You owe me %@.", moneystring];
            
        }
        
        
        
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
      
        
        // Time format for the string value
        
        NSString *dateStr = [dateFormatter stringFromDate:self.info.details.date];
        
        
        
        if (tapped == YES){
            
            [dict setObject:self.picker.date forKey:@"date"];
            
            [dict setObject:self.info.dateString forKey:@"dateString"];
            
            NSLog(@"tapped");
            
        }else{
            
            NSLog(@"nottapped");
            
            [dict setObject:@"" forKey:@"dateString"];
            
            [dict setObject:self.picker.date forKey:@"date"];
            
            
            
        }
        
        
        
        
        
       
        
        [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
        
        
        
        
        
        
        
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        
        
        
        [formatter  setDateFormat:@"YYYYMMddHHmmss"];
        
        //[formatter setDateStyle:NSDateFormatterFullStyle];
        
        NSDate *dt = self.info.details.date;
        
        NSString *dateAsString = [formatter stringFromDate:dt];
        
        
        
        
        
        NSLog(@"DateAsString2: %@", dateAsString);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        NSString *strDate = dateAsString;
        
        NSLog(@"%@", strDate);
        
        
        
        
        [dict setObject:self.info.name forKey:@"name"];
        
        [dict setObject:self.info.whooweswhat forKey:@"whooweswhat"];
        
        [dict setObject:self.info.details.money forKey:@"money"];
        
        NSLog(@"Money: %@", self.info.details.money);
        
        
        
        
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        
        
        [mailer addAttachmentData:data mimeType:@"application/io" fileName:@"IO"];
        
        
        
        NSDate *startDateString = self.info.details.date;
        
        NSDateFormatter *dateStartFormatter = [[NSDateFormatter alloc] init];
        
        // [dateStartFormatter setDateFormat:@"dd MM yyyy"];
        
        
        
        
        id delegate = [[UIApplication sharedApplication] delegate];
        
        self.managedObjectContext = [delegate managedObjectContext];
        
        
        
        
        
        
        
        
        
        
        
        
        
        //     CGFloat alpha = self.coverView.alpha;
        
        [self.delegate moveBack];
        
     
        
        
        
        
        
        
        
               self.managedObjectContext = [delegate managedObjectContext];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        
        
        
        
        
        
        NSLog(@"STRDate: %@", strDate);
        
        
        
        
        
        
        
        
        // mailer.view.alpha = s0;
        
        NSString *emailBody = bodyString;
        
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [UIView animateWithDuration:1.0
         
                              delay:0.0
         
                            options:UIViewAnimationOptionCurveEaseInOut
         
                         animations:^ {
                             
                             self.master.view.transform = CGAffineTransformMakeTranslation(0, -150);
                             
                             
                             
                             [self presentViewController:mailer animated:YES completion:nil];
                             
                             
                             
                         }
         
                         completion:^(BOOL finished) {
                             
                         }];
        
        
        
        
        
        
        
        //  [self.view removeFromSuperview];
        
        
        
    }
    
    else
        
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                              
                                                        message:@"Your device doesn't support the composer sheet"
                              
                                                       delegate:nil
                              
                                              cancelButtonTitle:@"OK"
                              
                                              otherButtonTitles: nil];
        
        [alert show];
        
        
        
    }
    
    
    
}







-(IBAction)actionButtonItemTapped:(id)sender

{
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    NSString *strDate = [dateFormatter stringFromDate:self.info.details.date];
    
    NSLog(@"%@", strDate);
    
    
    
    
    
    
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"YYYYMMddHHmmss"];
    
    
    
    NSURL *myURL = [NSURL URLWithString:[NSString stringWithFormat:@"io://%@?%@#%@", name2, moneystring, strDate]];
    
    
    
    NSLog(@"Money new: %@",moneystring);
    
    [[UIApplication sharedApplication] openURL:myURL];
    
}





-(IBAction)textFieldDidChange:(UITextField*)sender{
    
    NSString *s = oField.text;
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    
    NSString *newS = [NSString stringWithFormat:@"$%@", s];
    
    oField.text = newS;
    
    
    
    
    
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    //  [formatter setDateStyle:NSDateFormatterFullStyle];
    
    NSDate *dt = self.picker.date;
    
    NSString *dateAsString = [formatter stringFromDate:dt];
    
    
    
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    
    [self.info setValue:iField.text forKey:@"name"];
    
    NSError *error;
    
    
    
    
    
    
    
    
    
    
    
    if (tapped == YES){
        
        [self.info.details setValue:self.picker.date forKey:@"date"];
        
        [self.info setValue:dateAsString forKey:@"dateString"];
        
        NSLog(@"tapped");
        
    }else{
        
        NSLog(@"nottapped");
        
        
        
    }
    
    if (![context save:&error]) {
        
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [UIView animateWithDuration:0.5
     
                          delay:1.0
     
                        options: UIViewAnimationOptionCurveEaseIn
     
                     animations:^{
                         
                         [oField resignFirstResponder];
                         
                         [self dismissSemiModalViewController:self];
                         
                         [self.delegate goBack];
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         NSLog(@"Done!");
                         
                     }];
    
    
    
    
    
    
    
    
    
}



+ (CGFloat)toolbarHeight {
    
    // This method will handle the case that the height of toolbar may change in future iOS.
    
    return 44.f;
    
}







- (void)doneButtonDidPressed:(id)sender {
    
    NSLog(@"Sender: %@", sender);
    
    if (sender == dueField) {
        
        [dueField resignFirstResponder];
        
        [self performSelector:@selector(cancel:) withObject:nil];
        
    }else{
        
        
        
        [oField resignFirstResponder];
        
        
        
    }
    
    
    
}







- (void)doneButtonDidPressed2:(id)sender {
    
    NSLog(@"Sender: %@", sender);
    
    
    
    [dueField resignFirstResponder];
    
    [self performSelector:@selector(cancel:) withObject:nil];
    
    
    
    
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    
    [UIView animateWithDuration:0.5
     
                          delay:0.0
     
                        options:UIViewAnimationOptionCurveEaseInOut
     
                     animations:^ {
                         
                         UIView* rootView = self.view;
                         
                         CGRect frame = rootView.frame;
                         
                         CGPoint oldOrigin = frame.origin;
                         
                         CGPoint newOrigin = CGPointMake(0, 100);
                         
                         frame.origin = newOrigin;
                         
                         
                         frame.size = CGSizeMake( frame.size.width - (newOrigin.x - oldOrigin.x), 284 );
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         rootView.frame = frame;
                         
                         
                         
                         
                         
                         
                         
                     }
     
                     completion:^(BOOL finished) {
                         
                     }];
    
    
    
    
}



-(CGPoint) offscreenCenter2 {
    
    CGPoint offScreenCenter2 = CGPointZero;
    
    
    
    
    
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
    
    
    
    offScreenCenter2 = CGPointMake(offSize.width / 2.0, offSize.height - 500);
    
    
    
    
    return offScreenCenter2;
    
}



- (void)viewDidLayoutSubviews

{
    
    [super viewDidLayoutSubviews];
    
    self.picker.frame = CGRectMake(0, 50, 300, 162);
    
}



-(IBAction)cancelAlarm:(UIButton*)sender{
    
    
    
    tapped = NO;
    
    
    
    [UIView animateWithDuration:0.3
     
                          delay:0
     
                        options: UIViewAnimationOptionCurveEaseInOut
     
     
     
                     animations:^{
                         
                         
                         
                         alarm.alpha = 1;
                         
                         oLabel.alpha = 0;
                         
                         dueField.alpha = 0;
                         
                         [dueField setEnabled:NO];
                         
                         self.info.dateString = @"";
                         
                         
                         
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         NSLog(@"Done!");
                         
                     }];
    
    [dueField resignFirstResponder];
    
    
    
    
    
}



-(IBAction)iGotTapped:(UIButton*)sender{
    
    
    
    tapped = YES;
    
    
    
    [UIView animateWithDuration:0.3
     
                          delay:0
     
                        options: UIViewAnimationOptionCurveEaseInOut
     
     
     
                     animations:^{
                         
                         
                         
                         sender.alpha = 0;
                         
                         oLabel.alpha = 1;
                         
                         dueField.alpha = 1;
                         
                         [dueField setEnabled:YES];
                         
                         
                         
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         NSLog(@"Done!");
                         
                     }];
    
    [dueField becomeFirstResponder];
    
    
    
    
    
}



-(void)viewDidLoad {
    
    tapped = NO;
    
    //originalFrame = self.view.frame;
    
    originalPoint = self.view.center;
    
    MasterViewController *mvc = [[MasterViewController alloc]init];
    
    self.master = mvc;
    
    self.master.tableView.tableFooterView.transform = CGAffineTransformMakeTranslation(0, -100);
    
    NSLog(@"load begging");
    
    [super viewDidLoad];
    
    UIBarButtonItem *doneItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Add Date" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonDidPressed2:)];
    
    UIBarButtonItem *doneItem3 = [[UIBarButtonItem alloc] initWithTitle:@"Remove Date" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAlarm:)];
    
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];
    
    
    
    
    
    
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    
    UIBarButtonItem *flexableItem2= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    
    UIToolbar *toolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];
    
    
    
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    
    
    
    [toolbar2 setItems:[NSArray arrayWithObjects:doneItem2,flexableItem2,doneItem3, nil]];
    
    
    
    [toolbar2 setBarTintColor:view1.backgroundColor];
    
    [toolbar setBarTintColor:toolbar2.barTintColor];
    
    dueField.inputAccessoryView = toolbar2;
    
    oField.inputAccessoryView = toolbar;
    
    //  _picker.tintColor = [UIColor whiteColor];
    
    
    
    doneItem2.tintColor = [UIColor whiteColor];
    
    doneItem3.tintColor = [UIColor whiteColor];
    
    doneItem.tintColor = [UIColor whiteColor];
    
    self.picker = [[UIDatePicker alloc] init];
    
    [_picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    _picker.datePickerMode = UIDatePickerModeDate;
    
    _picker.backgroundColor = self.view.backgroundColor;
    
    //   picker.frame = CGRectMake(0, 0, picker.frame.size.width, 162);
    
    dueField.inputView = self.picker;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [delegate managedObjectContext];
    
    [_picker setDate:info.details.date];
    
    iLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    
    oLabel.font =[UIFont fontWithName:@"ClearSans-Bold" size:12];
    
    mLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    
    
    
    iField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    
    oField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    
    dueField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    
    iField.textColor = [UIColor whiteColor];
    
    oField.textColor = [UIColor whiteColor];
    
    dueField.textColor = [UIColor whiteColor];
    
    
    
    
    
    
    
    iField.text = self.info.name;
    
    oField.text = self.info.details.money;
    
    
    
    date = self.details.date;
    
    name2 = self.info.name;
    
    moneystring = self.info.details.money;
    
    
    
    NSLog(@"Date String: %@",self.info.dateString);
    
    if ([self.info.dateString  isEqual: @""]) {
        
        [dueField setEnabled:NO];
        
        oLabel.alpha = 0;
        
        dueField.alpha = 0;
        
        tapped = NO;
        
        
        
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        
        oLabel.alpha = 1;
        
        dueField.alpha = 1;
        
        alarm.enabled = NO;
        
        alarm.alpha=0;
        
        [formatter setDateFormat:@"ddMMyyyy"];
        
        [formatter setDateStyle:NSDateFormatterFullStyle];
        
        
        
        self.storageDate = self.info.details.date;
        
        NSDate *dt = self.info.details.date;
        
        NSString *dateAsString = [formatter stringFromDate:dt];
        
        
        
        
        tapped=YES;
        
        NSLog(@"%@", dateAsString);
        
              
        
        
        NSLog(@"DateAsString: %@", dateAsString);
        
    
        
        
        
        
        
        dueField.text = [NSString stringWithFormat:@"%@",dateAsString];
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    
    [button addTarget:self
     
               action:@selector(cancel:)
     
     forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
    
    [swipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [view1 addGestureRecognizer:swipeGestureRecognizer];
    
    [view2 addGestureRecognizer:swipeGestureRecognizer];
    
    [view3 addGestureRecognizer:swipeGestureRecognizer];
    
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    
    
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
    
    
    
    
    
    
    
    
    
}



-(void)updateTextField:(id)sender

{
    
    
    
    
    
    //UIDatePicker *picker = (UIDatePicker*)dueField.inputView;
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    
    
    
    [formatter setDateFormat:@"ddMMyyyy"];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    NSDate *dt = self.picker.date;
    
    NSString *dateAsString = [formatter stringFromDate:dt];
    
    
    
    
    
    NSLog(@"%@", dateAsString);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    dueField.text = [NSString stringWithFormat:@"%@",dateAsString];
    
}









-(CGPoint) offscreenCenter {
    
    CGPoint offScreenCenter = CGPointZero;
    
    
    
    
    
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
    
    
    
    offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    
    
    
    return offScreenCenter;
    
}





-(void)pickerView:(UIDatePicker*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    dueField.text = [NSString stringWithFormat:@"%@", pickerView.date];
    
    
    
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

