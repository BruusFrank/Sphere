//
//  Mode+Create.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "Mode+Create.h"

@implementation Mode (Create)

+ (Mode *)modeWithName:(NSString *)modeName
             withImage:(UIImage *)modeImage
             inContext:(NSManagedObjectContext *)context
{
    Mode *mode = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Mode"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", modeName];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || [matches count] > 1) {
        //Handle error.
    } else if (![matches count]) {
        //Insert the new mode.
        mode = [NSEntityDescription insertNewObjectForEntityForName:@"Mode" inManagedObjectContext:context];
        mode.name = modeName;
        mode.image = UIImagePNGRepresentation(modeImage);
    } else {
        return [matches lastObject];
    }
    
    return mode;
}

@end
