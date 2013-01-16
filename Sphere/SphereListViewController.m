//
//  SphereListViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "SphereListViewController.h"
#import "SphereUserCell.h"
#import "MenuTableViewCellView.h"
#import "UserInfoView.h"

#import "UIImage+Resizing.h"
#import "UIImage+ScaleAndCrop.h"

#import "ConstantsHandler.h"
#import "SharedDocument.h"

@interface SphereListViewController ()

@property (nonatomic, strong) ConstantsHandler *constants;

@end

@implementation SphereListViewController

- (ConstantsHandler *)constants
{
    if (!_constants) {
        _constants = [ConstantsHandler sharedConstants];
    }
    return _constants;
}

//***Menu***

NSDictionary *sharing;
NSDictionary *mode;
NSDictionary *filters;

NSArray *menuSections;

//Classwide variables.
BOOL menuShown = NO;
BOOL cellExpanded = NO;
dispatch_queue_t fetchQ = NULL;

#pragma mark IBActions

- (void)showMenuAction:(id)sender
{
    [self toggleMenuAnimated:YES];
}

- (void)showSettingsAction:(id)sender
{
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
}

- (void)sphereRequest:(UIButton *)sender
{
    sender.enabled = NO;
}

- (void)acceptAction:(UIButton *)sender
{
    [[sender superview] setHidden:YES];
}

- (void)denyAction:(UIButton *)sender
{
    [[sender superview] setHidden:YES];
}


