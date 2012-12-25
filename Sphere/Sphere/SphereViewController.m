//
//  SphereViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "SphereViewController.h"
#import "MBProgressHUD.h"

@interface SphereViewController ()

@end

@implementation SphereViewController

#pragma mark IBActions

- (IBAction)loginButtonAction:(id)sender
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    
    self.HUD.delegate = self;
    
    self.HUD.dimBackground = YES;
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"Loading...";
    
    [self.HUD show:YES];
    [self facebookLogin];
}

#pragma mark view lifecycle


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark networking methods

- (void)facebookLogin
{
    __weak SphereViewController *VC = self;
    
    //facebook permissions
    NSArray *permissionArray = @[@"user_about_me", @"user_birthday", @"user_location", @"user_work_history", @"user_education_history"];
    
    //facebook login
    [PFFacebookUtils logInWithPermissions:permissionArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [self.HUD show:NO];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                [self.HUD show:NO];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            self.HUD.mode = MBProgressHUDModeCustomView;
            self.HUD.labelText = @"Completed";
            [self.HUD show:NO];
            [VC getFacebookInformation];
        } else {
            NSLog(@"User with facebook logged in!");
            self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            self.HUD.mode = MBProgressHUDModeCustomView;
            self.HUD.labelText = @"Completed";
            [self.HUD show:NO];
            [VC getFacebookInformation];
        }
    }];
}

- (void)getFacebookInformation
{
    NSString *requestPath = @"me/?fields=name,location,gender,birthday,work,education";
    
    // Send request to Facebook
    PF_FBRequest *request = [PF_FBRequest requestForGraphPath:requestPath];
    [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userData = (NSDictionary *)result; // The result is a dictionary
            
            [[SharedDocument sharedDocumentHandler] performWithDocument:^(UIManagedDocument *document) {
                ConstantsHandler *constants = [ConstantsHandler sharedConstants];
                constants.user = [User userWithFacebookInfo:userData inContext:document.managedObjectContext];
                
                //Set up interests, skills and modes for test version.
                [constants.user addHasInterestsObject:[Interest interestWithName:@"Snowboarding" inContext:document.managedObjectContext]];
                [constants.user addHasInterestsObject:[Interest interestWithName:@"Programming" inContext:document.managedObjectContext]];
                [constants.user addHasInterestsObject:[Interest interestWithName:@"Partying" inContext:document.managedObjectContext]];
                
                [constants.user addHasSkillsObject:[Skill skillWithName:@"iOS development" inContext:document.managedObjectContext]];
                [constants.user addHasSkillsObject:[Skill skillWithName:@"Software Architecture" inContext:document.managedObjectContext]];
                
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }];
        }
    }];
}

@end
