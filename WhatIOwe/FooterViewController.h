//
//  FooterViewController.h
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDSemiModalViewController2.h"
@interface FooterViewController : UIViewController{
    IBOutlet UIButton *button;
}

@property (strong, nonatomic) TDSemiModalViewController2 *tdModal2;

@end
