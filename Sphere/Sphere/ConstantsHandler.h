//
//  ConstantsHandler.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User+Facebook.h"
#import "Mode+Create.h"

@interface ConstantsHandler : NSObject

typedef enum fontType{
    fontTypeLight,
    fontTypeRegular,
    fontTypeBold,
    fontTypeExtraBold
} fontType;

+ (ConstantsHandler *)sharedConstants;

//Fonts.
- (UIFont *)originType:(fontType)type FontSize:(CGFloat)size;

//Colors.
@property (strong, nonatomic) UIColor *COLOR_CYANID_BLUE;
@property (strong, nonatomic) UIColor *COLOR_WHITE;
@property (strong, nonatomic) UIColor *COLOR_LINEN_PATTERN;

//Fonts.
@property (strong, nonatomic) UIFont *FONT_NAVBAR_TITLE;
@property (strong, nonatomic) UIFont *FONT_HEADER;

//Retina
@property (nonatomic, assign, getter=isRetina) BOOL retina;
@property (nonatomic, assign) int RETINA_FACTOR;

//User specific
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Mode *activeMode;

@end
