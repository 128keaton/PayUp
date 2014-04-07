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
#import "TDSemiModal.h"
#import "AppDelegate.h"
#import "OweTableViewCell.h"
#import "FooterViewController.h"


@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize managedObjectContext;
// At top, under @implementation
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize name = _name1;
@synthesize date = _date1;
@synthesize dateOwed = _dateOwed1;
@synthesize money = _money1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)setDataItem:(NSString *)name :(NSString *)money :(NSDate *)date :(BOOL)dateOwed :(NSString *)whooweswhat :(NSString *)dateString
{
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    if (_money1 != money) {
        _money1 = money;
    }
    if (_date1 != date) {
        _date1 = date;
    }
    if (_name1 != name) {
        _name1 = name;
    }
    if (_dateOwed1 != dateOwed) {
        _dateOwed1 = dateOwed;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
     NSLog(@"TEH CONTEXT: %@", context);
    OweInfo *oweInfo = [NSEntityDescription
                        insertNewObjectForEntityForName:@"OweInfo"
                        inManagedObjectContext:context];
    oweInfo.name = name;
    oweInfo.dateowed = [NSNumber numberWithBool:dateOwed];
    OweDetails *oweDetails = [NSEntityDescription
                              insertNewObjectForEntityForName:@"OweDetails"
                              inManagedObjectContext:context];
    oweInfo.whooweswhat = whooweswhat;
    oweDetails.date = date;
    oweDetails.money = money;
    oweInfo.dateString = dateString;
    oweDetails.info = oweInfo;
    oweInfo.details = oweDetails;
    
    
     NSLog(dateOwed ? @"Yes" : @"No");
    
     NSLog(oweInfo.dateowed.boolValue ? @"Yes" : @"No");
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    
    
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.managedObjectContext deleteObject:object];
    
    // Save
    NSError *error;
    if ([self.managedObjectContext save:&error] == NO) {
        // Handle Error.
    }
}


-(void)setData:(NSString *)name :(NSString *)money :(NSDate *)date :(BOOL)dateOwed :(NSString *)whooweswhat :(NSString *)dateString{
    NSLog(dateOwed ? @"Yes" : @"No");
    [self setDataItem:name :money :date :dateOwed :whooweswhat :dateString];
  
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}



- (void)InputViewControllerDidCancel:(InputViewController *)controller
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    self.title = @"Owed";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;


    

    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

   


}
-(IBAction)test:(id)sender{
   
    
    NSLog(@"Tapped!");
    
    //    [self.view addSubview:test.view];
    //[self presentSemiModalViewController2:self.tdModal2];
    
    self.tdModal2 = [[TDSemiModalViewController2 alloc]init];
    

    //    [self.view addSubview:test.view];
    [self presentSemiModalViewController2:self.tdModal2];

}
-(void)addSemi{
    
    self.tdModal2 = [[TDSemiModalViewController2 alloc]init];
    
    
    //    [self.view addSubview:test.view];
    [self presentSemiModalViewController2:self.tdModal2];
}



-(void)viewWillDisappear:(BOOL)animated{
    
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    
}
- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 200.0f;
}

-  (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = nil;
    //if (section == [tableView numberOfSections] - 1) {
        // This UIView will only be created for the last section of your UITableView
        FooterViewController *footer = [[FooterViewController alloc]init];
    self.footer =footer;
        view = self.footer.view;
        view.frame =  CGRectMake(0,500, view.frame.size.width, view.frame.size.height + 200);
        self.tableView.backgroundColor = view.backgroundColor;
 
       // [view setBackgroundColor:[UIColor redColor]];
  //  }
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"OweCell";
    
    OweTableViewCell *cell = (OweTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell.contentView.layer setCornerRadius:7.0f];
    [cell.contentView.layer setMasksToBounds:YES];
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.layer.masksToBounds = YES;
    cell.nameLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];
        cell.dateLabel.font = [UIFont fontWithName:@"ClearSans-Thin" size:10];
    cell.moneyLabel.font = [UIFont fontWithName:@"ClearSans-Regular" size:12];
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    separatorLineView.backgroundColor = [UIColor clearColor]; // set color as you want.
    [cell.contentView addSubview:separatorLineView];
    
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *testBool = (info.dateowed.boolValue ? @"Yes" : @"No");
    OweDetails *details = info.details;
    
    
if ([testBool isEqualToString:@"Yes"]) {
              cell.dateLabel.text = info.dateString;
        
        cell.nameLabel.text = info.name;
    }else{
        cell.dateLabel.text = @"No due date";
        
        cell.nameLabel.text = info.name;
    }
     NSLog(@"Master Input: %@",info.whooweswhat);
    if ([info.whooweswhat isEqualToString:@"someoneowes"]) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ owes you.", info.name];
    }else{
            cell.nameLabel.text = [NSString stringWithFormat:@"You owe %@.", info.name];
    }
 
        
          cell.moneyLabel.text = [NSString stringWithFormat:@"%@", details.money];
    
     //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
 
 
    

    NSDate *today = [NSDate date]; // it will give you current date
     // your date
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:details.date]; // comparing two dates
    
    if(result==NSOrderedAscending)
        NSLog(@"We are good");
        else if(result==NSOrderedDescending)
      cell.thumbnailOwe.image = [UIImage imageNamed:@"Red.png"];
    else
        NSLog(@"Both dates are same");
    

    
       // Set up the cell...
 //   [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
        OweDetails *details = info.details;
        self.detailViewController.detailItem = info.name;
        [self.detailViewController setDetailItem:info.name];
        [self.detailViewController setDateItem:details.date];
        [self.detailViewController setMoneyItem:details.money];
        [[segue destinationViewController] setDetailItem:info.name];
                [[segue destinationViewController] setMoneyItem:details.money];
            [[segue destinationViewController] setDateItem:info.dateString];
        NSLog(@"WASABI: %@", info.name);

    }
}
-(IBAction)ptestModel:(id)sender{
    [self presentSemiModalViewController:self.tdModal];
}
-(void)presentInput{
    
      [self performSegueWithIdentifier: @"Input" sender: self];
}

-(void)dismissSemiMD{
     TDSemiModalViewController2 *MDV = [[TDSemiModalViewController2 alloc]init];
    [self dismissSemiModalViewController:MDV];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSLog(@"I tapped myself!");

        OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    self.tdModal = [[TDSemiModalViewController alloc]init];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    OweDetails *details = info.details;
    [self.tdModal setDetailItem:info.name];
    [self.tdModal setMoneyItem:details.money];
//    [self.view addSubview:test.view];
    [self presentSemiModalViewController:self.tdModal];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

@end
