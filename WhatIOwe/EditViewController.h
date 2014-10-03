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
#import "LCZoomTransition.h"

@class DatePickerViewController;

@interface EditViewController : UIViewController <MFMailComposeViewControllerDelegate, WYPopoverControllerDelegate, UITextFieldDelegate>{
    
    IBOutlet UILabel *iLabel;
    IBOutlet UILabel *oLabel;
    IBOutlet UILabel *mLabel;
    IBOutlet UINavigationItem *navBar;
    //    id delegate;
    IBOutlet UIStepper *stepper;
    IBOutlet UITextField *oField;
    IBOutlet UITextField *iField;
  //  IBOutlet UITextField *dueField;
    IBOutlet UIView *view1;
    IBOutlet UITextField *wField;
    BOOL tapped;
    IBOutlet UIView *view3;
    IBOutlet UIButton *alarm;
    IBOutlet UIView *view2;
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
@property (nonatomic, strong) id<LCZoomTransitionGestureTarget> gestureTarget;
@property (nonatomic, retain) MasterViewController *master;
@property (nonatomic, strong) IBOutlet id delegate;
@property (strong, nonatomic) NSDate *storageDate;
@property (nonatomic, strong) IBOutlet UILabel *money;
@property(strong, nonatomic) DatePickerViewController *datePickerViewController;
-(void)updateTextField:(NSDate *)pickerDate;
@property(strong, nonatomic) IBOutlet UITextField *dueField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
