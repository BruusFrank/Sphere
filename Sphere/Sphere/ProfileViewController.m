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

NSArray *cellTitlesArray;
int editInt;

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
    if (editInt == 1) {
        [self.profileTableView setEditing:YES animated:YES];
        [self.editTableViewButton setImage:[UIImage imageNamed:@"save_button.png"] forState:UIControlStateNormal];
        editInt = 0;
    } else {
        [self.profileTableView setEditing:NO animated:YES];
        [self.editTableViewButton setImage:[UIImage imageNamed:@"edit_button.png"] forState:UIControlStateNormal];
        editInt = 1;
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
    NSArray *skillsArray = [[ConstantsHandler sharedConstants].user.hasSkills allObjects];
    NSArray *interestsArray = [[ConstantsHandler sharedConstants].user.hasInterests allObjects];
    
    cellTitlesArray = [NSArray arrayWithObjects:skillsArray, interestsArray, nil];
    
    editInt = 1;
    
    [self setupMainLayout];
    
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    self.statementTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    
    [self.profileScrollView setContentSize:CGSizeMake(self.profileScrollView.frame.size.width, 596)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark constructor methods

- (void)setupMainLayout
{
    ConstantsHandler *constants = [ConstantsHandler sharedConstants];
    [constants setNavigationBarLayoutWithNavigtionController:self WithTitle:@"Your profile"];
    
    [self setupBarButtonItems];
    
    self.view.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_LINEN_PATTERN];
    
    self.profilePictureImageView.image = [[UIImage imageWithData:self.constants.user.image] scaleAndCropToFit:(60.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    self.profilePictureImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.profilePictureImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.profilePictureImageView.layer.shadowOpacity = 1.0;
    self.profilePictureImageView.layer.shadowRadius = 7.0;
    self.profilePictureImageView.clipsToBounds = NO;
    
    CGSize maxSize = CGSizeMake(189.0f, 30.0f);
    CGSize studySize = [self.constants.user.education sizeWithFont:[UIFont fontWithName:@"thonburi" size:12.0f] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    CGSize workSize = [self.constants.user.work sizeWithFont:[UIFont fontWithName:@"thonburi" size:12.0f] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *studyLabel = [[UILabel alloc] initWithFrame:CGRectMake(99.0f, 98.0f, studySize.width, studySize.height)];
    UILabel *workLabel = [[UILabel alloc] initWithFrame:CGRectMake(99.0f, 129.0f, workSize.width, workSize.height)];
    
    self.nameLabel.text = self.constants.user.name;
    self.nameLabel.textColor = self.constants.COLOR_WHITE;
    self.ageLabel.text = [NSString stringWithFormat:@"%@", self.constants.user.age];
    self.ageLabel.textColor = self.constants.COLOR_WHITE;
    
    studyLabel.text = self.constants.user.education;
    studyLabel.textColor = self.constants.COLOR_WHITE;
    studyLabel.backgroundColor = [UIColor clearColor];
    studyLabel.numberOfLines = 3;
    studyLabel.font = [UIFont fontWithName:@"thonburi" size:12.0f];
    workLabel.text = self.constants.user.work;
    workLabel.textColor = self.constants.COLOR_WHITE;
    workLabel.backgroundColor = [UIColor clearColor];
    workLabel.numberOfLines = 3;
    workLabel.font = [UIFont fontWithName:@"thonburi" size:12.0f];;
    
    [self.profileScrollView addSubview:studyLabel];
    [self.profileScrollView addSubview:workLabel];
    
    self.hometownLabel.text = self.constants.user.hometown;
    
    if (![self.constants.user.statement isEqualToString:@""] && self.constants.user.statement) {
        self.statementTextField.placeholder = self.constants.user.statement;
    }
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
    return [[cellTitlesArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileCell"];
    }

    NSManagedObject *obj = [[cellTitlesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 1) {
        Skill *skill = (Skill *)obj;
        cell.textLabel.text = skill.name;
    } else {
        Interest *interest = (Interest *)obj;
        cell.textLabel.text = interest.name;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"thonburi" size:16.0f];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Interests";
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
