//
//  Mode.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/27/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Mode : NSManagedObject

@property (nonatomic, retain) NSNumber * broadcasting;
@property (nonatomic, retain) NSNumber * contactable;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * showAge;
@property (nonatomic, retain) NSNumber * showEducation;
@property (nonatomic, retain) NSNumber * showInterests;
@property (nonatomic, retain) NSNumber * showQuote;
@property (nonatomic, retain) NSNumber * showSkills;
@property (nonatomic, retain) NSNumber * showWork;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSString * mainCellShows;
@property (nonatomic, retain) User *isModeOfUser;

@end
