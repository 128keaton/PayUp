
#import "AppDelegate.h"
#import "EditViewController.h"
#import "OweInfo.h"
#import "OweDetails.h"
#import <AVFoundation/AVFoundation.h>
#import "CSAnimationView.h"
#import "WYPopoverController.h"
#import "WYStoryboardPopoverSegue.h"
#import "DatePickerViewController.h"

@implementation MFMailComposeViewController (IOS7_StatusBarStyle)

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return nil;
}

@end

@implementation EditViewController







@synthesize coverView, info, navBar, name, details = _details, managedObjectContext = _managedObjectContext;

















- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == nameField) {
        
        [textField resignFirstResponder];
        
        [moneyField becomeFirstResponder];
        
    } else if (textField == moneyField) {
        
        [moneyField resignFirstResponder];
        [reasonField becomeFirstResponder];
        
        
        
    }else if(textField == reasonField){
        [self.info setValue:reasonField.text forKey:@"forwhat"];
        [reasonField resignFirstResponder];
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
    [[controller navigationBar] setTintColor:[UIColor whiteColor]];
    [self presentViewController:controller animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
}

-(void)PlayClip:(NSString *)soundName

{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
    
    AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    
    
    [theAudio play];
    
    
    
    
    
    
    
}




- (IBAction)openMail:(id)sender

{
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName2 = [defaults objectForKey:@"firstNameSettings"];

   
    if(firstName2 != nil && ![self.info.shared isEqual:@"Shared"]){
        
        if ([MFMailComposeViewController canSendMail])
            
        {
            
            
            
            MasterViewController *master2 = [[MasterViewController alloc]init];
            
            self.master = master2;
            
            self.master.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            
            
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
            NSString *bodyString = nil;
            
            mailer.mailComposeDelegate = self;
            
            if (![self.info.whooweswhat  isEqual: @"someoneowes"]) {
                
                [mailer setSubject:[NSString stringWithFormat:@"I Owe You %@", self.info.details.money]];
                
                bodyString = [NSString stringWithFormat:@"I owe you %@.", moneystring];
                
                
                
                
                
            }else{
                
                
                
                [mailer setSubject:[NSString stringWithFormat:@"You Owe Me %@", self.info.details.money]];
                
                bodyString = [NSString stringWithFormat:@"You owe me %@.", moneystring];
                
            }
            
            
            
            
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            
            
            // Time format for the string value
            
            //   NSString *dateStr = [dateFormatter stringFromDate:self.info.details.date];
            
            
            NSDate *theDate = [defaults objectForKey:@"pickerDate"];
            if (tapped == YES){
                
                [dict setObject:theDate forKey:@"date"];
                
                [dict setObject:self.info.dateString forKey:@"dateString"];
                
                NSLog(@"tapped");
                
            }else{
                
                NSLog(@"nottapped");
                
                [dict setObject:@"" forKey:@"dateString"];
               // NSDate *today = [NSDate date];
                //[dict setObject:today forKey:@"date"];
                
                
                
            }
            
            
            
            
            
            
            
            [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
            
            
            
            
            
            
            
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            
            
            
            
            [formatter  setDateFormat:@"YYYYMMddHHmmss"];
            
            //[formatter setDateStyle:NSDateFormatterFullStyle];
            
            NSDate *dt = [defaults objectForKey:@"pickerDate"];
            
            NSString *dateAsString = [formatter stringFromDate:dt];
            
            
            
            
            
            NSLog(@"DateAsString2: %@", dateAsString);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            NSString *strDate = dateAsString;
            
            NSLog(@"%@", strDate);
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           // NSString *firstName = [defaults objectForKey:@"firstName"];
            
            
            NSString *humanName = [defaults objectForKey:@"firstNameSettings"];
            NSLog(@"WHO OWES: %@", self.info.whooweswhat);
            
            
            NSLog(@"Name from sent: %@", humanName);

            NSLog(@"Name from sent2: %@", self.info.name);
            
            
            NSString *wow = nil;
            
            NSLog(@"Who owes what? %@", self.info.whooweswhat);
            if ([self.info.whooweswhat  isEqual: @"nope"]) {
                wow = @"someoneowes";
          
                NSLog(@"this is someone");
                [dict setObject:humanName forKey:@"firstName"];
                UIImage *image = [UIImage imageWithData:[defaults objectForKey:@"image"]];
                 NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
                [dict setObject:imageData forKey:@"image"];
            }else if([self.info.whooweswhat isEqual:@"someoneowes"]){
                
                wow = @"nope";
                
                UIImage *image = [UIImage imageWithData:info.details.image];
                NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
                [dict setObject:imageData forKey:@"image"];

                NSLog(@"this is nope");
                [dict setObject:self.info.name forKey:@"firstName"];
                
                
            }
            [dict setObject:wow forKey:@"whooweswhat"];
            
            [dict setObject:self.info.details.money forKey:@"money"];
            if (self.info.forwhat !=nil) {
                [dict setObject:self.info.forwhat forKey:@"forwhat"];
            }else{
                [dict setObject:@"" forKey:@"forwhat"];
            }
                       NSLog(@"Money: %@", self.info.details.money);
            
            
            
            
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
            
            
            
            [mailer addAttachmentData:data mimeType:@"application/io" fileName:@"IO"];
            
            
            
            // NSDate *startDateString = self.info.details.date;
            
            //  NSDateFormatter *dateStartFormatter = [[NSDateFormatter alloc] init];
            
            // [dateStartFormatter setDateFormat:@"dd MM yyyy"];
            
            
            
            
            id delegate = [[UIApplication sharedApplication] delegate];
            
            self.managedObjectContext = [delegate managedObjectContext];
            
            
            
            
            
            
            
            
            
            
            
            
            
            //     CGFloat alpha = self.coverView.alpha;
            
          //  [self.delegate moveBack];
            
            
            
            
            
            
            
            
            
            self.managedObjectContext = [delegate managedObjectContext];
            
            //   NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            
            
            
            
            
            
            
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
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"You need to set your contact on the main screen" delegate: nil cancelButtonTitle:@"Ok, sorry!" otherButtonTitles:nil]; [alert show];
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
    
    NSString *s = moneyField.text;
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    
    NSString *newS = [NSString stringWithFormat:@"$%@", s];
    
    moneyField.text = newS;
    
    
    
    
    
}



-(IBAction)cancel:(id)sender{
    
    
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [delegate managedObjectContext];
    
    
    
    NSLog(@"Sent!");
    
    //   [self dismissViewControllerAnimated:YES completion:nil];
    
    //    [self.view.superview removeFromSuperview];
    
    
    
    
    
    NSString *s = moneyField.text;
    
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
    
    
    
    [self.info setValue:nameField.text forKey:@"name"];
    NSLog(@"Name from Edit: %@", self.info.name);
    
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
                         
                         [moneyField resignFirstResponder];
                         
                         //[self dismissSemiModalViewController:self];
                         
                     //    [self.delegate goBack];
                         
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
    
    if (sender == dateField) {
        
        [dateField resignFirstResponder];
        
        [self performSelector:@selector(cancel:) withObject:nil];
        
    }else{
        
        
        
        [moneyField resignFirstResponder];
        
        
        
    }
    
    
    
}







- (void)doneButtonDidPressed2:(id)sender {
    
    NSLog(@"Sender: %@", sender);
    
    
    
    [dateField resignFirstResponder];
    
    [self performSelector:@selector(cancel:) withObject:nil];
    
    
    
    
    
    
    
    
    
}






- (void)viewDidLayoutSubviews

{
    
    [super viewDidLayoutSubviews];
    
    self.picker.frame = CGRectMake(0, 0, self.picker.bounds.size.width, self.picker.bounds.size.height/2);
    self.picker.datePickerMode = UIDatePickerModeDateAndTime;
    
}



-(IBAction)cancelAlarm:(UIButton*)sender{
    
    
    
    tapped = NO;
    
    
    
    [UIView animateWithDuration:0.3
     
                          delay:0
     
                        options: UIViewAnimationOptionCurveEaseInOut
     
     
     
                     animations:^{
                         
                         
                         
                         alarm.alpha = 1;
                         
                         dateLabel.alpha = 0;
                         
                         self.dueField.alpha = 0;
                         
                         [self.dueField setEnabled:NO];
                         
                         self.info.dateString = @"";
                         
                         
                         
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         NSLog(@"Done!");
                         
                     }];
    
    [self.dueField resignFirstResponder];
    
    
    
    
    
}



-(IBAction)iGotTapped:(UIButton*)sender{
    
    
    
    tapped = YES;
    
    
    
    [UIView animateWithDuration:0.3
     
                          delay:0
     
                        options: UIViewAnimationOptionCurveEaseInOut
     
     
     
                     animations:^{
                         
                         
                         
                         sender.alpha = 0;
                         
                         moneyField.alpha = 1;
                         
                         self.dueField.alpha = 1;
                         
                         [self.dueField setEnabled:YES];
                         
                         
                         
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         NSLog(@"Done!");
                         
                     }];
    
    [self.dueField becomeFirstResponder];
    
    
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToEdit"])
    {
        
        
        NSLog(@"Going back home");
    }else if ([segue.identifier isEqual:@"pushToDate"]){
        WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
        popoverController = [popoverSegue popoverControllerWithSender:sender
                                                    permittedArrowDirections:WYPopoverArrowDirectionNone
                                                                    animated:YES
                                                                     options:WYPopoverAnimationOptionFadeWithScale];
        popoverController.delegate = self;
        DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
     //   datePickerVC.picker.date = self.info.details.date;
        popoverController.popoverContentSize = CGSizeMake(349, 279);
        if (self.info.details.date != nil) {
            datePickerVC.date = self.info.details.date;

        }else{
            datePickerVC.date = [NSDate date];

        }
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField == moneyField){
    NSString *s = moneyField.text;
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];

    NSLog(@"%@", s);
    
    
    
    [self.info.details setValue:[NSString stringWithFormat:@"$%@", s] forKey:@"money"];
    }
    
}


-(IBAction)goHome:(id)sender{
    NSLog(@"Going back home");

    id delegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [delegate managedObjectContext];
    
    
    

    
    
    
    
    
    NSString *s = moneyField.text;
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSString *editedMoney;
    NSLog(@"%@", s);
    

        
    [self.info.details setValue:[NSString stringWithFormat:@"$%@", s] forKey:@"money"];
        
    editedMoney = [NSString stringWithFormat:@"$%@", s];
        
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    //  [formatter setDateStyle:NSDateFormatterFullStyle];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *datePickerDate = [defaults objectForKey:@"pickerDate"];
    
    NSString *dateAsString = [formatter stringFromDate:datePickerDate];
    
    
    

    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    
    [self.info setValue:nameField.text forKey:@"name"];
    NSLog(@"Name from Edit: %@", self.info.name);
    
    NSError *error;
    
    
    
    
    
    
    if (reasonField.text != nil) {
        [self.info setValue:reasonField.text forKey:@"forwhat"];
    }
    
    NSString *uid = self.info.uid;
    if (tapped == YES){
        
        [self.info.details setValue:[defaults objectForKey:@"pickerDate"] forKey:@"date"];
        
        [self.info setValue:dateAsString forKey:@"dateString"];
        
        
        [self removeNotification:uid];
        

        // NSDate *alertTime = picker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        formatter.timeZone = [NSTimeZone localTimeZone];
        
        NSLog(@"Picker Date: %@", [self.picker.date descriptionWithLocale:[NSLocale currentLocale]]);
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        NSDate *fireDate = [defaults objectForKey:@"pickerDate"];
        localNotification.fireDate = fireDate;
        
        
        [info setValue:uid forKey:@"uid"];
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        NSString *wow = self.info.whooweswhat;
        
        if ([wow isEqualToString:@"someoneowes"]) {
            localNotification.alertBody = [NSString stringWithFormat:@"%@ owes you %@ today", nameField.text, editedMoney];
        }else{
            localNotification.alertBody = [NSString stringWithFormat:@"You owe %@ %@ today", nameField.text,editedMoney ];
            [details setValue:nameField.text forKey:@"alert"];
        }
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

        
        
    }else{
        
        
        [info setValue:uid forKey:@"uid"];
        [self removeNotification:uid];
        
    }
    
    if (![context save:&error]) {
        
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    
    
    MasterViewController *master = [[MasterViewController alloc]init];
     [master.tableView setContentOffset:CGPointMake(0, -78)];
    
    
    self.master = master;
    [_master.tableView setContentOffset:CGPointMake(0, -65)];
   [self.navigationController popViewControllerAnimated:YES];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == dateField) {
        [self.view endEditing:YES];
        [self performSegueWithIdentifier:@"pushToDate" sender:textField];
        
        return NO;
    }else{
    return YES;
    }
}

-(void)nextNumberPad{
    [moneyField resignFirstResponder];
    [reasonField becomeFirstResponder];
    
}
-(void)clearNumberPad{
    [moneyField setText:nil];
    
}

-(void)viewDidLoad {
    
    tapped = NO;
    
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:showExtrasSwipe];

    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    //originalFrame = self.view.frame;
    
    NSLog(@"Loading Edit View");
    
    [super viewDidLoad];
   
   
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clearNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextNumberPad)],
                           nil];
    
    moneyField.inputAccessoryView = numberToolbar;
    numberToolbar.barTintColor = self.navigationController.navigationBar.barTintColor;
    numberToolbar.tintColor = self.navigationController.navigationBar.tintColor;

    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(openMail:)];
 
    self.title = @"Edit";
    
    
   //UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    

    
    
      [self.navigationItem setRightBarButtonItem:shareItem];
    
    
    
    //  _picker.tintColor = [UIColor whiteColor];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.info.details.date forKey:@"pickerDate"];
    [defaults synchronize];

    DatePickerViewController *datePickerView = [[DatePickerViewController alloc]init];
    self.datePickerViewController = datePickerView;

   
      [_picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    _picker.datePickerMode = UIDatePickerModeDateAndTime;
    _picker.date = self.info.details.date;
    _picker.backgroundColor = self.view.backgroundColor;
   // _picker.frame = CGRectMake(0, 0, _picker.bounds.size.width, _picker.bounds.size.width/2);

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
 
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica Neue" size:12], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    NSLog(@"Name from Edit: %@", self.info.name);
    nameField.text = self.info.name;
    
    moneyField.text = self.info.details.money;
    reasonField.text = self.info.forwhat;
    date = self.details.date;
    
    name2 = self.info.name;
    
    moneystring = self.info.details.money;
    
    if (!self.info.details.date) {
 
        
     
        
        tapped = NO;
        NSLog(@"no date");
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        

        
        
        
        alarm.enabled = NO;
        
        alarm.alpha=0;
        
        [formatter setDateFormat:@"ddMMyyyy"];
        
        [formatter setDateStyle:NSDateFormatterFullStyle];
        
        
        
        self.storageDate = self.info.details.date;
        
        NSDate *dt = self.info.details.date;
        
        NSString *dateAsString = [formatter stringFromDate:dt];
        

        _picker.date = dt;
        //self.datePickerViewController.date = dt;
        //   self.datePickerViewController.picker.date = dt;
        tapped=YES;
        dateField.text = [NSString stringWithFormat:@"%@",dateAsString];
    
    }
    
    
        
        
   
    
    
    
    
    
    
    
    


    
    
    

    
    
    
    
    if (self.detailItem) {
        
        self.navBar.title = [self.detailItem description];
        
        self.name.text = [self.detailItem description];
        
        
        
    }
    
 
    
    
    
    
    
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.info.whooweswhat isEqualToString:@"someoneowes"]) {
        return @"You are owed";
    }else{
        return @"You owe";
    }
    return nil;
    
}


