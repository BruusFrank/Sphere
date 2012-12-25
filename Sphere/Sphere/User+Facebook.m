//
//  User+Facebook.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/25/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "User+Facebook.h"

@implementation User (Facebook)

NSMutableData *imageData;
User *user;

+ (User *)userWithFacebookInfo:(NSDictionary *)facebookInfo
                     inContext:(NSManagedObjectContext *)context
{
    user = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", [facebookInfo objectForKey:@"name"]];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
        
    if (!matches || [matches count] > 1) {
        //Handle error.
    } else if (![matches count]) {
        //Create the user.
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [user updateWithUserInformation:facebookInfo];
    } else {
        user = [matches lastObject];
        [user updateWithUserInformation:facebookInfo];
    }
    
    return user;
}

- (void)updateWithUserInformation:(NSDictionary *)information
{
    user.name = [information objectForKey:@"name"];
//    user.age;
//    user.work;
//    user.education;
    
    // Download the user's facebook profile picture
    imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
    
    // URL should point to https://graph.facebook.com/{facebookId}/picture?type=large&return_ssl_resources=1
    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", [information objectForKey:@"id"]]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:2.0f];
    // Run network request asynchronously
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDelegate

// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    user.image = imageData;
}

@end
