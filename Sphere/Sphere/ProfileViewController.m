//
//  ProfileViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/4/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "ProfileViewController.h"

#import "UIImage+Resizing.h"
#import "UIImage+ScaleAndCrop.h"

@interface ProfileViewController ()

@property (nonatomic, strong) ConstantsHandler *constants;

@end

@implementation ProfileViewController

- (ConstantsHandler *)constants
{
    if (!_constants) {
        _constants = [ConstantsHandler sharedConstants];
    }
    return _constants;
}

#pragma mark IBActions

- (void)popController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark view lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupMainLayout];
    
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    
    self.profilePictureImageView.image = [[UIImage imageWithData:self.constants.user.image] scaleAndCropToFit:(60.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    self.profilePictureImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.profilePictureImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.profilePictureImageView.layer.shadowOpacity = 1.0;
    self.profilePictureImageView.layer.shadowRadius = 7.0;
    self.profilePictureImageView.clipsToBounds = NO;
    
    self.nameLabel.text = self.constants.user.name;
    self.nameLabel.textColor = self.constants.COLOR_WHITE;
    self.ageLabel.text = [NSString stringWithFormat:@"%@", self.constants.user.age];
    self.ageLabel.textColor = self.constants.COLOR_WHITE;
    self.studyLabel.text = self.constants.user.education;
    self.studyLabel.textColor = self.constants.COLOR_WHITE;
    self.workLabel.text = self.constants.user.work;
    self.workLabel.textColor = self.constants.COLOR_WHITE;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark constructor methods

- (void)setupMainLayout
{
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.titleView = [UIView customTitle:@"Profile" withColor:[[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE] inFrame:self.navigationItem.titleView.frame];
    [self setupBarButtonItems];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_LINEN_PATTERN];
}

- (void)setupBarButtonItems
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [backButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(popController:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileCell"];
    }
    return cell;
}

- (void)resetInterface
{
}

@end
