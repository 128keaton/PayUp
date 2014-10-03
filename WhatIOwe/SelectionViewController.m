//
//  SelectionViewController.m
//  IO
//
//  Created by Keaton Burleson on 10/1/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "SelectionViewController.h"
#import "InputViewController.h"
#import "WYPopoverController.h"
#import "MasterViewController.h"
@interface SelectionViewController ()

@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)NotOwed:(id)sender{
 
    NSLog(@"Not owed");
    [self.delegate inputViewController:self];
}

-(IBAction)Owed:(id)sender{
    InputViewController *inputView = [[InputViewController alloc]init];
    self.inputViewController = inputView;
    
    
    [_inputViewController setDetailItem:@"Owed"];

                         [self presentViewController:_inputViewController animated:YES completion:nil];
                         
                         
                         
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.delegate inputViewController:self];

    
    
}
    // do any setup you need for myNewVC}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
