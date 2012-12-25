//
//  Skill+Create.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "Skill+Create.h"

@implementation Skill (Create)

+ (Skill *)skillWithName:(NSString *)skillName
               inContext:(NSManagedObjectContext *)context
{
    Skill *skill = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Skill"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", skillName];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
        
    if (!matches || [matches count] > 1) {
        //Handle error.
    } else if (![matches count]) {
        //Create the user.
        skill = [NSEntityDescription insertNewObjectForEntityForName:@"Skill" inManagedObjectContext:context];
        skill.name = skillName;
    } else {
        skill = [matches lastObject];
        skill.name = skillName;
    }
    
    return skill;
}

@end
