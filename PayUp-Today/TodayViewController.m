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
@property (strong, nonatomic) NSMutableArray *todayExtensionData;


@property (nonatomic, strong) PersistentStack* persistentStack;


@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;


@end

@implementation TodayViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;




NSUInteger count;
#define NUMBER_OF_STATIC_CELLS  1

- (void)viewDidLoad {
    [super viewDidLoad];

    self.todayExtensionData = [[NSMutableArray alloc]init];
    [self performFetch];
    // Configure Managed Object Context

    
    self.preferredContentSize = self.tableView.frame.size;

  
 
    // Do any additional setup after loading the view from its nib.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    
    completionHandler(NCUpdateResultNewData);
}



-(void) viewDidAppear:(BOOL)animated{

    
    
    self.preferredContentSize=self.tableView.contentSize;
  
    
    [self performFetch];
}
-(void)performFetch{
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    NSMutableArray *todayDataArray = [[NSMutableArray alloc]initWithCapacity:[sharedUserDefaults integerForKey:@"count"]];
    if([sharedUserDefaults objectForKey:@"todayData"] != nil){
        todayDataArray = [NSMutableArray arrayWithArray:[sharedUserDefaults objectForKey:@"todayData"]];
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"NSMutableDictionary.date"
                                                     ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [todayDataArray sortedArrayUsingDescriptors:sortDescriptors];
        
        self.todayExtensionData = [sortedArray copy];
        count = [sortedArray count];
        NSLog(@"count of array: %lu", (unsigned long)sortedArray.count);
        [self.tableView reloadData];
  
   
        
        NSLog(@"It wasnt empty :D");
    }else{
        NSLog(@"Is empty");
        count = 0;
    }

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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

         
    static NSString *CellIdentifier = @"OweCell";
    
    
    TodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"TodayViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OweCell"];
    

        [self configureCell:cell atIndexPath:indexPath];



    
    
    
    return cell;
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    // Return the number of sections.
    if (count > 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    }else{
        UILabel *messageLabel = [[UILabel alloc] init];
        NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
        if ([sharedUserDefaults objectForKey:@"password"] != nil) {
    
        messageLabel.text = @"Password prevents widget from displaying";
        }else{
        messageLabel.text = @"No people found";
        }
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;

     

        self.view = [[UIView alloc]init];
        [self.view addSubview:messageLabel];
        NSLog(@"tried to make bgview");
        self.tableView.backgroundView = self.view;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return 0;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
 
    
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    
    if ([sharedUserDefaults objectForKey:@"password"] == nil) {
        NSLog(@"Stuff %lu", count);
        return count;
        
    }else{
        return 0;
    }
    
    
    
 }



- (void)configureCell:(TodayTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {


    NSMutableDictionary *objectDictionary = [[NSMutableDictionary alloc]init];
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    NSMutableArray *todayDataArray = [[NSMutableArray alloc]init];
    
    if([sharedUserDefaults objectForKey:@"todayData"] != nil){
        todayDataArray = [NSMutableArray arrayWithArray:[sharedUserDefaults objectForKey:@"todayData"]];
        objectDictionary = [todayDataArray objectAtIndex:indexPath.row];

        
  
        
     

    UIImage *image = [UIImage imageWithData:[objectDictionary objectForKey:@"contactImage"]];
    
    
    
    
    if (image != nil) {
        UIImage *contactImage = [UIImage imageWithData:[objectDictionary objectForKey:@"contactImage"]];
        
        
        cell.contactImage.image = contactImage;
        
        cell.contactImage.layer.cornerRadius = 25;
    }else{
        
        cell.contactImage.image = [UIImage imageNamed:@"user_white.png"];
        cell.contactImage.layer.cornerRadius = 25;
    }

    
    
    if ([[objectDictionary objectForKey:@"wow"] isEqualToString:@"someoneowes"]) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ owes you.", [objectDictionary objectForKey:@"name"]];
   
        
          }else{
        cell.nameLabel.text = [NSString stringWithFormat:@"You owe %@.", [objectDictionary objectForKey:@"name"]];
        
     
    }
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@", [objectDictionary objectForKey:@"money"]];
    
        
    NSDate *today = [NSDate date];
    if ([objectDictionary objectForKey:@"date"] != nil) {
        NSString *ifReplace;
        if ([[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]] > 1) {
            cell.untilDate.text = [NSString stringWithFormat:@"%ld days.", (long)[[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]]];
            
        }else if ([[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]] == 0){
            cell.untilDate.text = @"Today";
            
        }else if ([[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]] == 1){
            cell.untilDate.text = [NSString stringWithFormat:@"%ld day.", (long)[[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]]];
            
        }else if([[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]] == -1){
            ifReplace = [[NSString stringWithFormat:@"%ld day behind.", (long)[[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]]] stringByReplacingOccurrencesOfString:@"-"
                                                                                                                                                                        withString:@""];
            cell.untilDate.text = ifReplace;
            
        }else if ([[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]] <= -2 ){
            
            ifReplace = [[NSString stringWithFormat:@"%ld days behind.", (long)[[self class] daysBetweenDate:today andDate:[objectDictionary objectForKey:@"date"]]] stringByReplacingOccurrencesOfString:@"-"
                                                                                                                                                                         withString:@""];
            cell.untilDate.text = ifReplace;
            
        }
        
    }else{
        cell.untilDate.text = @"No date set";
    }
        }

    cell.contactImage.layer.masksToBounds = YES;
    cell.contactImage.layer.borderWidth = 1.0f;
    cell.contactImage.backgroundColor = [UIColor whiteColor];
    
    cell.contactImage.layer.borderColor = [UIColor whiteColor].CGColor;
     
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

  
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.managedObjectContext = self.persistentStack.managedObjectContext;

    [self.managedObjectContext setStalenessInterval:0];
    

    // Configure Managed Object Context

    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OweInfo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    
    return _fetchedResultsController;
    
}




-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];

    NSMutableDictionary *dataDictionary = [self.todayExtensionData objectAtIndex:indexPath.row];

    [defaults setObject:dataDictionary forKey:@"objectFinder"];
    [defaults setInteger:indexPath.row forKey:@"rowOfObject"];
    


    
    [defaults synchronize];
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
