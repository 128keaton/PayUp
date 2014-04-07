//
//  TDSemiModalViewController.h
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputViewController.h"
@interface TDSemiModalViewController2 : UIViewController{
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
}
    


@property (nonatomic, strong) UIView *coverView;
@property (strong, nonatomic) InputViewController *tdModal;
@end
