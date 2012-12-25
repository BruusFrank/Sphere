//
//  Skill+Create.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "Skill.h"

@interface Skill (Create)

+ (Skill *)skillWithName:(NSString *)skillName
                     inContext:(NSManagedObjectContext *)context;

@end
