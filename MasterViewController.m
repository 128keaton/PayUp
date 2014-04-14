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
#import "CSAnimationView.h"
#import "EditTableViewCell.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    self.title = @"Owed";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
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

- (void)configureCell:(OweTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    

    cell.nameLabel.font = [UIFont fontWithName:@"ClearSans-Regular" size:15];
    cell.dateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    
   cell.moneyLabel.font = [UIFont fontWithName:@"ClearSans-Thin" size:12];

    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    
  
    OweDetails *details = info.details;

    
   
  
    NSLog(@"Master Input: %@",info.whooweswhat);
    if ([info.whooweswhat isEqualToString:@"someoneowes"]) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ owes you.", info.name];
    }else{
        cell.nameLabel.text = [NSString stringWithFormat:@"You owe %@.", info.name];
    }
    
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@", details.money];
    
    NSDate *today = [NSDate date];
    // your date
    
    NSComparisonResult result;
    
    NSLog(@"Date: %@", details.date);
    NSLog(@"Money: %@", details.money);
    result = [today compare:details.date]; // comparing two dates
    
    if(result==NSOrderedAscending)
        cell.thumbnailOwe.image = [UIImage imageNamed:@"Good.png"];
    if ([info.dateString  isEqual: @""]) {
        cell.thumbnailOwe.image = [UIImage imageNamed:@"Dateless.png"];
    }
    else if(result==NSOrderedDescending){
            cell.thumbnailOwe.image = [UIImage imageNamed:@"Bad.png"];
    if ([info.dateString  isEqual: @""]) {
         cell.thumbnailOwe.image = [UIImage imageNamed:@"Dateless.png"];
    }
    } else
        NSLog(@"Both dates are same");
    
    cell.dateLabel.center = cell.thumbnailOwe.center;
    
    
    NSLog(@"Master: %@", info.name);
    

    
    
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
    
    [self configureCell:cell atIndexPath:indexPath];
    cell.layer.cornerRadius = 0;
    return cell;
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id delegate2 = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate2 managedObjectContext];
   
    OweInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    self.tdModal = [[TDSemiModalViewController alloc]init];

    
	self.tdModal.info = info;
            [self presentSemiModalViewController:self.tdModal];

  // OweTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell.listView startCanvasAnimation];
    

    



    
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
