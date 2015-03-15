//
//  OweTableViewCell.m
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import "TodayTableViewCell.h"

@implementation TodayTableViewCell

@synthesize nameLabel = _nameLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.nameLabel.textColor = [UIColor whiteColor];
        
            [self.contentView addSubview:self.nameLabel];
    }
    
    return self;
}



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
