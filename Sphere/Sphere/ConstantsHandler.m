//
//  ConstantsHandler.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "ConstantsHandler.h"

@implementation ConstantsHandler

static ConstantsHandler *sharedConstants = nil;

- (void)setActiveMode:(Mode *)activeMode
{
    _activeMode = activeMode;
    
    NSArray *modes = [self.user.hasModes allObjects];
    for (Mode *mode in modes) {
        mode.isActive = [NSNumber numberWithBool:NO];
    }
    
    activeMode.isActive = [NSNumber numberWithBool:YES];
}

+ (ConstantsHandler *)sharedConstants
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedConstants = [[self alloc] init];
    });
    return sharedConstants;
}

- (id)init
{
    //Colors.
    self.COLOR_CYANID_BLUE = [UIColor colorWithRed:27.0f/255.0f green:177.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self.COLOR_WHITE = [UIColor colorWithRed:233.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1.0f];
    self.COLOR_LINEN_PATTERN = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg.png"]];
    
    //Fonts.
    self.FONT_NAVBAR_TITLE = [self originType:fontTypeExtraBold FontSize:18.0f];
    self.FONT_HEADER = [self originType:fontTypeExtraBold FontSize:14.0f];
    self.FONT_SECTION_TITLE_UNGROUPED = [UIFont fontWithName:@"Thonburi" size:16.0f];
    
    //Check for retina display.
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        self.retina = YES;
        self.RETINA_FACTOR = 2;
    } else {
        self.retina = NO;
        self.RETINA_FACTOR = 1;
    }
    
    return self;
}

//Fonts.

- (UIFont *)originType:(fontType)type FontSize:(CGFloat)size
{
    switch (type) {
        case fontTypeLight:
            return [UIFont fontWithName:@"Origin-Light" size:size];
            break;
        case fontTypeBold:
            return [UIFont fontWithName:@"Origin-Bold" size:size];
            break;
        case fontTypeExtraBold:
            return [UIFont fontWithName:@"Origin-ExtraBold" size:size];
            break;
        default:
            break;
    }
    return [UIFont fontWithName:@"Origin-Regular" size:size];
}

//Layout

- (void)setNavigationBarLayoutWithNavigtionController:(UIViewController *)controller
                                      WithTitle:(NSString *)title
{
    controller.navigationController.navigationBarHidden = NO;
    [controller.navigationItem setHidesBackButton:YES];
    controller.navigationItem.titleView = [UIView customTitle:title withColor:self.COLOR_WHITE inFrame:controller.navigationItem.titleView.frame];
    
    UINavigationBar *navBar = controller.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    //navBar.shadowImage = [[UIImage alloc] init];
    //navBar.tintColor = self.COLOR_CYANID_BLUE;
}

@end
