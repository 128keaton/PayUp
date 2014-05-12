//
//  PaymentViewController.m
//  IO
//
//  Created by Keaton Burleson on 5/11/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "PaymentViewController.h"
#import "PayPal.h"
#import "PayPalPayment.h"


#import "PayPalPayment.h"
#import "PayPalAdvancedPayment.h"
#import "PayPalAmounts.h"
#import "PayPalReceiverAmounts.h"
#import "PayPalAddress.h"
#define DEFAULT_CURRENCY = USD;
@interface PaymentViewController ()

@end

@implementation PaymentViewController
@synthesize feePayer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
        [super viewDidLoad];
    NSLog(@"Loaded!");
    payment.recipient = _recipient;
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[_money stringValue]];
    payment.subTotal = number;

   	self.payment = [[PayPalPayment alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payButton:(id)sender {
 	//dismiss any keyboards
    feePayerStrings = [NSArray arrayWithObject:@"Sender"];
	self.feePayer = [feePayerStrings objectAtIndex:0];
	//Set the PayPal payment properties to whatever was chosen
	[PayPal getPayPalInst].feePayer = feePayer;
	//[self setCurrencyCode:@"USD"];
    payment.paymentCurrency = @"USD";


		[[PayPal getPayPalInst] checkoutWithPayment:payment];
	
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
