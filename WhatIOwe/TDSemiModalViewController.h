//
//  TDSemiModalViewController.h
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSemiModalViewController : UIViewController{
    IBOutlet UILabel *name;
    IBOutlet UILabel *money;
    IBOutlet UINavigationItem *navBar;
      id delegate;
    IBOutlet UIStepper *stepper;
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSString* moneyItem;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UINavigationItem *navBar;
- (void)setDetailItem:(id)newDetailItem;
- (void)setMoneyItem:(NSString*)newMoneyItem;
@property (nonatomic, strong) IBOutlet id delegate;
@property (nonatomic, strong) IBOutlet UIStepper *stepper;
@property (nonatomic, strong) IBOutlet UILabel *money;
@end
