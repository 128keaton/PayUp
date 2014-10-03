//
//  OweTableViewCell.m
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "OweTableViewCell.h"
#import "SWTableViewCell.h"
@implementation OweTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


/*- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        //iterate through subviews until you find the right one...
        for(UIView *subview2 in subview.subviews){
            if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
                //your color
                ((UIView*)[subview2.subviews firstObject]).backgroundColor=[UIColor colorWithRed:0.5922 green:0.7098 blue:0.1882 alpha:1.0];
  
            }
        }
    }
}
 
 -(void)layoutSubviews
 {
 
 }
 
-(void)recurseAndReplaceSubViewIfDeleteConfirmationControl:(NSArray*)subviews{

    for (UIView *subview in subviews)
    {
               //the rest handles ios7
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationButton"])
        {
            UIButton *deleteButton = (UIButton *)subview;
                      [deleteButton setTitle:@"Payed" forState:UIControlStateNormal];
            [deleteButton setBackgroundColor:[UIColor colorWithRed:0.5922 green:0.7098 blue:0.1882 alpha:1.0]];
            [deleteButton setFrame:CGRectMake(0, 0, 40, 75)];
           NSLog(@"width = %f, height = %f", deleteButton.frame.size.width, deleteButton.frame.size.height);
            for(UIView* view in subview.subviews){
                if([view isKindOfClass:[UILabel class]]){
                    [view removeFromSuperview];
                }
            }
        }
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"])
        {
            UIButton *deleteButton = (UIButton *)subview;
 
            [deleteButton setTitle:@"Payed" forState:UIControlStateNormal];
            [deleteButton setBackgroundColor:[UIColor colorWithRed:0.5922 green:0.7098 blue:0.1882 alpha:1.0]];
    
            [deleteButton setTintColor:[UIColor colorWithRed:0.5922 green:0.7098 blue:0.1882 alpha:1.0]];
                    [deleteButton setFrame:CGRectMake(0, 0, 40, 75)];
            for(UIView* innerSubView in subview.subviews){
                if(![innerSubView isKindOfClass:[UIButton class]]){
                    [innerSubView removeFromSuperview];
                }
            }
        }
        if([subview.subviews count]>0){
            [self recurseAndReplaceSubViewIfDeleteConfirmationControl:subview.subviews];
        }
        
    }
}*/

- (void)awakeFromNib
{
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

    






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
