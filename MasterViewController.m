//
//  WIOMasterViewController.m
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//
#import "InputViewController.h"
#import "MasterViewController.h"
// At very top, in import section
#import "OweInfo.h"
#import "OweDetails.h"
#import "LCZoomTransition.h"
#import "AppDelegate.h"
#import "OweTableViewCell.h"
#import "FooterViewController.h"

#import "EditTableViewCell.h"

#import <AVFoundation/AVFoundation.h>
#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "SWUtilityButtonView.h"
#import "EditViewController.h"
#import "DatePickerViewController.h"
#import "WYPopoverController.h"
#import "WYStoryboardPopoverSegue.h"
#import "SelectionViewController.h"
#import "IBActionSheet.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
@interface MasterViewController  () <UITableViewDelegate, NSFetchedResultsControllerDelegate, WYPopoverControllerDelegate, SelectionViewControllerDelegate, UIAlertViewDelegate>
{
      WYPopoverController *popoverController;
    NSArray *quotesArray;
    
}
    - (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
 - (BOOL)cellIsSelected2:(NSIndexPath *)indexPath;
- (void)inputViewController:(SelectionViewController *)controller;

@property (nonatomic, strong) PersistentStack* persistentStack;


@end

@implementation MasterViewController
@synthesize managedObjectContext;
// At top, under @implementation

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize name = _name1;
@synthesize date = _date1;
@synthesize dateOwed = _dateOwed1;
@synthesize money = _money1;
@synthesize delegate = _delegate;

BOOL didDrugCheck;
id detailItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)authenticateUser{
    LAContext *context = [[LAContext alloc]init];
    NSError *error;
    NSString *reasonString = @"Authentication Required";
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];

    self.tableView.dataSource = nil;
    if ([context canEvaluatePolicy:(LAPolicyDeviceOwnerAuthenticationWithBiometrics) error:&error] && [defaults boolForKey:@"touchIDOn"] == YES) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                           localizedReason:reasonString
                                     reply:^(BOOL succes, NSError *error) {
                                         
                                         if (succes) {
                                             
                                             self.tableView.dataSource = self;
  
                                             [self refreshTableView];
                                             NSLog(@"User is authenticated successfully");
                                            didDrugCheck = false;
                                         } else {
                                             
                                             switch (error.code) {
                                                 case LAErrorAuthenticationFailed:
                                                     NSLog(@"Authentication Failed");
                                                    [self authenticateUser];
                                                     break;
                                                     
                                                 case LAErrorUserCancel:
                                                     NSLog(@"User pressed Cancel button");
                                                     [self authenticateUser];
                                                     break;
                                                     
                                                 case LAErrorUserFallback:{
                                                     NSLog(@"User pressed \"Enter Password\"");
                                                     [[NSOperationQueue mainQueue]addOperationWithBlock:^(void){
                                                         [self showPasswordAlert];
                                                          didDrugCheck = false;
                                                     }];
                                                     
                                                     break;
                                                 }
                                                     
                                                 default:{
                                                     NSLog(@"Touch ID is not configured");
                                                     [[NSOperationQueue mainQueue]addOperationWithBlock:^(void){
                                                         [self showPasswordAlert];
                                                         didDrugCheck = true;
                                                         
                                                     }];
                                                     break;
                                                 }
                                             }
                                             
                                             NSLog(@"Authentication Fails");
                                         }
                                     }];
    }else {
        [self showPasswordAlert];
        didDrugCheck = true;
    }
    [defaults setBool:didDrugCheck forKey:@"drugCheck"];
    [defaults synchronize];
    
}
-(void)refreshTableView{

    dispatch_async(dispatch_get_main_queue(), ^{

       [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
   
    });

    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id delegate2 = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate2 managedObjectContext];
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.managedObjectContext deleteObject:object];
    [self.delete play];

   // OweInfo *info = [[OweInfo alloc]init];
    
   OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
    
    for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
        
        if ([localNotification.alertBody isEqualToString: info.details.alert]) {
            NSLog(@"the notification this is canceld is %@", localNotification.alertBody);
            
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification] ; // delete the notification from the system
            
        }
        
    }
    // Save
    NSError *error;
    if ([self.managedObjectContext save:&error] == NO) {
        // Handle Error.
    }

}




- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    NSMutableArray *todayDataArray = [[NSMutableArray alloc]init];
    if([sharedUserDefaults objectForKey:@"todayData"] != nil){
        todayDataArray = [NSMutableArray arrayWithArray:[sharedUserDefaults objectForKey:@"todayData"]];
        NSLog(@"Not empty");
    }else{
        [sharedUserDefaults setObject:todayDataArray forKey:@"todayData"];
        [sharedUserDefaults synchronize];
                NSLog(@"empty");
        
    }

    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [todayDataArray removeObjectAtIndex:indexPath.row];
            [sharedUserDefaults setObject:todayDataArray forKey:@"todayData"];
            [sharedUserDefaults synchronize];
            NSLog(@"Edited today data: %@", todayDataArray);
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell: (OweTableViewCell*) [tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
         
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }

}
-(void)removeNotification: (NSString *)uid{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
        
        if ([uid isEqualToString:uid])
        {
            //Cancelling local notification
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}



- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            NSLog(@"A table item was moved");
            break;
        case NSFetchedResultsChangeUpdate:
            NSLog(@"A table item was updated");
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


- (NSFetchedResultsController *)fetchedResultsController {
    id thedelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [thedelegate managedObjectContext];
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
  //  self.managedObjectContext.persistentStoreCoordinator = self.persistentStack.persistentStoreCoordinator;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OweInfo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"details.date" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    NSLog(@"FR: %@", fetchRequest);
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}



- (void)viewDidUnload {
    self.fetchedResultsController = nil;
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    didDrugCheck = [defaults boolForKey:@"drugCheck"];
    if ([defaults objectForKey:@"password"]!= nil && didDrugCheck == false) {
        [self.tableView setDataSource:nil];
        [self refreshTableView];
        [self authenticateUser];
    }else{
        NSLog(@"No password, have a nice day :D");
    }
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
}
-(void)showPasswordAlert{
    UIAlertView *passwordAlert = [[UIAlertView alloc]initWithTitle:@"Password" message:@"Input Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    passwordAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [passwordAlert show];
}

- (void)viewDidLoad
{
    
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
    
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];

    
    didDrugCheck = [defaults boolForKey:@"drugCheck"];
    if ([defaults objectForKey:@"password"]!= nil) {
        [defaults setBool:YES forKey:@"drugCheck"];
        [defaults synchronize];
      [self authenticateUser];
        NSLog(@"password, plz check m8");
        
    }else{
        NSLog(@"No password, have a nice day :D");
    }
    

    self.clearsSelectionOnViewWillAppear = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    
    self.title = @"Owed";

   //self.zoomTransition = [[LCZoomTransition alloc] initWithNavigationController:self.navigationController];
    
    addButton.layer.cornerRadius = 2;
    addButton.layer.borderWidth = 1;
    addButton.layer.borderColor = addButton.backgroundColor.CGColor;
    self.tableView.bounces = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

 }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
    
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    [defaults setInteger:[sectionInfo numberOfObjects] forKey:@"count"];
    [defaults synchronize];
    return [sectionInfo numberOfObjects];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)configureCell:(OweTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  //  tableViewSize = 75;
    
    
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    
  
    OweDetails *details = info.details;

    
    UIImage *image = [UIImage imageWithData:details.image];

    
    
    
    if (image != nil) {
        UIImage *contactImage = [UIImage imageWithData:[details valueForKey:@"image"]];
        cell.contactImage.image = contactImage;
        
        cell.contactImage.layer.cornerRadius = 25;
    }else{
        
        cell.contactImage.image = [UIImage imageNamed:@"user.png"];
         cell.contactImage.layer.cornerRadius = 25;
    }
 
   

      if ([info.whooweswhat isEqualToString:@"someoneowes"]) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ owes you.", info.name];
    
        NSMutableArray *widgetArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@ owes you %@ due %@", info.name, details.money, info.dateString], nil];
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
        [sharedDefaults setObject:widgetArray forKey:@"name"];

        [sharedDefaults synchronize];
    }else{
        cell.nameLabel.text = [NSString stringWithFormat:@"You owe %@.", info.name];
      
        NSMutableArray *widgetArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"You owe %@ %@ due %@", info.name, details.money, info.dateString], nil];
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
        [sharedDefaults setObject:widgetArray forKey:@"name"];
              [sharedDefaults synchronize];
    }
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@", details.money];
    
    NSDate *today = [NSDate date];
    if (info.details.date != nil) {
        NSString *ifReplace;
        if ([[self class] daysBetweenDate:today andDate:info.details.date] >= 2) {
            cell.untilDate.text = [NSString stringWithFormat:@"%ld days.", (long)[[self class] daysBetweenDate:today andDate:info.details.date]];

        }else if ([[self class] daysBetweenDate:today andDate:info.details.date] == 0){
            cell.untilDate.text = @"Today";

        }else if ([[self class] daysBetweenDate:today andDate:info.details.date] == 1){
            cell.untilDate.text = [NSString stringWithFormat:@"%ld day.", (long)[[self class] daysBetweenDate:today andDate:info.details.date]];

        }else if([[self class] daysBetweenDate:today andDate:info.details.date] == -1){
            ifReplace = [[NSString stringWithFormat:@"%ld day behind.", (long)[[self class] daysBetweenDate:today andDate:info.details.date]] stringByReplacingOccurrencesOfString:@"-"
                                                                                                                                                                        withString:@""];
            cell.untilDate.text = ifReplace;

        }else if ([[self class] daysBetweenDate:today andDate:info.details.date] <= -2 ){
            
            ifReplace = [[NSString stringWithFormat:@"%ld days behind.", (long)[[self class] daysBetweenDate:today andDate:info.details.date]] stringByReplacingOccurrencesOfString:@"-"
                                                 withString:@""];
            cell.untilDate.text = ifReplace;

        }
       
    }else{
        cell.untilDate.text = @"No date set";
             }
    
    NSComparisonResult result;
    
    NSLog(@"Date results: %@", info.details.date);
    
    result = [today compare:details.date]; // comparing two dates
    cell.contactImage.layer.masksToBounds = YES;
    
    cell.thumbnailOwe.layer.masksToBounds=YES;
    cell.thumbnailOwe.layer.cornerRadius = 7.5;
        
              cell.dateLabel.text = info.dateString;
    //cell.backgroundColor = [UIColor colorWithRed:0.1765 green:0.1765 blue:0.1765 alpha:1.0];
    if(result==NSOrderedAscending)
        cell.thumbnailOwe.image = [UIImage imageNamed:@"Good.png"];

        cell.flippedDateLabel.text = [NSString stringWithFormat:@"Due %@.", info.dateString];
 //   cell.contentView.backgroundColor = [UIColor colorWithRed:0.6549 green:0.7490 blue:0.2353 alpha:1.0];
  //   cell.listView.backgroundColor = cell.contentView.backgroundColor;
    if ([info.dateString  isEqual: @""]) {
        cell.thumbnailOwe.image = [UIImage imageNamed:@"Dateless.png"];
            cell.flippedDateLabel.text = @"No due date set";
        
    }
    else if(result==NSOrderedDescending){
            cell.thumbnailOwe.image = [UIImage imageNamed:@"Bad.png"];
                  cell.flippedDateLabel.text = [NSString stringWithFormat:@"Due %@.", info.dateString];
      // cell.contentView.backgroundColor = [UIColor colorWithRed:1.0000 green:0.3333 blue:0.3922 alpha:1.0];
      //  cell.listView.backgroundColor = cell.contentView.backgroundColor;
    if ([info.dateString  isEqual: @""]) {
         cell.thumbnailOwe.image = [UIImage imageNamed:@"Dateless.png"];
         cell.flippedDateLabel.text = @"No due date set";
    }
    } else
              cell.dateLabel.center = cell.thumbnailOwe.center;

  //  [self.today configureCell:cell atIndexPath:indexPath];
    cell.contactImage.layer.borderColor = [UIColor blackColor].CGColor;
    cell.contactImage.layer.borderWidth = 1.5f;
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    NSMutableArray *todayDataArray = [[NSMutableArray alloc]init];
    if([sharedUserDefaults objectForKey:@"todayData"] != nil){
        todayDataArray = [NSMutableArray arrayWithArray:[sharedUserDefaults objectForKey:@"todayData"]];
    }else{
        [sharedUserDefaults setObject:todayDataArray forKey:@"todayData"];
        [sharedUserDefaults synchronize];
    
    }
   // UIImage *contactImage = [UIImage imageWithData:[details valueForKey:@"image"]];

    NSMutableDictionary *objectDictionary = [[NSMutableDictionary alloc]init];
    
     if (info.details.date != nil) {
    objectDictionary = [[NSMutableDictionary alloc]initWithObjects:@[info.name, UIImageJPEGRepresentation(cell.contactImage.image, 0.1), info.details.money, info.details.date, info.whooweswhat] forKeys:@[@"name", @"contactImage", @"money", @"date", @"wow"]];
     }else{
         objectDictionary = [[NSMutableDictionary alloc]initWithObjects:@[info.name, UIImageJPEGRepresentation(cell.contactImage.image, 0.1), info.details.money, info.whooweswhat] forKeys:@[@"name", @"contactImage", @"money", @"wow"]];

     }
    
    
    if (![todayDataArray containsObject:objectDictionary]) {
        [todayDataArray addObject:[objectDictionary copy]];
        NSLog(@"Added object: %@", objectDictionary);
        
        [sharedUserDefaults setObject:todayDataArray forKey:@"todayData"];
        
        [sharedUserDefaults synchronize];
    }else{
        NSLog(@"didnt add");
    }
    



    NSLog(@"Today Data: %@", todayDataArray);
    


    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


