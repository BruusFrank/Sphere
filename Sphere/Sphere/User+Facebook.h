//
//  User+Facebook.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "User.h"

@interface User (Facebook)

+ (User *)userWithFacebookInfo:(NSDictionary *)facebookInfo
                     inContext:(NSManagedObjectContext *)context;

@end
