//
//  NewModeViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/4/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConstantsHandler.h"
#import "UIView+CustomTitleView.h"
#import "Mode+Create.h"

@interface NewModeViewController : UIViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *modeNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *changeModeIconButton;
@property (weak, nonatomic) IBOutlet UIView *modeImageCollectionContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *modeImageCollection;
@property (weak, nonatomic) IBOutlet UIPageControl *modeImagePageController;
@property (strong, nonatomic) UIViewController *settingsController;

@end
