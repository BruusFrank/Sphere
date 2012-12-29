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

- (IBAction)editTableView:(id)sender {
    if ([self.editTableViewButton.title isEqualToString:@"Save"]) {
        [self.profileTableView setEditing:NO animated:YES];
        [self.editTableViewButton setTitle:@"Edit"];
    } else {
        [self.profileTableView setEditing:YES animated:YES];
        [self.editTableViewButton setTitle:@"Save"];
    }
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
    
    if (![self.constants.user.statement isEqualToString:@""] && self.constants.user.statement) {
        self.statementTextField.placeholder = self.constants.user.statement;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    
     [self.profileScrollView setContentSize:CGSizeMake(self.profileScrollView.frame.size.width, self.profileScrollView.frame.size.height + 80)];
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

- (void)resetInterface
{
}

#pragma mark profileTableView

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Interrests";
    } else {
        return @"Skills";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 240.0f, 40.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 200.0f, 40.0f)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    headerLabel.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    headerLabel.font = [[ConstantsHandler sharedConstants] FONT_HEADER];
    
    [headerView addSubview:headerLabel];
    return headerView;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqual:@""]) {
        //Post it!
        self.constants.user.statement = textField.text;
        
        textField.placeholder = textField.text;
        textField.text = @"";
    }
    
    [textField resignFirstResponder];
    return YES;
}

@end
