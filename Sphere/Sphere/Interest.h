//
//  Interest.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/20/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Interest : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) User *isInterestOfUser;

@end
