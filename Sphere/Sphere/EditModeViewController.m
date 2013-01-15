//
//  EditModeViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/4/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "EditModeViewController.h"
#import "EditModeCell.h"
#import "ConstantsHandler.h"

@interface EditModeViewController ()

@end

@implementation EditModeViewController

NSIndexPath *selectedCell;
NSInteger pageIndex;
NSArray *modes;

NSArray *tableViewInfo;
NSArray *tableViewHeaders;

#pragma mark IBActions

- (void)popController:(id)sender
{
    if (self.settingsController) {
        [self.navigationController popToViewController:self.settingsController animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)toggleCheckbox:(UIButton *)sender
{
    if (sender.tag == 0) {
        //Not checked, check it.
        sender.tag = 1;
        [sender setBackgroundImage:[UIImage imageNamed:@"selected_checkbox.png"] forState:UIControlStateNormal];
        NSLog(@"check");
    }else{
        //Checked, uncheck it.
        sender.tag = 0;
        [sender setBackgroundImage:[UIImage imageNamed:@"not_selected_checkbox.png"] forState:UIControlStateNormal];
        NSLog(@"uncheck");
    }
}

#pragma mark property getters

- (NSMutableArray *)modeImages
{
    if (!_modeImages) {
        _modeImages = [[NSMutableArray alloc] init];
    }
    return _modeImages;
}

- (NSMutableArray *)modeTitles
{
    if (!_modeTitles) {
        _modeTitles = [[NSMutableArray alloc] init];
    }
    return _modeTitles;
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
    
    //Placeholder information:
    NSString *pInfo = [NSString stringWithFormat:@"%@ from %@", [ConstantsHandler sharedConstants].user.age, [ConstantsHandler sharedConstants].user.hometown];
    NSString *eInfo = @"";
    
    if ([ConstantsHandler sharedConstants].user.education) {
        eInfo = [ConstantsHandler sharedConstants].user.education;
    } else if ([ConstantsHandler sharedConstants].user.work) {
        eInfo = [ConstantsHandler sharedConstants].user.work;
    } else {
        eInfo = @"Your education and work information.";
    }
    NSDictionary *personalInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"Personal: ", @"title", pInfo, @"subtitle", nil];
    NSDictionary *employmentInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"Study/Work: ", @"title", eInfo, @"subtitle", nil];
    NSDictionary *statement = [[NSDictionary alloc] initWithObjectsAndKeys:@"Statement: ", @"title", [ConstantsHandler sharedConstants].user.statement, @"subtitle", nil];
    
    tableViewInfo = [NSArray arrayWithObjects:personalInfo, employmentInfo, statement, nil];
    tableViewHeaders = [NSArray arrayWithObjects:@"What do you want to share?", @"Skills", @"Interests", @"Social level", nil];
    
    self.modesCollection.dataSource = self;
    self.modesCollection.delegate = self;
    
    self.editModeTableView.dataSource = self;
    self.editModeTableView.delegate = self;
    
    NSSortDescriptor *activeDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"isActive" ascending:NO];
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:activeDescriptor, nameDescriptor, nil];
    modes = [[[(User *)[[ConstantsHandler sharedConstants] user] hasModes] allObjects].mutableCopy sortedArrayUsingDescriptors:descriptors];
        
    [self setupMainLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    [self resetInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark constructor methods

- (void)setupMainLayout
{
    [[ConstantsHandler sharedConstants] setNavigationBarLayoutWithNavigtionController:self WithTitle:@"Edit modes"];
    [self setupBarButtonItems];
    
    self.modeCollectionContainer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_bg"]];
    
    self.view.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_LINEN_PATTERN];
    self.cellStyleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_style_bg.png"]];
    
    [self.segmentedControl addTarget:self
                              action:@selector(segmentedControlValueChanged:)
                    forControlEvents:UIControlEventValueChanged];
    
    //Setup the background of scroll offset above tableview.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -200.0f, 320.0f, 200.0f)];
    view.backgroundColor = [ConstantsHandler sharedConstants].COLOR_WHITE;
    [self.editModeTableView addSubview:view];
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
    pageIndex = 0;
    selectedCell = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self resetViewData];
}

- (void)resetViewData
{
    if ([[ConstantsHandler sharedConstants].activeMode.mainCellShows isEqual:@"interests"]) {
        self.segmentedControl.selectedSegmentIndex = 0;
    } else {
        self.segmentedControl.selectedSegmentIndex = 1;
    }
    
    [self.editModeTableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tableViewHeaders objectAtIndex:section];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"editModeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *cellInfo = [tableViewInfo objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    cell.textLabel.text = cellInfo[@"title"];
    
    cell.detailTextLabel.text = cellInfo[@"subtitle"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"helvetica" size:12.0f];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    UIButton *checkbox = [[UIButton alloc] initWithFrame:CGRectMake(10,12,20,20)];
    
    [checkbox setBackgroundImage:[UIImage imageNamed:@"not_selected_checkbox.png"]
                        forState:UIControlStateNormal];
    
    [checkbox addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.tag = 0;
    [cell addSubview:checkbox];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 240.0f, 20.0f)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 2.0f, 200.0f, 20.0f)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [ConstantsHandler sharedConstants].COLOR_WHITE;
    headerLabel.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    headerLabel.font = [ConstantsHandler sharedConstants].FONT_SECTION_TITLE_UNGROUPED;
    
    [headerView addSubview:headerLabel];
    return headerView;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numberOfModes = [[[(User *)[[ConstantsHandler sharedConstants] user] hasModes] allObjects] count];
    int numberOfSections = (int)ceilf((float)numberOfModes / 4);
    self.modesPageControl.numberOfPages = numberOfSections;
    return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"modeCell";
    EditModeCell *cell = (EditModeCell *) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    int row = indexPath.row + (indexPath.section * [collectionView numberOfItemsInSection:indexPath.section]);
    
    cell.modeTitle.textColor = [UIColor darkTextColor];
    
    if (row < [modes count]) {
        Mode *mode = [modes objectAtIndex:row];
        cell.editModeImage.image = [UIImage imageWithData:mode.image];
        cell.modeTitle.text = mode.name;
        if ([mode.isActive boolValue] == YES) {
            cell.modeTitle.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
            [self.modesCollection selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    } else {
        cell.editModeImage.image = nil;
        cell.modeTitle.text = @"";
    }
    
    
    //    if ([indexPath isEqual:selectedCell]) {
    //        cell.modeTitle.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
    //        [self.modesCollection selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    //    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EditModeCell *cell = (EditModeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.modeTitle.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
    
    ConstantsHandler *constants = [ConstantsHandler sharedConstants];
    constants.activeMode = [modes objectAtIndex:(indexPath.row + indexPath.section * 4)];
    
    selectedCell = indexPath;
    
    [self resetViewData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EditModeCell *cell = (EditModeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.modeTitle.textColor = [UIColor darkTextColor];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.modesPageControl.currentPage = page;
}

#pragma mark segmented control

- (void)segmentedControlValueChanged:(id)sender
{
    if([self.segmentedControl selectedSegmentIndex] == 0){
        //Set interests active.
        [ConstantsHandler sharedConstants].activeMode.mainCellShows = @"interests";
    }else {
        //Set skills active.
        [ConstantsHandler sharedConstants].activeMode.mainCellShows = @"skills";
    }
}

@end
