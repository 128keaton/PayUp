//
//  SelectionViewController.h
//  IO
//
//  Created by Keaton Burleson on 10/1/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"
#import "MasterViewController.h"
#import "WYPopoverController.h"
@protocol SelectionViewControllerDelegate;

@interface SelectionViewController : UIViewController <WYPopoverControllerDelegate>{
    WYPopoverController *popoverController;
    
    
}
@property (strong, nonatomic)InputViewController *inputViewController;

@property (strong, nonatomic) MasterViewController *masterViewController;



@property (nonatomic, weak) id <SelectionViewControllerDelegate> delegate;
@end

@protocol SelectionViewControllerDelegate <NSObject>

@optional

- (void)inputViewController:(SelectionViewController *)controller;
@end