-(void)removeNotification: (NSString *)uid{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
        NSLog(@"Edit UUID: %@", uid);
        if ([uid isEqualToString:uid])
        {
            //Cancelling local notification
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}

-(void)updateTextField:(NSDate *)pickerDate;

{
    
    
    
    if (pickerDate != nil) {

    
    //UIDatePicker *picker = (UIDatePicker*)dueField.inputView;
    
    
    
    
    
    
    [self.info.details setValue:pickerDate forKey:@"date"];


    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    

    
    NSError *error;
    
    
    
    
    [formatter setDateFormat:@"ddMMyyyy"];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    NSDate *dt = pickerDate;
    
    NSString *dateAsString = [formatter stringFromDate:dt];
    
    
    
    
    self.info.dateString = dateAsString;
    
    NSLog(@"%@", dateAsString);
    
    
    
    
    
    
    
    [self.info setValue:dateAsString forKey:@"dateString"];
    if (![context save:&error]) {
        
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    
 dateField.text = [NSString stringWithFormat:@"%@",dateAsString];
    }else{
        [self.info.details setValue:pickerDate forKey:@"date"];
        
        
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        
        
        
        NSError *error;
        
        
        
        
        [formatter setDateFormat:@"ddMMyyyy"];
        
        [formatter setDateStyle:NSDateFormatterFullStyle];
        
        NSDate *dt = pickerDate;
        
        NSString *dateAsString = [formatter stringFromDate:dt];
        
        
        
        
        self.info.dateString = dateAsString;
        
        NSLog(@"%@", dateAsString);
        
        
        
        
        
        
        
        [self.info setValue:dateAsString forKey:@"dateString"];
        if (![context save:&error]) {
            
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            
        }
        dateField.text = nil;
        
    }
    
    
    
}











-(void)pickerView:(UIDatePicker*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    dateField.text = [NSString stringWithFormat:@"%@", pickerView.date];
    
    
    
}

#pragma mark -

#pragma mark Memory Management



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    NSLog(@"popdown");

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self updateTextField:[defaults objectForKey:@"pickerDate"]];
    
    return YES;
}


- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    self.coverView = nil;
    
    self.view = nil;
    
}



- (BOOL)tableView:(UITableView *)iTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    if (indexPath.row >= 2) {
        return YES;
    }else{
        return NO;
    }
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)iTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
 
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row == 0) {
           // nameField.text = nil;
            
        }else if(indexPath.row == 1){
          //  moneyField.text = nil;
        }else if (indexPath.row == 2){
            reasonField.text = nil;
            
        }else if (indexPath.row == 3){
            dateField.text = nil;
            
            [self updateTextField:nil];
            
        }
        // Do whatever data deletion you need to do...
        // Delete the row from the data source
          //  UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:indexPath];
 

        self.tableView.editing=false;
    }
    [tableView endUpdates];
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture
{
  //  CGPoint location = [gesture locationInView:self.tableView];
   // NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    //UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
   // SWTableViewCell *cell = (SWTableViewCell *)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
   
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"Clear";
}

@end

