//
//  EditModeViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/4/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConstantsHandler.h"
#import "UIView+CustomTitleView.h"
#import "SharedDocument.h"
#import "Mode+Create.h"

@interface EditModeViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *modesCollection;
@property (weak, nonatomic) IBOutlet UIPageControl *modesPageControl;
@property (weak, nonatomic) IBOutlet UIView *modeCollectionContainer;
@property (weak, nonatomic) IBOutlet UITableView *editModeTableView;
@property (weak, nonatomic) IBOutlet UIView *cellStyleView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) NSMutableArray *modeImages;
@property (strong, nonatomic) NSMutableArray *modeTitles;

@property (strong, nonatomic)UIViewController *settingsController;

@end
