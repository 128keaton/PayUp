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
#import "OweTableViewCell.h"
#import "MasterViewController.h"
@interface TodayViewController () <NCWidgetProviding, UITableViewDataSource, UITableViewDelegate>

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
    cell.textLabel.text = [localList objectAtIndex:indexPath.row];

    
  
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}




@end
