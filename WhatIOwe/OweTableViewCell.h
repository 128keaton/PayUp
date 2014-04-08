//
//  OweTableViewCell.h
//  OweIt
//
//  Created by Keaton Burleson on 4/6/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OweTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *moneyLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailOwe;
@property (nonatomic, weak) IBOutlet UIView *listView;


@end