-(BOOL)youDriveMeCrazy{
    return false;
}



- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    navigationController.navigationBar.topItem.rightBarButtonItem = Nil;
}

-(void)PlayClip:(NSString *)soundName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:soundName ofType:@"aif"];
    AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [theAudio setVolume:10];
    [theAudio prepareToPlay];
    [theAudio play];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"OweCell";
    
    OweTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    

    cell.rightUtilityButtons = [self rightButtons];
    [self configureCell:cell atIndexPath:indexPath];
    cell.layer.cornerRadius = 0;
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];

    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.4667 green:0.9098 blue:0.4941 alpha:1.0]
                                                title:@"Payed"];
    
    return rightUtilityButtons;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    EditViewController *edit = [self editView];
    
    NSManagedObjectContext *mo = [_fetchedResultsController objectAtIndexPath:indexPath];
   [edit setManagedObjectContext:mo];
    
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
    [defaults setInteger:indexPath.row forKey:@"selectedRow"];
    [defaults setInteger:indexPath.section forKey:@"selectedSection"];
    [defaults synchronize];
    
    

    
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
   
    self.editView = edit;

    
    self.editView.delegate = self;
    self.editView.info = info;
    
    edit.info = info;
    edit.delegate = self;


    [self.tableView setContentOffset:CGPointMake(0, -65)];
    

  [self performSegueWithIdentifier:@"pushToEdit" sender:self];
   

    
}

