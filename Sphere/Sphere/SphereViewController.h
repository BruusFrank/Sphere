//
//  SphereViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "MBProgressHUD.h"

#import "User+Facebook.h"
#import "Interest+Create.h"
#import "Skill+Create.h"
#import "Mode+Create.h"
#import "ConstantsHandler.h"
#import "SharedDocument.h"

@interface SphereViewController : UIViewController <MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;

@end
