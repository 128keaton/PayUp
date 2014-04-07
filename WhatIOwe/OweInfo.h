//
//  OweInfo.h
//  WhatIOwe
//
//  Created by Keaton Burleson on 4/4/14.
//  Copyright (c) 2014 Revision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OweDetails;

@interface OweInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * dateowed;
@property (nonatomic, retain) OweDetails *details;

@end
