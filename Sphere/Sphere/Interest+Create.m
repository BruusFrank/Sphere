//
//  Interest+Create.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "Interest+Create.h"

@implementation Interest (Create)

+ (Interest *)interestWithName:(NSString *)interestName
                     inContext:(NSManagedObjectContext *)context
{
    Interest *interest = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Interest"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", interestName];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
        
    if (!matches || [matches count] > 1) {
        //Handle error.
    } else if (![matches count]) {
        //Create the user.
        interest = [NSEntityDescription insertNewObjectForEntityForName:@"Interest" inManagedObjectContext:context];
        interest.name = interestName;
    } else {
        interest = [matches lastObject];
        interest.name = interestName;
    }
    
    return interest;
}

@end
