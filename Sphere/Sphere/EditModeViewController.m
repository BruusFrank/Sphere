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
    
    self.modesCollection.dataSource = self;
    self.modesCollection.delegate = self;
    
    [self setupMainLayout];
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
    
    cell.modeTitle.textColor = [UIColor darkTextColor];
    if ([indexPath isEqual:selectedCell]) {
        cell.modeTitle.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
    }
    cell.modeTitle.text = @"Mode";
    
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

@end
