//
//  User.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/20/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Interest, Mode, Skill;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * quote;
@property (nonatomic, retain) NSString * education;
@property (nonatomic, retain) NSString * work;
@property (nonatomic, retain) NSNumber * broadcasting;
@property (nonatomic, retain) NSNumber * contactable;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSSet *hasInterests;
@property (nonatomic, retain) NSSet *hasSkills;
@property (nonatomic, retain) NSSet *hasModes;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addHasInterestsObject:(Interest *)value;
- (void)removeHasInterestsObject:(Interest *)value;
- (void)addHasInterests:(NSSet *)values;
- (void)removeHasInterests:(NSSet *)values;

- (void)addHasSkillsObject:(Skill *)value;
- (void)removeHasSkillsObject:(Skill *)value;
- (void)addHasSkills:(NSSet *)values;
- (void)removeHasSkills:(NSSet *)values;

- (void)addHasModesObject:(Mode *)value;
- (void)removeHasModesObject:(Mode *)value;
- (void)addHasModes:(NSSet *)values;
- (void)removeHasModes:(NSSet *)values;

@end