-(void)selectRow{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
                                
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[defaults objectForKey:@"indexPath.row"] integerValue] inSection:0];
                                
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
 
    if([segue.identifier  isEqual: @"pushToEdit"] && [sender isKindOfClass:[MasterViewController class]]){
        
        NSLog(@"Send from shell");
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      //  self.zoomTransition.sourceView = [self.tableView cellForRowAtIndexPath:indexPath];
               // pass the custom transition to the destination controller
        // so it can use it when setting up its gesture recognizers
 //     [[segue destinationViewController] setGestureTarget:self.zoomTransition];
    EditViewController *edit = segue.destinationViewController;
    
        NSManagedObjectContext *mo = [_fetchedResultsController objectAtIndexPath:indexPath];
        [edit setManagedObjectContext:mo];

        
        id appDelegate= [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [appDelegate managedObjectContext];
        
        
        OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
            self.editView = edit;

 
        self.editView.delegate = self;
        self.editView.info = info;
    self.editView.managedObjectContext = self.managedObjectContext;
    edit.managedObjectContext = self.managedObjectContext;
        [self.editView setManagedObjectContext:self.managedObjectContext];
        edit.info = info;
        edit.delegate = self;

       

        
      
        
        
    }else if ([segue.identifier isEqualToString:@"pushToSelection"])
    {
        WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
        popoverController = [popoverSegue popoverControllerWithSender:sender
                                             permittedArrowDirections:WYPopoverArrowDirectionUp
                                                             animated:YES
                                                              options:WYPopoverAnimationOptionScale];
        popoverController.delegate = self;
       
        SelectionViewController *selection = [[SelectionViewController alloc]init];
        selection.delegate = self;
        
        popoverController.popoverContentSize = CGSizeMake(300, 215);
    }else if ([segue.identifier isEqualToString:@"pushToSettings"]){
        
       /* WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
        popoverController = [popoverSegue popoverControllerWithSender:sender
                                             permittedArrowDirections:WYPopoverArrowDirectionUp
                                                             animated:YES
                                                              options:WYPopoverAnimationOptionScale];
        popoverController.delegate = self;
        
        SelectionViewController *selection = [[SelectionViewController alloc]init];
        selection.delegate = self;
        
        popoverController.popoverContentSize = CGSizeMake(320, 300);
        */
        
    }else if([segue.identifier  isEqual: @"pushToEdit"] && [sender isKindOfClass:[AppDelegate class]]){
  
        NSFetchedResultsController *tempController;
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
     
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"OweInfo" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        
       
        
        // predicate code
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [(NSMutableDictionary *)[defaults objectForKey:@"objectFinder"]objectForKey:@"name"]];
        [fetchRequest setPredicate:predicate];
        
        // end of predicate code
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        tempController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        
        BOOL success;
        NSError *error;
        success = [tempController performFetch:&error];
        if (!success)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
        
             EditViewController *edit = segue.destinationViewController;
        
        
        NSLog(@"fetched results: %@", _fetchedResultsController);
     
       
        
        
        NSManagedObjectContext *mo = [tempController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSLog(@"Object %@", mo);
        
        [edit setManagedObjectContext:mo];
        NSLog(@"Sender: %@", sender);
        
        
        id appDelegate= [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [appDelegate managedObjectContext];
        
        
        OweInfo *info = [tempController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        self.editView = edit;
        
        NSLog(@"name from: %@", info.name);
        self.editView.delegate = self;
        self.editView.info = info;
        self.editView.managedObjectContext = self.managedObjectContext;
        edit.managedObjectContext = self.managedObjectContext;
        
        edit.info = info;
        edit.delegate = self;
        
       
        
    }else if ([segue.identifier isEqual:@"showNew"]){
        InputViewController *newView = segue.destinationViewController.childViewControllers.firstObject;
        [newView setDetailItem:self.detailItem];
    }
    

    
}

- (BOOL) isICloudAvailable
{
    return NO;
}



-(void)setOwedItem:(id)owedItem{
    if (_owedItem == owedItem) {
        _owedItem = owedItem;
    }
}





-(UIViewController*) getRootViewController {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}




-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Payed!";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 

    return 75.0f;
}



+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

- (IBAction)addAPerson:(id)sender {
    
    NSString *title;
    if (self.titleSegmentedControl.selectedSegmentIndex == 0) {
        title = @"Pick an option";
    }
    
    if (self.addPerson.visible == NO) {
    self.addPerson = [[IBActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"I owe", @"Someone owes me", nil];
       [self.addPerson setFrame:CGRectMake(self.addPerson.bounds.origin.x, self.addPerson.bounds.origin.y + 500, self.addPerson.bounds.size.width, self.addPerson.bounds.size.height)];

    [self.addPerson setButtonBackgroundColor:[UIColor colorWithRed:0.1765 green:0.1765 blue:0.1765 alpha:1.0]];
    [self.addPerson setButtonTextColor:[UIColor whiteColor]];
    self.addPerson.buttonResponse = IBActionSheetButtonResponseHighlightsOnPress;
    [self.addPerson setButtonHighlightTextColor:[UIColor whiteColor]];
    [self.addPerson setButtonHighlightBackgroundColor:[UIColor colorWithRed:0.1765 green:0.1765 blue:0.1765 alpha:1.0]];
     [self.addPerson showInView:self.view];
    }
}

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    InputViewController *inputView = [[InputViewController alloc]init];
    _inputViewController = inputView;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    UINavigationController *inputViewNav = [storyboard instantiateViewControllerWithIdentifier:@"InputViewController"];
    _inputViewController = [inputViewNav.viewControllers firstObject];
    
    [_inputViewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [_inputViewController setManagedObjectContext:self.managedObjectContext];
    
    if (buttonIndex == 0) {
        self.detailItem = @"NotOwed";
          NSLog(@"%@", self.detailItem);
        [self performSegueWithIdentifier:@"showNew" sender:self];
        
    }else if(buttonIndex == 1){
        self.detailItem = @"Owed";
        NSLog(@"%@", self.detailItem);
        [self performSegueWithIdentifier:@"showNew" sender:self];
    }
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            // Delete button was pressed
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            id delegate2 = [[UIApplication sharedApplication] delegate];
            self.managedObjectContext = [delegate2 managedObjectContext];
            NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
            [self.managedObjectContext deleteObject:object];
            [self.delete play];
            
            // OweInfo *info = [[OweInfo alloc]init];
            
            OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
            [self removeNotification:info.uid];
            NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
            
            for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
                
                NSLog(@"Notification: %@", localNotification.alertBody);
                
            }
            // Save
            NSError *error;
            if ([self.managedObjectContext save:&error] == NO) {
                NSLog(@"Save error: %@", error);
                
            }else{
                NSLog(@"Saved like a boss");
                
            }

        
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *backgroundLabel = [[UILabel alloc]init];
    id object = quotesArray.count == 0 ? nil : quotesArray[arc4random_uniform(quotesArray.count)];
    
    backgroundLabel.text = object;
    
    backgroundLabel.textAlignment = NSTextAlignmentCenter;
    backgroundLabel.textColor = [UIColor darkGrayColor];
    
    
    return backgroundLabel;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    if (buttonIndex == 1) {
        if (![[alertView textFieldAtIndex:0].text isEqual:@""]) {
            if ([[alertView textFieldAtIndex:0].text isEqual:[defaults objectForKey:@"password"]]) {
                self.tableView.dataSource = self;
            [self refreshTableView];
            }else{
                [self showPasswordAlert];
            }
        }else{
            [self showPasswordAlert];
        }
    }
}


@end
