//
//  OweTableViewCell.h
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "OweDetails.h"
#import "OweInfo.h"
@interface OweTableViewCell : SWTableViewCell{
 
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
    

}
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *moneyLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailOwe;
@property (nonatomic, weak) IBOutlet UILabel *untilDate;
@property (nonatomic, weak) IBOutlet UIImageView *contactImage;
@property (nonatomic, weak) IBOutlet UILabel *flippedDateLabel;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, strong) IBOutlet UIView *flipView;
@property (strong, nonatomic) id detailItem;
//@property (strong, nonatomic) OweInfo *info;
//@property (strong, nonatomic) OweDetails *details;
@property (strong, nonatomic) NSDate* dateItem;
@property (strong, nonatomic) NSString* owed;
@property (strong, nonatomic) NSString* dateString;
//@property (nonatomic, strong) UIView *coverView;
//@property (nonatomic) UIDatePicker *picker;
//@property (nonatomic, retain) IBOutlet UILabel *name;
//@property (nonatomic) IBOutlet UINavigationItem *navBar;
- (void)setDetailItem:(id)newDetailItem;

//@property (nonatomic, strong) IBOutlet id delegate;
//@property (strong, nonatomic) NSDate *storageDate;
//@property (nonatomic, strong) IBOutlet UILabel *money;


//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//-(void)setupEdit;
@end
