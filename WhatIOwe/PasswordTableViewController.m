//
//  PasswordTableViewController.m
//  PayUp
//
//  Created by Keaton Burleson on 3/16/15.
//  Copyright (c) 2015 Revision. All rights reserved.
//

#import "PasswordTableViewController.h"

@interface PasswordTableViewController () <UIAlertViewDelegate>{
    
    BOOL touchIDOn;
    BOOL passwordOn;
    NSString *password;
    IBOutlet UILabel *passwordStatusLabel;
    IBOutlet UILabel *passwordChangeLabel;
    IBOutlet UILabel *touchIDStatusLabel;
    UIAlertView *passwordChangeAlert;
    UIAlertView *passwordAlert;
    UIAlertView *passwordTurnOffAlert;
    IBOutlet UITableViewCell *changePasswordCell;
    IBOutlet UITableViewCell *touchIDCell;
}


@end

@implementation PasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


        [self configureView];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)configureView{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    touchIDOn = [defaults boolForKey:@"touchIDOn"];
    passwordOn = [defaults boolForKey:@"passwordOn"];
    password = [defaults objectForKey:@"password"];

    if ([defaults objectForKey:@"password"] ==nil) {
        touchIDCell.userInteractionEnabled = NO;
        changePasswordCell.userInteractionEnabled = NO;
        touchIDStatusLabel.textColor = [UIColor lightGrayColor];
        passwordChangeLabel.textColor = [UIColor lightGrayColor];
        
    
    }else if ([defaults objectForKey:@"password"] != nil){
        touchIDCell.userInteractionEnabled = YES;
        changePasswordCell.userInteractionEnabled = YES;
        touchIDStatusLabel.textColor = passwordStatusLabel.textColor;
        passwordChangeLabel.textColor = passwordStatusLabel.textColor;
        
    }
    
    if (passwordOn == YES){
        
        passwordStatusLabel.text = @"Turn Password Off";
        
    }else if (passwordOn == NO){
        passwordStatusLabel.text = @"Turn Password On";
        
    }
    
    if (touchIDOn == YES){
        touchIDStatusLabel.text = @"Turn Touch ID Off";
        
    }else if (touchIDOn == NO){
        touchIDStatusLabel.text = @"Turn Touch ID On";
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];

    if (indexPath.row == 0) {
    
            if (passwordOn == YES) {
                passwordOn = NO;
                
                [self showTurnOffPasswordAlert];
                
            }else if (passwordOn == NO){
                [self showChangePasswordAlert];
                passwordOn = YES;
            }
            [defaults setBool:passwordOn forKey:@"passwordOn"];
            [defaults synchronize];
            [self configureView];
        
    }else if (indexPath.row == 1){
        [self showPasswordAlert];
    }else if (indexPath.row == 2){
        if (touchIDOn == YES) {
            touchIDOn = NO;
        }else if (touchIDOn == NO){
            touchIDOn = YES;
        }
        [defaults setBool:touchIDOn forKey:@"touchIDOn"];

        [self configureView];
    }
    [defaults setBool:false forKey:@"drugCheck"];
    [defaults synchronize];

          [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(IBAction)goBackToSettings:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showPasswordAlert{
    passwordAlert = [[UIAlertView alloc]initWithTitle:@"Password" message:@"Input Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    passwordAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [passwordAlert show];
}
-(void)showTurnOffPasswordAlert{
    passwordTurnOffAlert = [[UIAlertView alloc]initWithTitle:@"Password" message:@"Input Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    passwordTurnOffAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [passwordTurnOffAlert show];
}



-(void)showChangePasswordAlert{
    passwordChangeAlert = [[UIAlertView alloc]initWithTitle:@"New Password" message:@"Change Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    passwordChangeAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [passwordChangeAlert show];
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
                NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bittank.io"];
    if (alertView == passwordChangeAlert) {
     
    if (buttonIndex == 1) {
        if (![[alertView textFieldAtIndex:0].text isEqual:@""]) {
            NSString *passwordTextFromAlertView = [alertView textFieldAtIndex:0].text;
            [defaults setBool:false forKey:@"drugCheck"];
            [defaults setObject:passwordTextFromAlertView forKey:@"password"];
            [defaults synchronize];
            NSLog(@"Changed password to %@", passwordTextFromAlertView);
            [self configureView];
        
            }
        }
    }else if (alertView == passwordAlert){
        if (buttonIndex == 1) {
            if (![[alertView textFieldAtIndex:0].text isEqual:@""]) {
                NSString *passwordTextFromAlertView = [alertView textFieldAtIndex:0].text;
                if ([passwordTextFromAlertView isEqual:[defaults objectForKey:@"password"]] ) {
                    [self showChangePasswordAlert];
                }else{
                    [self showPasswordAlert];
                      NSLog(@"Failed %@ doesnt match %@", passwordTextFromAlertView, [defaults objectForKey:@"password"]);
                }
                
                
            }
        }
    }else if (alertView == passwordTurnOffAlert){
        if (buttonIndex == 1) {
            if (![[alertView textFieldAtIndex:0].text isEqual:@""]) {
                NSString *passwordTextFromAlertView = [alertView textFieldAtIndex:0].text;
                if ([passwordTextFromAlertView isEqual:[defaults objectForKey:@"password"] ]) {
                    touchIDCell.userInteractionEnabled = NO;
                    changePasswordCell.userInteractionEnabled = NO;
                    touchIDStatusLabel.textColor = [UIColor lightGrayColor];
                    passwordChangeLabel.textColor = [UIColor lightGrayColor];
                    [defaults setBool:false forKey:@"drugCheck"];
 
                    [defaults setObject:nil forKey:@"password"];
                    [defaults setBool:NO forKey:@"passwordOn"];
                    [defaults synchronize];
                    
               
                }else{
                    NSLog(@"Failed %@ doesnt match %@", passwordTextFromAlertView, [defaults objectForKey:@"password"]);
                    [self showTurnOffPasswordAlert];
                    
                    
                }
                
                
            }
        }
    }

}




@end
