//
//  StyleController.m
//  IO
//
//  Created by Keaton Burleson on 9/18/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "StyleController.h"

@implementation StyleController
@synthesize style = _style;

-(void)applyStyle
{
   // StyleController *controller = [[StyleController alloc]init];

    //NSLog(_style);
    if ([_style  isEqual: @"Blue"]){
        UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
        [navigationBarAppearance setBackgroundColor:[UIColor colorWithRed:0.1843 green:0.5216 blue:0.6392 alpha:1.0]];
        [navigationBarAppearance setTintColor:[UIColor whiteColor]];
       
    }else if ([_style  isEqual: @"Red"]){
        UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
        [navigationBarAppearance setBackgroundColor:[UIColor colorWithRed:0.9059 green:0.2157 blue:0.2706 alpha:1.0]];
        [navigationBarAppearance setTintColor:[UIColor whiteColor]];
        
    }else if ([_style isEqual:@"Green"]){
        
        UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
        [navigationBarAppearance setBackgroundColor:[UIColor colorWithRed:0.1294 green:0.1412 blue:0.1882 alpha:1.0]];
        [navigationBarAppearance setTintColor:[UIColor whiteColor]];
        
        
         }
}
@end
