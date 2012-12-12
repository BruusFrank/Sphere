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

@interface EditModeViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *modesCollection;
@property (weak, nonatomic) IBOutlet UIPageControl *modesPageControl;
@property (weak, nonatomic) IBOutlet UIView *modeCollectionContainer;

@property (strong, nonatomic) NSMutableArray *modeImages;
@property (strong, nonatomic) NSMutableArray *modeTitles;

@property (strong, nonatomic)UIViewController *settingsController;

@end
