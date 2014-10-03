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
#import "CSAnimationView.h"
#import "EditTableViewCell.h"
#import <POP/POP.h>
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
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
@interface MasterViewController  () <UITableViewDelegate, NSFetchedResultsControllerDelegate, WYPopoverControllerDelegate, SelectionViewControllerDelegate>
{
      WYPopoverController *popoverController;
}
    - (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
 - (BOOL)cellIsSelected2:(NSIndexPath *)indexPath;
- (void)inputViewController:(SelectionViewController *)controller;

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


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OweInfo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"details.date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
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


-(void)moveBack{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    NSLog(@"%f", self.view.frame.origin.y);
    
    NSLog(@"I tried moving back!");
    [UIView animateWithDuration: 0.25 animations: ^(void) {
        self.tableView.tableFooterView.transform = CGAffineTransformIdentity;
        
    }];
    [UIView commitAnimations];
}
-(void)viewDidAppear:(BOOL)animated{
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
}

/*-(void)awakeFromNib{
    [super awakeFromNib];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.9333 green:0.3647 blue:0.3843 alpha:1.0]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.9333 green:0.3647 blue:0.3843 alpha:1.0]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
}*/
- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"slide-paper"
                                               ofType:@"aif"]];
    self.tap = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    [self.tap prepareToPlay];
    	selectedIndexes = [[NSMutableDictionary alloc] init];
    flipped = 0;
    currentSelection = -1;
    NSURL* musicFile2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"slide-scissors"
                                               ofType:@"aif"]];
    self.delete = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile2 error:nil];
    [self.delete prepareToPlay];

    [self setNeedsStatusBarAppearanceUpdate];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    self.title = @"Owed";
    self.zoomTransition = [[LCZoomTransition alloc] initWithNavigationController:self.navigationController];
   /* UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStyleBordered  target:self action:@selector(openSettings)];
   
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, NSFontAttributeName, nil];
    [rightBarButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;*/
  
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
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(IBAction)addPerson:(id)sender{
    
    [self performSegueWithIdentifier:@"pushToSelection" sender:self];
}
- (void)configureCell:(OweTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    tableViewSize = 75;
    
    
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    
  
    OweDetails *details = info.details;

    
    UIImage *image = [UIImage imageWithData:details.image];
    NSLog(@"Image: %@", image);

    
    
    
    if (image != nil) {
        UIImage *contactImage = [UIImage imageWithData:[details valueForKey:@"image"]];
        cell.contactImage.image = contactImage;
        
        cell.contactImage.layer.cornerRadius = 25;
    }else{
        NSLog(@"No image");
        cell.contactImage.image = [UIImage imageNamed:@"user.png"];
         cell.contactImage.layer.cornerRadius = 25;
    }
 
   

    NSLog(@"Master Input: %@",info.whooweswhat);
    if ([info.whooweswhat isEqualToString:@"someoneowes"]) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ owes you.", info.name];
    
        NSMutableArray *widgetArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@ owes you %@ due %@", info.name, details.money, info.dateString], nil];
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
        [sharedDefaults setObject:widgetArray forKey:@"name"];
        NSLog(@"Widget Array: %lu", (unsigned long)widgetArray.count);
        [sharedDefaults synchronize];
    }else{
        cell.nameLabel.text = [NSString stringWithFormat:@"You owe %@.", info.name];
      
        NSMutableArray *widgetArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"You owe %@ %@ due %@", info.name, details.money, info.dateString], nil];
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
        [sharedDefaults setObject:widgetArray forKey:@"name"];
        NSLog(@"Widget Array: %lu", (unsigned long)widgetArray.count);
        [sharedDefaults synchronize];
    }
    
    
  //   cell.flipView.backgroundColor = cell.contentView.backgroundColor;

    cell.moneyLabel.text = [NSString stringWithFormat:@"%@", details.money];
    
    NSDate *today = [NSDate date];
    // your date
    
    NSLog(@"The Date: %@", info.details.date);
    
    if (info.details.date != nil) {
        NSString *ifReplace;
        if ([[self class] daysBetweenDate:today andDate:info.details.date] >= 1) {
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
    
    NSLog(@"Date: %@", details.date);
    NSLog(@"Money: %@", details.money);
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
        NSLog(@"Both dates are same");
      cell.dateLabel.center = cell.thumbnailOwe.center;

    NSLog(@"Image: %@", image);
    NSLog(@"Master: %@", info.name);


    



    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
if (scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.frame.size.height)
{
 NSLog(@"top");
}
}
- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}



-(void)viewWillDisappear:(BOOL)animated{
    
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 200.0f;
}



-  (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = nil;
  if(view == nil) {
    // This UIView will only be created for the last section of your UITableView
    FooterViewController *footer = [[FooterViewController alloc]init];
    self.footer = footer;
    view = self.footer.view;
    view.frame =  CGRectMake(0,0, view.frame.size.width, view.frame.size.height);
 //   self.tableView.backgroundColor = view.backgroundColor;
    

    
  }
    
    return view;

}

