//
//  OweTableViewCell.h
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//


#import "SWTableViewCell.h"
#import "OweDetails.h"
#import "OweInfo.h"
@interface TodayTableViewCell : UITableViewCell
    
  
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *moneyLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailOwe;
@property (nonatomic, weak) IBOutlet UILabel *untilDate;
@property (nonatomic, weak) IBOutlet UILabel *flippedDateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *contactImage;
@end
