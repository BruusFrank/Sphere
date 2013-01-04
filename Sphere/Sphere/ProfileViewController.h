//
//  ProfileViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/4/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConstantsHandler.h"
#import "UIView+CustomTitleView.h"
#import "Skill+Create.h"
#import "Interest+Create.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hometownLabel;
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (nonatomic, retain) UIView *headerView;
@property (weak, nonatomic) IBOutlet UITextField *statementTextField;
@property (weak, nonatomic) IBOutlet UIButton *editTableViewButton;
@property (weak, nonatomic) IBOutlet UIScrollView *profileScrollView;

@end