-(IBAction)addNewPerson:(id)sender{
    
    
   /* [UIView animateWithDuration:0.5
     
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:1.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self presentSemiModalViewController2:self.tdModal2];
                         self.tableView.tableFooterView.transform = CGAffineTransformMakeTranslation(0, -150);
                         
                         
                         
                         
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    */
    
    
    
    
}
- (void)handleOpenURL:(NSURL *)url {
        NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *info = [NSEntityDescription
                             insertNewObjectForEntityForName:@"OweInfo"
                             inManagedObjectContext:context];
     NSData *zippedData = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:zippedData];
    
   
    [info setValue:[[dict objectForKey:@"dateString"] stringValue] forKey:@"dateString"];
    [info setValue:[[dict objectForKey:@"name"] stringValue] forKey:@"name"];
   // [info setValue:wow forKey:@"whooweswhat"];
    [info setValue:[dict objectForKey:@"date"] forKey:@"dateowed"];
    NSLog(@"Added! :D");
       NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
   

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
    

    
    [self configureCell:cell atIndexPath:indexPath];
    cell.layer.cornerRadius = 0;
    return cell;
}




- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditViewController *edit = [[EditViewController alloc]init];
    
    NSManagedObjectContext *mo = [_fetchedResultsController objectAtIndexPath:indexPath];
    [edit setManagedObjectContext:mo];
    
    
    
    id appDelegate= [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
   
    self.editView = edit;

    
    self.editView.delegate = self;
    self.editView.info = info;
    
    edit.info = info;
    edit.delegate = self;
    edit.managedObjectContext = [appDelegate managedObjectContext];
    NSLog(@"Name to cell: %@", info.name);
    
    

    self.editView.managedObjectContext = [appDelegate managedObjectContext];
[self performSegueWithIdentifier:@"pushToEdit" sender:self];
   // [self presentViewController:self.editView animated:YES completion:nil];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"Preparing");
    if([segue.identifier  isEqual: @"pushToEdit"]){
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    EditViewController *edit = segue.destinationViewController;
    
        NSManagedObjectContext *mo = [_fetchedResultsController objectAtIndexPath:indexPath];
        [edit setManagedObjectContext:mo];

        
        id appDelegate= [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [appDelegate managedObjectContext];
        
        
        OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
            self.editView = edit;

    NSLog(@"Date from Segue: %@", info.details.date);
        self.editView.delegate = self;
        self.editView.info = info;
    self.editView.managedObjectContext = self.managedObjectContext;
    edit.managedObjectContext = self.managedObjectContext;
    
        edit.info = info;
        edit.delegate = self;
      //  edit.managedObjectContext = [appDelegate managedObjectContext];
        NSLog(@"Name to cell: %@", info.name);
        self.zoomTransition.sourceView = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // pass the custom transition to the destination controller
        // so it can use it when setting up its gesture recognizers
        [[segue destinationViewController] setGestureTarget:self.zoomTransition];
        
        
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
    }
    
  //  [segue destinationViewController].info = info;
    //[segue destinationViewController].delegate = self;

    
}


- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)aPopoverController
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)aPopoverController
{
    if (aPopoverController == popoverController)
    {
        SelectionViewController *selectionViewController = [[SelectionViewController alloc]init];
        
        selectionViewController.delegate = nil;
        
        popoverController.delegate = nil;
        popoverController = nil;
    }

}


- (void)inputViewController:(SelectionViewController *)controller

{
    controller.delegate = nil;
    [popoverController dismissPopoverAnimated:YES];
    popoverController.delegate = nil;
    popoverController = nil;
}



-(void)setOwedItem:(id)owedItem{
    if (_owedItem == owedItem) {
        _owedItem = owedItem;
    }
}



-(void)goBack{
    
    self.view.transform = CGAffineTransformIdentity;
}

-(IBAction)showPeople:(id)sender{
       NSLog(@"Moved");
}


-(UIViewController*) getRootViewController {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}




-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Payed!";
}
#define kCellHeight 75;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int rowHeight;
    if ([indexPath row] == currentSelection) {
        rowHeight = 250;
    } else rowHeight = kCellHeight;
    return rowHeight;
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    // Return whether the cell at the specified index path is selected or not
    NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}
- (BOOL)cellIsSelected2:(NSIndexPath *)indexPath {
    // Return whether the cell at the specified index path is selected or not
    NSNumber *selectedIndex2 = [selectedIndexes2 objectForKey:indexPath];
    return selectedIndex2 == nil ? FALSE : [selectedIndex2 boolValue];
}


+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

- (IBAction)addAPerson:(id)sender {
    
    NSString *title;
    if (self.titleSegmentedControl.selectedSegmentIndex == 0) {
        title = @"This is a title!";
    }
    
 
    self.addPerson = [[IBActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"I owe", @"Someone owes me", nil];
    
    [self.addPerson setButtonBackgroundColor:[UIColor colorWithRed:0.1765 green:0.1765 blue:0.1765 alpha:1.0]];
    [self.addPerson setButtonTextColor:[UIColor whiteColor]];
    self.addPerson.buttonResponse = IBActionSheetButtonResponseHighlightsOnPress;
    [self.addPerson setButtonHighlightTextColor:[UIColor whiteColor]];
    [self.addPerson setButtonHighlightBackgroundColor:[UIColor colorWithRed:0.1765 green:0.1765 blue:0.1765 alpha:1.0]];
    [self.addPerson showInView:self.view];
}

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    InputViewController *inputView = [[InputViewController alloc]init];
    _inputViewController = inputView;
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    _inputViewController = [storyboard instantiateViewControllerWithIdentifier:@"InputViewController"];
    [_inputViewController setModalPresentationStyle:UIModalPresentationFullScreen];
    if (buttonIndex == 0) {
        
        [_inputViewController setDetailItem:@"NotOwed"];
    NSLog(@"selected notowed");
        
    }else if(buttonIndex == 1){
               [_inputViewController setDetailItem:@"Owed"];
        
           NSLog(@"selected owed");
    }
   
  
    
  [self presentViewController:_inputViewController animated:YES completion:nil];
    
}



@end
