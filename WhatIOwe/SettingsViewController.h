//
//  SettingsViewController.h
//  IO
//
//  Created by Keaton Burleson on 9/16/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {

    IBOutlet UIButton *chooseName;
    IBOutlet UIButton *chooseTheme;
    IBOutlet UIView *flipView;
    IBOutlet UIView *normalView;
    IBOutlet UIView *iCloudView;
    IBOutlet UIView *nameView;
    IBOutlet UIView *themeView;
    NSString *defaultColor;
    UIToolbar *pickerToolbar;
    IBOutlet UIImageView *blurriedImage;
    IBOutlet UIImageView *circleImage;
    UIButton *addButton;
     int selectedCell;
    NSArray *quotesArray;
    IBOutlet UITextView *quotes;
}
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet      UIPickerView *picker;
@property (strong, nonatomic)          NSArray *colorArray;
@property (strong, nonatomic) NSString *styleChosen;
@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;

@end
