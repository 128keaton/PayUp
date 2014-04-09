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

#import "CSAnimationView.h"
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
    [formatter setDateFormat:@"dd/MM"];
    //  [formatter setDateStyle:NSDateFormatterFullStyle];
    NSDate *dt = self.picker.date;
    NSString *dateAsString = [formatter stringFromDate:dt];

    
    NSManagedObjectContext *context = [self managedObjectContext];

    [self.info setValue:iField.text forKey:@"name"];
            NSError *error;
    
    [self.info setValue:dateAsString forKey:@"dateString"];
    
    if ([self.info.dateString  isEqual: @""]) {
        
    }
        
        
    if (tapped == YES){
                [self.info.details setValue:self.picker.date forKey:@"date"];
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
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.picker.frame = CGRectMake(0, 50, 300, 162);
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
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    [dueField becomeFirstResponder];

    
}
-(void)viewDidLoad {
    tapped = NO;
    NSLog(@"load begging");
      [super viewDidLoad];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];
    
    
    
    UIBarButtonItem *doneItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed2:)];
    UIBarButtonItem *flexableItem2= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] toolbarHeight])];
    
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    
    [toolbar2 setItems:[NSArray arrayWithObjects:flexableItem2,doneItem2, nil]];
    dueField.inputAccessoryView = toolbar2;
    oField.inputAccessoryView = toolbar;
    
  
    
    
    self.picker = [[UIDatePicker alloc] init];
   [_picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
     _picker.datePickerMode = UIDatePickerModeDate;
  //   picker.frame = CGRectMake(0, 0, picker.frame.size.width, 162);
    dueField.inputView = self.picker;
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    [_picker setDate:info.details.date];
  /*  iLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
    oLabel.font =[UIFont fontWithName:@"ClearSans-Bold" size:12];
    mLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:12];
 
    iField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    oField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
    dueField.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];*/
    iField.textColor = [UIColor whiteColor];
    oField.textColor = [UIColor whiteColor];
    dueField.textColor = [UIColor whiteColor];
  

    
    iField.text = self.info.name;
    oField.text = self.info.details.money;
    
    
    
    
    if ([self.info.dateString  isEqual: @""]) {
        [dueField setEnabled:NO];
        oLabel.alpha = 0;
        dueField.alpha = 0;
        [dueField setEnabled:YES];
        [dueField becomeFirstResponder];
    }else{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"ddMMyyyy"];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    NSDate *dt = self.info.details.date;
    NSString *dateAsString = [formatter stringFromDate:dt];
    
    
    NSLog(@"%@", dateAsString);
    
        
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
    
    tapped = YES;
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