//
//  SphereAppDelegate.m
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Parse/Parse.h>

#import "SphereAppDelegate.h"

@implementation SphereAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self customizeAppearance];
    
#pragma mark Parse
    
    //Parse credentials
    [Parse setApplicationId:@"gsrs0BrZGIoYKjZp8iX7Tc7vV8K2vmXYt8mwVyTI"
                  clientKey:@"6F3TH85bQbx73OEHLtVhZ1Zr90L1rGmWQd9o8TEY"];
    
    //Facebook inizialisation
    [PFFacebookUtils initializeWithApplicationId:@"138960536257020"];
    
    return YES;
}

// ****************************************************************************
// App switching methods to support Facebook Single Sign-On
// ****************************************************************************

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)customizeAppearance
{
    UIImage *transparent = [UIImage imageNamed:@"transparent.png"];
    
    [[UISegmentedControl appearance] setBackgroundImage:transparent forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:transparent forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"transparent_div"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"transparent_div"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //Text color for segmented control
    NSDictionary *textAttributesSelected = [NSDictionary dictionaryWithObjectsAndKeys:[ConstantsHandler sharedConstants].COLOR_CYANID_BLUE,
                                            UITextAttributeTextColor,
                                            [UIColor colorWithWhite:1 alpha:0],
                                            UITextAttributeTextShadowColor,
                                            [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                                            UITextAttributeTextShadowOffset,
                                            [UIFont fontWithName:@"Thonburi" size:14.0f],
                                            UITextAttributeFont,
                                            
                                            nil];
    
    NSDictionary *textAttributesNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],
                                          UITextAttributeTextColor,
                                          [UIColor colorWithWhite:1 alpha:0],
                                          UITextAttributeTextShadowColor,
                                          [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                                          UITextAttributeTextShadowOffset,
                                          [UIFont fontWithName:@"Thonburi" size:14.0f],
                                          UITextAttributeFont,
                                          
                                          nil];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:textAttributesNormal forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:textAttributesSelected forState:UIControlStateSelected];
}

@end
