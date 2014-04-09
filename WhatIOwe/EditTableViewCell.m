//
//  EditTableViewCell.m
//  OweIt
//
//  Created by Keaton Burleson on 4/9/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "EditTableViewCell.h"

@implementation EditTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
