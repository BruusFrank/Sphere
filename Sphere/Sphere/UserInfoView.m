//
//  UserInfoView.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/29/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "UserInfoView.h"
#import "ConstantsHandler.h"

#define USER_INFO_WIDTH 250.0f
#define USER_INFO_MARGIN (320.0f - USER_INFO_WIDTH)/2
#define USER_INFO_IDENTIFIER_FONT [UIFont fontWithName:@"Thonburi" size:18.0f]
#define USER_INFO_DETAIL_FONT [UIFont fontWithName:@"Thonburi" size:12.0f]

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
       withUserInfo:(NSDictionary *)userInfo
       buttonTarget:(id)sender
{
    self = [self initWithFrame:frame];
    if (self) {
        //Initialization code.
        
        NSArray *informationArray = [[NSArray alloc] initWithObjects:[self personalInfoViewWithInfo:userInfo], [self secondaryViewWithInfo:userInfo], [self employmentViewWithInfo:userInfo], [self statementViewWithInfo:userInfo], [self buttonsViewWithInfo:userInfo withTargetForAction:sender], nil];
        
        UIView *prevView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
        int combinedHeight = 0;
        
        for (UIView *view in informationArray) {
            if (view != nil) {
                view.frame = CGRectMake((320.0f/2 - view.frame.size.width/2),
                                        view.frame.origin.y + prevView.frame.size.height + prevView.frame.origin.y + 7.0f,
                                        view.frame.size.width,
                                        view.frame.size.height);
                [self addSubview:view];
                combinedHeight += view.frame.size.height;
                prevView = view;
            }
        }
    }
    
    return self;
}

- (UIView *)personalInfoViewWithInfo:(NSDictionary *)userInfo
{
    UIView *personalInfoView = nil;
    
    if ([userInfo objectForKey:@"age"] || [userInfo objectForKey:@"hometown"]) {
        personalInfoView = [[UIView alloc] initWithFrame:CGRectMake(USER_INFO_MARGIN, 0.0f, USER_INFO_WIDTH, 24.0f)];
        personalInfoView.backgroundColor = [UIColor clearColor];
        
        UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 24.0f)];
        ageLabel.textColor = [ConstantsHandler sharedConstants].COLOR_CYANID_BLUE;
        ageLabel.font = USER_INFO_IDENTIFIER_FONT;
        ageLabel.text = [userInfo objectForKey:@"age"];
        ageLabel.backgroundColor = [UIColor clearColor];
        [ageLabel sizeToFit];
        
        UILabel *from = [[UILabel alloc] initWithFrame:CGRectMake(ageLabel.frame.size.width, 4.0f, 40.0f, 12.0f)];
        from.font = USER_INFO_DETAIL_FONT;
        from.text = @" from ";
        from.textColor = [ConstantsHandler sharedConstants].COLOR_WHITE;
        from.backgroundColor = [UIColor clearColor];
        [from sizeToFit];
        
        UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(from.frame.size.width + from.frame.origin.x, 0.0f, USER_INFO_WIDTH - 70.0f, 24.0f)];
        fromLabel.textColor = [ConstantsHandler sharedConstants].COLOR_CYANID_BLUE;
        fromLabel.font = USER_INFO_IDENTIFIER_FONT;
        fromLabel.text = [userInfo objectForKey:@"hometown"];
        fromLabel.backgroundColor = [UIColor clearColor];
        [fromLabel sizeToFit];
        
        [personalInfoView addSubview:ageLabel];
        [personalInfoView addSubview:from];
        [personalInfoView addSubview:fromLabel];
        [personalInfoView sizeToFit];
    }
    
    return personalInfoView;
}

