//
//  FooterViewController.h
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDSemiModalViewController2;
@class MasterViewController;
@interface FooterViewController : UIViewController{
    IBOutlet UIButton *button;
    id footercontroller;
}

@property (strong, nonatomic) TDSemiModalViewController2 *tdModal2;
@property  (nonatomic) CGPoint originalCenter;
@property (nonatomic, strong)id footercontroller;
@property (strong, nonatomic) MasterViewController *test;
@property (strong, nonatomic) UIDynamicAnimator *animator;
-(void)moveBack;

@end
