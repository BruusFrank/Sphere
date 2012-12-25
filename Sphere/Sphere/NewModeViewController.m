//
//  NewModeViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/4/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "NewModeViewController.h"
#import "EditModeViewController.h"

@interface NewModeViewController ()

@end

@implementation NewModeViewController

BOOL collectionShown;
BOOL keyboardIsShown;

#pragma mark IBActions

- (void)popController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changeModeIcon:(id)sender
{
    if (!collectionShown) {
        if (keyboardIsShown) {
            [self.view endEditing:YES];
        }
    }
    [self toggleModeImageCollection];
}

- (IBAction)addMode:(id)sender
{
    if ([self.modeNameTextField.text isEqualToString:@""]) {
        UIAlertView *noModeError = [[UIAlertView alloc] initWithTitle:@"Wait!" message:@"Please give your mode a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noModeError show];
    }else{
        [self performSegueWithIdentifier:@"addAndConfigureSegue" sender:self];
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
    
    self.modeNameTextField.delegate = self;
    self.modeImageCollection.dataSource = self;
    self.modeImageCollection.delegate = self;
    
    [self setupMainLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    collectionShown = NO;
    keyboardIsShown = NO;
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
    self.navigationItem.titleView = [UIView customTitle:@"New mode" withColor:[[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE] inFrame:self.navigationItem.titleView.frame];
    [self setupBarButtonItems];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_LINEN_PATTERN];
    self.modeImageCollectionContainer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_bg"]];
    
    self.modeNameTextField.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    self.modeNameTextField.font = [UIFont systemFontOfSize:22.0f];
    
    self.changeModeIconButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_cell_bg.png"]];
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

#pragma mark UITextFieldDelegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (collectionShown) {
        [self toggleModeImageCollection];
    }
    keyboardIsShown = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    keyboardIsShown = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int numberOfSections = 2;
    self.modeImagePageController.numberOfPages = numberOfSections;
    return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"modeImageCell";
    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_study.png"]];
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mode_study.png"]]];
                break;
            case 1:
                //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_work.png"]];
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mode_work.png"]]];
                break;
            case 2:
                //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_party.png"]];
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mode_party.png"]]];
                break;
            case 3:
                //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mode_casual.png"]];
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mode_casual.png"]]];
                break;
            default:
                //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_cell_bg.png"]];
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collection_cell_bg.png"]]];
                break;
        }
    } else{
        //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collection_cell_bg.png"]];
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collection_cell_bg.png"]]];
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //self.changeModeIconButton.backgroundColor = [collectionView cellForItemAtIndexPath:indexPath].backgroundColor;
    [self.changeModeIconButton setBackgroundImage:[(UIImageView *)[[collectionView cellForItemAtIndexPath:indexPath] backgroundView] image] forState:UIControlStateNormal];
    [self toggleModeImageCollection];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.modeImagePageController.currentPage = page;
}

#pragma mark prepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditModeViewController *controller = (EditModeViewController *)segue.destinationViewController;
    
    [controller.modeImages addObject:[self.changeModeIconButton backgroundImageForState:UIControlStateNormal]];
    [controller.modeTitles addObject:self.modeNameTextField.text];
    controller.settingsController = self.settingsController;
}

#pragma mark animation methods

- (void)toggleModeImageCollection
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.27f];
    
    CGRect frame = self.modeImageCollectionContainer.frame;
    if (collectionShown) {
        frame.origin.y += self.modeImageCollectionContainer.frame.size.height;
    }else{
        frame.origin.y -= self.modeImageCollectionContainer.frame.size.height;
    }
    
    self.modeImageCollectionContainer.frame = frame;
    
    [UIView commitAnimations];
    
    collectionShown = !collectionShown;
}

@end
