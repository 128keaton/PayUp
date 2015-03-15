//
//  TodayViewController.m
//  PayUp-Today
//
//  Created by Keaton Burleson on 3/12/15.
//  Copyright (c) 2015 Revision. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "OweDetails.h"
#import "OweInfo.h"
#import "AppDelegate.h"
#import "TodayTableViewCell.h"
#import "PersistentStack.h"
@interface TodayViewController () <NCWidgetProviding, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>{
    NSUInteger placeToInsert;
}
@property (strong, nonatomic) NSArray *peopleArray;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) PersistentStack *persistentStack;

@end

@implementation TodayViewController


@synthesize managedObjectContext = managedObjectContext;

@synthesize managedObjectModel = managedObjectModel;

@synthesize persistentStoreCoordinator = persistentStoreCoordinator;


NSUInteger count;
#define NUMBER_OF_STATIC_CELLS  1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    
    self.managedObjectContext = self.persistentStack.managedObjectContext;
    [self.managedObjectContext setRetainsRegisteredObjects:YES];
    self.preferredContentSize = self.tableView.frame.size;
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }else{
        NSLog(@"Fetched successfully");
        
    }
    

 
    // Do any additional setup after loading the view from its nib.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    
    completionHandler(NCUpdateResultNewData);
}


-(void) viewDidAppear:(BOOL)animated{
    self.preferredContentSize=self.tableView.contentSize;
}
-(void)viewWillAppear:(BOOL)animated{
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:0
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:self.tableView.contentSize.height];
    heightConstraint.priority = UILayoutPriorityRequired;
    
    [self.view addConstraint:heightConstraint];
    [self.view needsUpdateConstraints];
    [self.view setNeedsLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

         
    static NSString *CellIdentifier = @"OweCell";
    
        
    
    TodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"TodayViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OweCell"];
    
    
    [self configureCell:cell atIndexPath:indexPath];
 
    
      NSLog(@"Cell exists: %@", cell);
    
    
    
    return cell;
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
        id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];

        NSLog(@"People Array: %lu", (unsigned long)[sectionInfo numberOfObjects]);
        count = [sectionInfo numberOfObjects];
        
        return count;
    
 }



- (void)configureCell:(TodayTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

  
        
 
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.nameLabel.text = info.name;
    
    OweDetails *details = info.details;

          UIImage *image = [UIImage imageWithData:details.image];
    
    
    
    
    if (image != nil) {
        UIImage *contactImage = [UIImage imageWithData:[details valueForKey:@"image"]];
        cell.contactImage.image = contactImage;
        
        cell.contactImage.layer.cornerRadius = 25;
    }else{
        
        cell.contactImage.image = [UIImage imageNamed:@"user_white.png"];
        cell.contactImage.layer.cornerRadius = 25;
    }

    
    
    if ([info.whooweswhat isEqualToString:@"someoneowes"]) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ owes you.", info.name];
   
        
          }else{
        cell.nameLabel.text = [NSString stringWithFormat:@"You owe %@.", info.name];
        
     
    }
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@", details.money];
    
    NSDate *today = [NSDate date];
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
    result = [today compare:details.date]; // comparing two dates
    cell.contactImage.layer.masksToBounds = YES;
    
    cell.dateLabel.text = info.dateString;
    
    }

    

    
    
    


- (void)userDefaultsDidChange:(NSNotification *)notification {

    [self.tableView reloadData];
}





- (NSURL*)storeURL
{
    //NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    // return [documentsDirectory URLByAppendingPathComponent:@"WhatIOwe.sqlite"];
    NSURL *directory = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.bittank.io"];
    NSURL *storeURL = [directory  URLByAppendingPathComponent:@"WhatIOwe.sqlite"];
    
    
    
    return  storeURL;
    
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"WhatIOwe" withExtension:@"momd"];
}





- (NSFetchedResultsController *)fetchedResultsController {

    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    
    self.managedObjectContext = self.persistentStack.managedObjectContext;

    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIButton *openButton = [[UIButton alloc]initWithFrame:CGRectMake(footerView.frame.origin.x, footerView.frame.origin.y, 300, 30)];
    [footerView addSubview:openButton];
    
    return footerView;
}



-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURL *pjURL = [NSURL URLWithString:@"payup://"];
    [self.extensionContext openURL:pjURL completionHandler:nil];
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
            [self configureCell: (TodayTableViewCell*) [tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            
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


+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{

    
#ifdef __IPHONE_8_0
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return [difference day];

    
    
#else
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit fromDate:fromDate toDate:toDate options:0];
     return [difference day];
#endif
    
    return 0;
}






@end
