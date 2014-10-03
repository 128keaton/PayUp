//
//  DateViewController.h
//  
//
//  Created by Keaton Burleson on 9/30/14.
//
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"


@interface DatePickerViewController : UIViewController
@property (strong, nonatomic)IBOutlet UIDatePicker *picker;
@property (strong, nonatomic)IBOutlet UIToolbar *whatATool;
@property (strong, nonatomic)NSDate *date;
@end