#pragma mark initiation methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(objectsDidChange:)
                                                 name:NSManagedObjectContextObjectsDidChangeNotification
                                               object:[SharedDocument sharedDocumentHandler].document.managedObjectContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetInterface)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    self.sphereUserTableView.dataSource = self;
    self.sphereUserTableView.delegate = self;
    
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    self.statementTextField.delegate = self;
        
    [self setupMainLayout];
    
    fetchQ = dispatch_queue_create("fetchQ", NULL);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
        
    [self setupMenu];
    [self resetInterface];
    [self resetMenuText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark constructor methods

- (void)setupMainLayout
{
    [[ConstantsHandler sharedConstants] setNavigationBarLayoutWithNavigtionController:self WithTitle:@"Sphere"];
    [self setupBarButtonItems];
    
    self.sphereUserTableView.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    
    //EGORefresh
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.sphereUserTableView.bounds.size.height, self.view.frame.size.width, self.sphereUserTableView.bounds.size.height)];
		view.delegate = self;
		[self.sphereUserTableView addSubview:view];
		_refreshHeaderView = view;
	}
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)setupMenu
{
    [self.menuNavigationBar setBackgroundImage:[UIImageView gradientTextureWithFrame:self.menuNavigationBar.bounds withImage:[UIImage imageNamed:@"navbar_bg.png"]].image forBarMetrics:UIBarMetricsDefault];
    self.menuNavigationItem.titleView = [UIView customTitle:@"Quick settings" withColor:[ConstantsHandler sharedConstants].COLOR_WHITE inFrame:self.navigationItem.titleView.frame];
    
    self.menuUserPicture.image = [[UIImage imageWithData:self.constants.user.image] scaleAndCropToFit:(60.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    self.menuUserPicture.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menuUserPicture.layer.shadowOffset = CGSizeMake(0, 0);
    self.menuUserPicture.layer.shadowOpacity = 1.0;
    self.menuUserPicture.layer.shadowRadius = 7.0;
    self.menuUserPicture.clipsToBounds = NO;
    
    self.menuUsername.text = self.constants.user.name;
    self.menuUsername.textColor = self.constants.COLOR_WHITE;
    
    if (![self.constants.user.statement isEqual:@""] && self.constants.user.statement) {
        self.statementTextField.placeholder = self.constants.user.statement;
    }
    
    sharing = [[NSDictionary alloc] initWithObjectsAndKeys:@"Social level", @"name", [[NSArray alloc] initWithObjects:@"Broadcast", @"Come talk to me!", nil], @"listItems", nil];
    mode = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mode", @"name", self.constants.modes, @"listItems", nil];
    filters = [[NSDictionary alloc] initWithObjectsAndKeys:@"Filters", @"name", [[NSArray alloc] initWithObjects:@"Age", @"Gender", nil], @"listItems", nil];
    
    menuSections = [[NSArray alloc] initWithObjects:sharing, mode, filters, nil];
}

- (void)setupBarButtonItems
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [leftButton setImage:[UIImage imageNamed:@"three_lines.png"] forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [rightButton setImage:[UIImage imageNamed:@"cogwheel.png"] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:@selector(showSettingsAction:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)resetInterface
{
    if (menuShown) {
        [self toggleMenuAnimated:NO];
    }
    [self.menuTableView reloadData];
    
    [self.sphereUserTableView setContentOffset:CGPointMake(0.0f, -65.0f) animated:NO];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.sphereUserTableView];
}

- (void)resetMenuText
{
    NSString *tags = @"";
    NSArray *interests = [self.constants.user.hasInterests allObjects];
    if ([self.constants.activeMode.mainCellShows isEqual:@"skills"]) {
        interests = [self.constants.user.hasSkills allObjects];
    }
    
    for (int i = 0; i < [interests count]; i++) {
        if (i != 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        tags = [tags stringByAppendingString:[(Interest *)[interests objectAtIndex:i] name]];
    }
    self.menuTags.text = tags;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 2) {
        return [menuSections count];
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return [[menuSections objectAtIndex:section] objectForKey:@"name"];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return [[[menuSections objectAtIndex:section] objectForKey:@"listItems"] count];
    }
    return [[DatabaseFake sharedDatabase].usersInProximity count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Handle the different tableviews.
    if (tableView.tag == 2) {
        return [self menuTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return [self sphereUserTableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark UITableView handling methods

- (UITableViewCell *)sphereUserTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"sphereUserCell";
    SphereUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SphereUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *concreteUser = [[DatabaseFake sharedDatabase].usersInProximity objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [concreteUser objectForKey:@"name"];
    cell.nameLabel.textColor = [UIColor darkTextColor];
    
    //Concatenate tags into one string.
    NSString *tagsString = @"";
    NSArray *tags = [concreteUser objectForKey:self.constants.activeMode.mainCellShows];
    
    for (int i = 0; i < tags.count; i++) {
        if (i < tags.count - 1) {
            tagsString = [tagsString stringByAppendingFormat:@"%@, ", [tags objectAtIndex:i]];
        }else{
            tagsString = [tagsString stringByAppendingFormat:@"%@", [tags objectAtIndex:i]];
        }
    }
    
    cell.tagsLabel.text = tagsString;
    
    //Scale and crop the picture.
    cell.userPicture.image = [[concreteUser objectForKey:@"picture"] scaleAndCropToFit:(60.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    //For expanding.
    cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.clipsToBounds = YES;
    
    cell.accessory.image = [UIImage imageNamed:@"cell_accessory_down.png"];
    
    if ([[concreteUser objectForKey:@"contactable"] integerValue] == 1) {
        cell.smiley.image = [UIImage imageNamed:@"smiley.png"];
    }else{
        cell.smiley.image = nil;
    }
    
    //Reset the cell.
    while ([[cell.expandView subviews] count] > 5) {
        [[[cell.expandView subviews] lastObject] removeFromSuperview];
    }
    [cell.expandView addSubview:[[UserInfoView alloc] initWithFrame:CGRectMake(0.0f, 70.0f, 320.0f, 290.0f)
                                                       withUserInfo:concreteUser
                                                       buttonTarget:self]];
    
    
    //If the cell is selected.
    if ([self.selectedRow isEqual:indexPath]) {
        cell.accessory.image = [UIImage imageNamed:@"cell_accessory_up.png"];
        cell.expandView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_teeth.png"]];
        cell.nameLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
        
        UIView *teethBottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 343.0f, 320.0f, 18.0f)];
        teethBottom.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_bottom.png"]];
        [cell.expandView addSubview:teethBottom];
    }
    
    return cell;
}

- (UITableViewCell *)menuTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
        
    NSString *cellTitle = nil;
    UIImage *cellImage = nil;
    
    Mode *mode = nil;
    
    if (indexPath.section == 1) {
        mode = [[[menuSections objectAtIndex:indexPath.section] objectForKey:@"listItems"] objectAtIndex:indexPath.row];
        cellTitle = mode.name;
        cellImage = [UIImage imageWithData:mode.image];
        if ([mode.isActive boolValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cellTitle = [[[menuSections objectAtIndex:indexPath.section] objectForKey:@"listItems"] objectAtIndex:indexPath.row];
    }
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:cellTitle, @"title", cellImage, @"image", nil];
    
    for (int i = 2; i < [[cell subviews] count]; i++) {
        [[[cell subviews] objectAtIndex:i] removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                [cell insertSubview:[[MenuTableViewCellView alloc] initWithFrame:cell.bounds cellType:CellTypeSharing cellData:data switchState:[[ConstantsHandler sharedConstants].user.broadcasting boolValue] delegate:self tag:indexPath.row] atIndex:2];
            } else if (indexPath.row == 1) {
                [cell insertSubview:[[MenuTableViewCellView alloc] initWithFrame:cell.bounds cellType:CellTypeSharing cellData:data switchState:[[ConstantsHandler sharedConstants].user.contactable boolValue] delegate:self tag:indexPath.row] atIndex:2];
            }
            break;
        case 1:
            [cell insertSubview:[[MenuTableViewCellView alloc] initWithFrame:cell.bounds cellType:CellTypeMode cellData:data switchState:NO delegate:self tag:indexPath.row] atIndex:2];
            break;
        case 2:
            [cell insertSubview:[[MenuTableViewCellView alloc] initWithFrame:cell.bounds cellType:CellTypeFilter cellData:data switchState:NO delegate:self tag:indexPath.row] atIndex:2];
            break;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
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
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return 40.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        [self tableView:tableView animateCellAtIndexPath:indexPath expand:![self.selectedRow isEqual:indexPath]];
    }else if(tableView.tag == 2){
        if (indexPath.section == 1) {
            Mode *mode = [[[menuSections objectAtIndex:indexPath.section] objectForKey:@"listItems"] objectAtIndex:indexPath.row];
            self.constants.activeMode = mode;
            self.constants.user.broadcasting = mode.broadcasting;
            self.constants.user.contactable = mode.contactable;
            [self resetMenuText];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        [self tableView:tableView animateCellAtIndexPath:indexPath expand:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        if(self.selectedRow && [self.selectedRow isEqual:indexPath]) {
            return 360;
        }
        return 60;
    }
    return 44;
}

#pragma mark animation

- (void)tableView:(UITableView *)tableView animateCellAtIndexPath:(NSIndexPath *)indexPath expand:(BOOL)expand
{
    SphereUserCell *cell = (SphereUserCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (expand) {
        self.selectedRow = indexPath;
        
        cell.accessory.image = [UIImage imageNamed:@"cell_accessory_up.png"];
        cell.expandView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_teeth.png"]];
        cell.nameLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
        
        UIView *teethBottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, 320.0f, 18.0f)];
        teethBottom.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_bottom.png"]];
        [cell.expandView addSubview:teethBottom];
        
        [UIView animateWithDuration:0.3
                              delay: 0.0
                            options: UIViewAnimationCurveLinear
                         animations:^{
                             teethBottom.frame = CGRectMake(0.0f, 343.0f, 320.0f, 18.0f);
                         }
                         completion:^(BOOL finished){
                             [self.sphereUserTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
                         }];
        [UIView commitAnimations];
    }else{
        cell.accessory.image = [UIImage imageNamed:@"cell_accessory_down.png"];
        cell.nameLabel.textColor = [UIColor darkTextColor];
        
        if ([[cell.expandView subviews] count] > 6) {
            UIView *teethBottom = [[cell.expandView subviews] lastObject];
            
            [UIView animateWithDuration:0.29
                                  delay: 0.0
                                options: UIViewAnimationCurveLinear
                             animations:^{
                                 teethBottom.frame = CGRectMake(0.0f, 60.0f, 320.0f, 18.0f);
                             }
                             completion:^(BOOL finished){
                                 cell.expandView.backgroundColor = [UIColor clearColor];
                                 while ([[cell.expandView subviews] count] > 6) {
                                     [[[cell.expandView subviews] lastObject] removeFromSuperview];
                                 }
                             }];
            [UIView commitAnimations];
            
            self.selectedRow = nil;
        }
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    sleep(1);
	_reloading = YES;	
}

- (void)doneLoadingTableViewData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectedRow = nil;
        [self.sphereUserTableView reloadData];
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.sphereUserTableView];
    });
}


#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    dispatch_async(fetchQ, ^{
        [self reloadTableViewDataSource];
        [self doneLoadingTableViewData];
    });
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqual:@""]) {
        self.constants.user.statement = textField.text;
        
        textField.placeholder = textField.text;
        textField.text = @"";
    }
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UIMovement methods

- (CGRect)moveFrame:(CGRect)frame
{
    CGFloat toggle = 260.0f;
    
    if (menuShown) {
        toggle = -260.0f;
    }
    
    frame = CGRectMake(frame.origin.x + toggle, frame.origin.y, frame.size.width, frame.size.height);
    return frame;
}

- (void) toggleMenuAnimated:(BOOL)animated
{
    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.17f];
    }
    
    self.navigationController.navigationBar.frame = [self moveFrame:self.navigationController.navigationBar.frame];
    self.sphereUserTableView.frame = [self moveFrame:self.sphereUserTableView.frame];
    
    menuShown = !menuShown;
    
    if (menuShown) {
        [self.sphereUserTableView setUserInteractionEnabled:NO];
    }else{
        [self.sphereUserTableView setUserInteractionEnabled:YES];
        [self.statementTextField resignFirstResponder];
        
        [self resetInterface];
    }
    
    if (animated) {
        [UIView commitAnimations];
    }
}

- (void)flip:(UISwitch *)sender
{
    if (sender.tag == 0) {
        [ConstantsHandler sharedConstants].user.broadcasting = [NSNumber numberWithBool:sender.on];
    } else if (sender.tag == 1) {
        [ConstantsHandler sharedConstants].user.contactable = [NSNumber numberWithBool:sender.on];
    }
}

#pragma mark NSNotificationCenter

- (void)objectsDidChange:(NSNotification *)notification
{
    [self.menuTableView reloadData];
    [self.menuTableView setNeedsDisplay];
}

@end
