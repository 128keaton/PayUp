//
//  TDSemiModalViewController.h
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OweInfo.h"
#import "OweDetails.h"
@class MasterViewController;
@interface TDSemiModalViewController : UIViewController{
    IBOutlet UILabel *iLabel;
    IBOutlet UILabel *oLabel;
        IBOutlet UILabel *mLabel;
    IBOutlet UINavigationItem *navBar;
  //    id delegate;
    IBOutlet UIStepper *stepper;
    IBOutlet UITextField *oField;
       IBOutlet UITextField *iField;
       IBOutlet UITextField *dueField;
    IBOutlet UIView *view1;
    
    IBOutlet UIView *view3;
    IBOutlet UIView *view2;
    OweInfo *info;
    OweDetails *details;
    NSManagedObjectContext *managedObjectContext;
   
    
    
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) OweInfo *info;
@property (strong, nonatomic) OweDetails *details;
@property (strong, nonatomic) NSDate* dateItem;
@property (strong, nonatomic) NSString* owed;
@property (strong, nonatomic) NSString* dateString;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UINavigationItem *navBar;
- (void)setDetailItem:(id)newDetailItem;
@property (nonatomic, retain) MasterViewController *master;
- (void)setMoneyItem:(NSString*)newMoneyItem;
@property (nonatomic, strong) IBOutlet id delegate;
@property (nonatomic, strong) IBOutlet UIStepper *stepper;
@property (nonatomic, strong) IBOutlet UILabel *money;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
