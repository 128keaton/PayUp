//
//  PaymentViewController.h
//  IO
//
//  Created by Keaton Burleson on 5/11/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPal.h"
@interface PaymentViewController : UIViewController{
    IBOutlet UITextField *myemail;
        IBOutlet UITextField *thieremail;
    NSArray *feePayerStrings;
    	PayPalPayment *payment;
    PayPalFeePayer feePayer;
    
}
@property (nonatomic, assign) PayPalFeePayer feePayer;
@property (strong, nonatomic) id money;
@property (strong, nonatomic) id recipient;
@property (nonatomic, retain) PayPalPayment *payment;
@end
