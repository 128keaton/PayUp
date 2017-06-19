//
//  DateViewController.m
//  
//
//  Created by Keaton Burleson on 9/30/14.
//
//

#import "DatePickerViewController.h"
#import "EditViewController.h"
@interface DatePickerViewController ()
@property (strong, nonatomic)EditViewController *editView;
@end

@implementation DatePickerViewController

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"Date Picker: %@", self.date);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIDatePicker *myPicker = self.picker;
    [myPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    myPicker.date = [NSDate date];
    EditViewController *editView = [[EditViewController alloc]init];
    self.editView = editView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)pickerChanged:(id)sender
{
    self.date = [sender date];
    [self setDate:[sender date]];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[sender date] forKey:@"pickerDate"];
    NSLog(@"picker changed: %@", [sender date]);
    [defaults synchronize];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
