//
//  SettingsViewController.m
//  IO
//
//  Created by Keaton Burleson on 9/16/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@import AddressBook;
#import "StyleController.h"
#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WYPopoverController.h"
#import "PasswordTableViewCell.h"

@interface SettingsViewController () <ABPeoplePickerNavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate, UIAlertViewDelegate, WYPopoverControllerDelegate, UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UILabel *statusLabel;
 
}
@property (strong, nonatomic)IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

#define kFlickrAPIKey @"0cdecff9ac70415f1f05bbd34ea226a2"

- (void)viewDidLoad {
    [super viewDidLoad];
      UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 44);
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    quotesArray = @[
               @"Live and let live",
               @"Don't cry over spilt milk",
               @"Always look on the bright side of life",
               @"Nobody's perfect",
               @"Can't see the woods for the trees",
               @"Better to have loved and lost then not loved at all",
               @"The early bird catches the worm",
               @"As slow as a wet week"
               ];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica Neue" size:12], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 2 - Get random index
    int index = (arc4random() % [quotesArray count]);
    // 3 - Get the quote string for the index
    NSString *theQuote = quotesArray[index];
    // 4 - Display the quote in the text view
    quotes.text = theQuote;
    visualEffectView.frame = blurriedImage.bounds;
    [blurriedImage addSubview:visualEffectView];
    [self.view bringSubviewToFront:circleImage];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstNameSettings"];
    if(![firstName isEqual: @""]){
        [chooseName setTitle:firstName forState:UIControlStateNormal];
        
    }else{
             [chooseName setTitle:@"Select your contact" forState:UIControlStateNormal];
        [defaults removeObjectForKey:@"image"];
    }
    if ([defaults objectForKey:@"image"] !=nil) {
        UIImage *theImage = [UIImage imageWithData: [defaults objectForKey:@"image"]];
        circleImage.image = theImage;
        blurriedImage.image = theImage;
        circleImage.layer.cornerRadius = 50;
        circleImage.clipsToBounds = YES;
        circleImage.layer.borderWidth = 3.0f;
        circleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [addButton removeFromSuperview];
       blurriedImage.hidden = NO;
             circleImage.backgroundColor = [UIColor whiteColor];
        
    }else{
        [chooseName setTitle:@"Select your contact" forState:UIControlStateNormal];
       
        
        circleImage.layer.cornerRadius = 50;
        circleImage.clipsToBounds = YES;
        circleImage.layer.borderWidth = 3.0f;
        circleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        circleImage.backgroundColor = [UIColor whiteColor];
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(25, 25, circleImage.bounds.size.width/2, circleImage.bounds.size.height/2);
        // addButton = [[UIButton alloc]initWithFrame:circleImage.bounds];
        
        [addButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        [addButton setBackgroundColor:[UIColor clearColor]];
        [addButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
        // [addButton setTitle:@"+" forState:UIControlStateNormal];
        //  [addButton.imageView setContentMode:UIViewContentModeCenter];
        //  [addButton setContentMode:UIViewContentModeCenter];
        addButton.layer.cornerRadius = 50 /2;
        addButton.clipsToBounds = YES;
        //  addButton.layer.borderWidth = 3.0f;
        // addButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        // addButton.backgroundColor = [UIColor whiteColor];
        [circleImage addSubview:addButton];
        [circleImage addSubview:addButton];
        [circleImage bringSubviewToFront:addButton];
        [circleImage setUserInteractionEnabled:YES];
        blurriedImage.hidden = YES;

        
    }
    
    
    
    self.colorArray  = [[NSArray alloc]         initWithObjects:@"Blue",@"Green",@"Red", nil];
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
  
    /*  oField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
     if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.1)) {
     oField.keyboardType = UIKeyboardTypeDecimalPad;
     }*/
    
    chooseName.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self setNeedsStatusBarAppearanceUpdate];

    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationSlide];
    /*  if (![firstName isEqual:@""] ) {
        chooseName.titleLabel.text = firstName;
    }else if (![firstName isEqual:chooseName.titleLabel.text]){
       chooseName.titleLabel.text = firstName;
    }*/

  /*    pickerToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [pickerToolbar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(removePicker:)];
    pickerToolbar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor blackColor];
    [self.picker addSubview:pickerToolbar];*/

    // Do any additional setup after loading the view.
  }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *defaultSuite = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
   
    PasswordTableViewCell *cell = (PasswordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Password"];
    if ([defaultSuite objectForKey:@"password"] == nil) {
        [cell.statusLabel setText:@"Off"];
    }else{
        [cell.statusLabel setText:@"On"];
    }
    
     return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            NSLog(@"Password");
            break;
            
        case 1:
            NSLog(@"Other");
            break;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void)viewDidAppear:(BOOL)animated{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstNameSettings"];
    if(![firstName isEqual: @""]){
        [chooseName setTitle:firstName forState:UIControlStateNormal];
        
    }else{
        chooseName.titleLabel.text = @"None";
        [addButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        [addButton setBackgroundColor:[UIColor clearColor]];
        [addButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
      //  circleImage.image = [UIImage imageNamed:@"plus.png"];
        [defaults removeObjectForKey:@"image"];
        
    }
  //  self.view.frame = CGRectMake(0, 0, 300, 300);
    if ([defaults objectForKey:@"image"] !=nil) {
        UIImage *theImage = [UIImage imageWithData: [defaults objectForKey:@"image"]];
        circleImage.image = theImage;
        blurriedImage.image = theImage;
        circleImage.layer.cornerRadius = 50;
        circleImage.clipsToBounds = YES;
        circleImage.layer.borderWidth = 3.0f;
        circleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        blurriedImage.hidden = NO;
        circleImage.backgroundColor = [UIColor whiteColor];
        [addButton removeFromSuperview];
        
        
    }else{
        [chooseName setTitle:@"Select your contact" forState:UIControlStateNormal];
              
        circleImage.layer.cornerRadius = 50;
        circleImage.clipsToBounds = YES;
        circleImage.layer.borderWidth = 3.0f;
        circleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        circleImage.backgroundColor = [UIColor whiteColor];
        circleImage.image = nil;
              // addButton = [[UIButton alloc]initWithFrame:circleImage.bounds];
 
       [addButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        [addButton setBackgroundColor:[UIColor clearColor]];
        [addButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
       // [addButton setTitle:@"+" forState:UIControlStateNormal];
      //  [addButton.imageView setContentMode:UIViewContentModeCenter];
      //  [addButton setContentMode:UIViewContentModeCenter];
        addButton.layer.cornerRadius = 50 /2;
        addButton.clipsToBounds = YES;
      //  addButton.layer.borderWidth = 3.0f;
       // addButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        // addButton.backgroundColor = [UIColor whiteColor];
        [circleImage addSubview:addButton];
        [circleImage addSubview:addButton];
        
        [circleImage bringSubviewToFront:addButton];
        [circleImage setUserInteractionEnabled:YES];
 
        blurriedImage.hidden = YES;
        
    }
    
 
}

-(IBAction)done:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
      
    
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([navigationController isKindOfClass:[ABPeoplePickerNavigationController class]]) {
             navigationController.navigationBar.tintColor = [UIColor whiteColor];
        navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)removePicker:(id)sender{

        
        [UIView beginAnimations:@"picker" context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.picker.transform = CGAffineTransformMakeTranslation(0,236);
        [UIView commitAnimations];
    

}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 3;
    
}


- (IBAction)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;

    picker.navigationBar.tintColor = [UIColor blackColor];
    [self presentViewController:picker animated:YES completion:nil];
    
    
   }

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self clearUser];
  //  [self.view setFrame:CGRectMake(0, 0, 300, 300)];
    [self dismissViewControllerAnimated:peoplePicker completion:nil];
}


-(void)clearUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
    [sharedDefaults removeObjectForKey:@"todayData"];
    [defaults removeObjectForKey:@"image"];
    [defaults removeObjectForKey:@"firstNameSettings"];
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person{
    
    NSString* firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      ///  [self.view setFrame:CGRectMake(0, 0, 300, 300)];
    
    NSData *contactImageData;
    
    
    if (ABPersonHasImageData(person)) {
       contactImageData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
        
        
         [defaults setObject:contactImageData forKey:@"image"];
 
        
          }else{
        
        contactImageData = UIImagePNGRepresentation([UIImage imageNamed:@"user.png"]);
               [defaults setObject:contactImageData forKey:@"image"];
    }

    
    [defaults setObject:firstName forKey:@"firstNameSettings"];
    
 
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(IBAction)removeAll:(id)sender{
    
    UIAlertView *reallyAlert = [[UIAlertView alloc]initWithTitle:@"Really?" message:@"Do you really want to clear all?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [reallyAlert show];
  
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }else{
        //NSFetchedResultsController *fetchedResultsController;
        id delegate2 = [[UIApplication sharedApplication] delegate];
       NSManagedObjectContext * managedObjectContext = [delegate2 managedObjectContext];
        NSFetchRequest * fetch = [[NSFetchRequest alloc]init];
        [fetch setEntity:[NSEntityDescription entityForName:@"OweInfo" inManagedObjectContext:managedObjectContext]];
        NSArray * result = [managedObjectContext executeFetchRequest:fetch error:nil];
        for (id item in result) {
            [managedObjectContext deleteObject:item];
        }
        
        [fetch setEntity:[NSEntityDescription entityForName:@"OweDetails" inManagedObjectContext:managedObjectContext]];
        for (id item in result) {
            [managedObjectContext deleteObject:item];
        }
        [managedObjectContext save:nil];
       
    }

}

@end
