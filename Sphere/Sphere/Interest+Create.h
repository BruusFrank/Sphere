//
//  Interest+Create.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "Interest.h"

@interface Interest (Create)

+ (Interest *)interestWithName:(NSString *)interestName
                     inContext:(NSManagedObjectContext *)context;

@end
