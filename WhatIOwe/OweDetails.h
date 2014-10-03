//
//  OweDetails.h
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OweInfo;

@interface OweDetails : NSManagedObject

@property (nonatomic, retain) NSString * alert;
@property (nonatomic, retain) NSString * money;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic) Boolean hasImage;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) OweInfo *info;

@end
