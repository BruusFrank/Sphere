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
    
    //PLACEHOLDER
    
    [self.modeImages addObject:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_study.png"]]];
    [self.modeImages addObject:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_work.png"]]];
    [self.modeImages addObject:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_party.png"]]];
    [self.modeImages addObject:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_casual.png"]]];
    
    [self.modeTitles addObject:@"Study"];
    [self.modeTitles addObject:@"Work"];
    [self.modeTitles addObject:@"Party"];
    [self.modeTitles addObject:@"Casual"];
    
    //END OF PLACEHOLDER
    
    self.modesCollection.dataSource = self;
    self.modesCollection.delegate = self;
    
    self.editModeTableView.dataSource = self;
    self.editModeTableView.delegate = self;
    
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
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.titleView = [UIView customTitle:@"Edit modes" withColor:[[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE] inFrame:self.navigationItem.titleView.frame];
    [self setupBarButtonItems];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.modeCollectionContainer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_bg"]];
    
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
    pageIndex = 0;
    selectedCell = [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"editModeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    //cell.textLabel.font = [UIFont fontWithName:@"helvetica" size:16.0f];
    cell.textLabel.text = @"Education:";
    
    cell.detailTextLabel.text = @"Studying IT at Aarhus University";
    cell.detailTextLabel.font = [UIFont fontWithName:@"helvetica" size:12.0f];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    UIButton *checkbox = [[UIButton alloc] initWithFrame:CGRectMake(10,12,20,20)];
    // 20x20 is the size of the checckbox that you want
    // create 2 images sizes 20x20 , one empty square and
    // another of the same square with the checkmark in it
    // Create 2 UIImages with these new images, then:
    
    [checkbox setBackgroundImage:[UIImage imageNamed:@"not_selected_checkbox.png"]
                        forState:UIControlStateNormal];
    
    [checkbox addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.tag = 0;
    [cell addSubview:checkbox];
    
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int numberOfSections = 4;
    self.modesPageControl.numberOfPages = numberOfSections;
    return 4;
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
    
    if (row < [self.modeImages count]) {
        cell.editModeImage.backgroundColor = [self.modeImages objectAtIndex:row];
        cell.modeTitle.text = [self.modeTitles objectAtIndex:row];
    } else{
        cell.editModeImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_cell_bg.png"]];
        cell.modeTitle.text = @"Mode";
    }
    
    cell.modeTitle.textColor = [UIColor darkTextColor];
    if ([indexPath isEqual:selectedCell]) {
        cell.modeTitle.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
        [self.modesCollection selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EditModeCell *cell = (EditModeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.modeTitle.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
    
    selectedCell = indexPath;
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

@end
