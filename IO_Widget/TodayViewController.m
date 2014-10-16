//
//  TodayViewController.m
//  IO_Widget
//
//  Created by Keaton Burleson on 9/22/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "OweDetails.h"
#import "OweInfo.h"
#import "EditTableViewCell.h"

#import "MasterViewController.h"
#import "OweInfo.h"
#import "OweDetails.h"
@interface TodayViewController () <NCWidgetProviding, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) MasterViewController *master;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:5];
    [mutableArray addObject:@"asdjasdj"];
    [mutableArray addObject:@"qowiepqiw"];
    [mutableArray addObject:@"qoqwoei"];
    [mutableArray addObject:@"pqoiweoqi"];
    [mutableArray addObject:@"lkdsflk"];
    [mutableArray addObject:@"kdjlkaj"];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
    widgetArray = [userDefaults objectForKey:@"name"];

 //   CoreDa
    localList = [widgetArray copy];
    NSLog(@"hello world!");
    NSLog(@"%lu", (unsigned long)widgetArray.count);
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

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setPreferredContentSize:CGSizeMake(self.view.bounds.size.width, 50)];
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self.tableView reloadData];
      NSUserDefaults *userDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.bittank.io"];
    if (_fetchedResultsController != [userDefaults objectForKey:@"array"]) {
        _fetchedResultsController = [userDefaults objectForKey:@"array"];
    }
}

- (void)updateNumberLabelText {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.iodefaults"];
        NSString *name = [userDefaults objectForKey:@"name"];
    [widgetArray addObject:name];
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    [self.tableView reloadData];
    completionHandler(NCUpdateResultNewData);
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return localList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = [localList objectAtIndex:indexPath.row];

    [self configureCell:cell atIndexPath:indexPath];
  
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    
    
    OweInfo *info = [self.master.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    OweDetails *details = info.details;
    
    

    
    
    
    

    
    if ([info.whooweswhat isEqualToString:@"someoneowes"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ owes you.", info.name];
        
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"You owe %@.", info.name];
        
      
         }
    
   /* cell.moneyLabel.text = [NSString stringWithFormat:@"%@", details.money];
    
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
    
    
    
    */
    
    
    
    
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

- (NSArray *)getItems
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    return [[self managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}

/*- (NSFetchedResultsController *)fetchedResultsController {
    id thedelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [thedelegate managedObjectContext];
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OweInfo" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"details.date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

*/


/*-(void)f {
    if !_fetchedResultsController {
        // set up fetch request
        var fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(kEntityNameNoteEntity, inManagedObjectContext: self.coreDataProvider.managedObjectContext)
        
        // sort by last updated
        var sortDescriptor = NSSortDescriptor(key: "modifiedAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = kMaxCellCount
        
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataProvider.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        _fetchedResultsController!.delegate = self
    }
    
    return _fetchedResultsController!
}
var _fetchedResultsController: NSFetchedResultsController? = nil

*/

@end
