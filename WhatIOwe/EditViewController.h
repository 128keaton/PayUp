//
//  EditViewController.h
//  IO
//
//  Created by Keaton Burleson on 9/27/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//
#import "OweDetails.h"
#import "OweInfo.h"
#import "MasterViewController.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "WYPopoverController.h"
#import "DatePickerViewController.h"

@class MasterViewController;
@class DatePickerViewController;

@interface EditViewController : UIViewController <MFMailComposeViewControllerDelegate, WYPopoverControllerDelegate, UITextFieldDelegate>{
    

    IBOutlet UINavigationItem *navBar;
    //    id delegate;
    IBOutlet UITextField *dateField;
    IBOutlet UITextField *moneyField;
    IBOutlet UITextField *nameField;
  //  IBOutlet UITextField *dueField;
    IBOutlet UIView *view1;
    IBOutlet UITextField *reasonField;
    BOOL tapped;
    IBOutlet UIView *view3;
    IBOutlet UIButton *alarm;

    NSString *name2;
    NSString *datestring;
    NSString *moneystring;
    NSDate *date;
    OweInfo *info;
    OweDetails *details;
    NSManagedObjectContext *managedObjectContext;
    WYPopoverController *popoverController;
    DatePickerViewController *datePicker;
    CGRect originalFrame;
    CGPoint originalPoint;
    
   IBOutlet UILabel *nameLabel;
   IBOutlet    UILabel *moneyLabel;
   IBOutlet   UILabel *reasonLabel;
   IBOutlet   UILabel *dateLabel;
    
}


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) OweInfo *info;
@property (strong, nonatomic) OweDetails *details;
@property (strong, nonatomic) NSDate* dateItem;
@property (strong, nonatomic) NSString* owed;
@property (strong, nonatomic) NSString* dateString;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic) UIDatePicker *picker;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic) IBOutlet UINavigationItem *navBar;
- (void)setDetailItem:(id)newDetailItem;

@property (nonatomic, retain) MasterViewController *master;
@property (nonatomic, strong) IBOutlet id delegate;
@property (strong, nonatomic) NSDate *storageDate;
@property (nonatomic, strong) IBOutlet UILabel *money;
@property(strong, nonatomic) DatePickerViewController *datePickerViewController;
-(void)updateTextField:(NSDate *)pickerDate;
@property(strong, nonatomic) IBOutlet UITextField *dueField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
