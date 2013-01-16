//
//  DatabaseFake.h
//  Sphere
//
//  Created by Søren Bruus Frank on 1/16/13.
//  Copyright (c) 2013 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseFake : NSObject

+ (DatabaseFake *)sharedDatabase;

@property (strong, nonatomic) NSArray *usersInProximity;

@end