- (UIView *)secondaryViewWithInfo:(NSDictionary *)userInfo
{
    UIView *secondaryView = [[UIView alloc] initWithFrame:CGRectMake(USER_INFO_MARGIN, 0.0f, USER_INFO_WIDTH, 35.0f)];
    UILabel *secondaryIdentifierLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 18.0f)];
    
    NSString *tagsString = @"";
    
    if ([[ConstantsHandler sharedConstants].activeMode.mainCellShows isEqual:@"skills"] && [[userInfo objectForKey:@"interests"] count] > 0) {
        //Show interests.
        tagsString = @"";
        NSArray *tags = [userInfo objectForKey:@"interests"];
        secondaryIdentifierLabel.text = @"Interests: ";
        
        for (int i = 0; i < tags.count; i++) {
            if (i < tags.count - 1) {
                tagsString = [tagsString stringByAppendingFormat:@"%@, ", [tags objectAtIndex:i]];
            }else{
                tagsString = [tagsString stringByAppendingFormat:@"%@", [tags objectAtIndex:i]];
            }
        }
    } else if ([[ConstantsHandler sharedConstants].activeMode.mainCellShows isEqual:@"interests"] && [[userInfo objectForKey:@"skills"] count] > 0) {
        //Show skills.
        tagsString = @"";
        NSArray *tags = [userInfo objectForKey:@"skills"];
        secondaryIdentifierLabel.text = @"Skills: ";
        
        for (int i = 0; i < tags.count; i++) {
            if (i < tags.count - 1) {
                tagsString = [tagsString stringByAppendingFormat:@"%@, ", [tags objectAtIndex:i]];
            }else{
                tagsString = [tagsString stringByAppendingFormat:@"%@", [tags objectAtIndex:i]];
            }
        }
    } else {
        secondaryView = nil;
    }
    
    secondaryIdentifierLabel.textColor = [ConstantsHandler sharedConstants].COLOR_CYANID_BLUE;
    secondaryIdentifierLabel.backgroundColor = [UIColor clearColor];
    secondaryIdentifierLabel.font = USER_INFO_IDENTIFIER_FONT;
    secondaryIdentifierLabel.textAlignment = NSTextAlignmentRight;
    [secondaryIdentifierLabel sizeToFit];
    
    UILabel *secondaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(secondaryIdentifierLabel.frame.size.width, 6.0f, USER_INFO_WIDTH - secondaryIdentifierLabel.frame.size.width, 33.0f)];
    secondaryLabel.numberOfLines = 3;
    secondaryLabel.textColor = [ConstantsHandler sharedConstants].COLOR_WHITE;
    secondaryLabel.backgroundColor = [UIColor clearColor];
    secondaryLabel.font = USER_INFO_DETAIL_FONT;
    
    secondaryLabel.text = tagsString;
    [secondaryLabel sizeToFit];
    
    if (secondaryView) {
        [secondaryView addSubview:secondaryIdentifierLabel];
        [secondaryView addSubview:secondaryLabel];
        [secondaryView sizeToFit];
    }
    
    return secondaryView;
}

- (UIView *)employmentViewWithInfo:(NSDictionary *)userInfo
{
    UIView *employmentView = nil;
    
    if ([userInfo objectForKey:@"education"] || [userInfo objectForKey:@"work"])
    {
        employmentView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 220.0f, 30.0f)];
    }
    return employmentView;
}

- (UIView *)statementViewWithInfo:(NSDictionary *)userInfo
{
    UIView *statementView = nil;
    
    if ([userInfo objectForKey:@"statement"]) {
        statementView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 220.0f, 30.0f)];
    }
    return statementView;
}

- (UIView *)buttonsViewWithInfo:(NSDictionary *)userInfo
            withTargetForAction:(id)sender
{
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 30.0f)];
    if ([[userInfo objectForKey:@"request"] integerValue] == 1) {
        UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [acceptButton addTarget:sender
                         action:@selector(acceptAction:)
               forControlEvents:UIControlEventTouchDown];
        [acceptButton setTitle:@"Y" forState:UIControlStateNormal];
        acceptButton.frame = CGRectMake(74.0, 0.0, 62.0, 30.0);
        
        UIButton *denyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [denyButton addTarget:sender
                       action:@selector(denyAction:)
             forControlEvents:UIControlEventTouchDown];
        [denyButton setTitle:@"N" forState:UIControlStateNormal];
        denyButton.frame = CGRectMake(154.0, 0.0, 62.0, 30.0);
        
        [buttonsView addSubview:acceptButton];
        [buttonsView addSubview:denyButton];
    }else if ([[userInfo objectForKey:@"request"] integerValue] == 0){
        UIButton *requestbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [requestbutton addTarget:sender
                          action:@selector(sphereRequest:)
                forControlEvents:UIControlEventTouchDown];
        [requestbutton setTitle:@"Request" forState:UIControlStateNormal];
        requestbutton.frame = CGRectMake(40.0, 0.0, 227.0, 40.0);
        [requestbutton setImage:[UIImage imageNamed:@"meet"] forState:UIControlStateNormal];
        [buttonsView addSubview:requestbutton];
    }
    
    return buttonsView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
