//
//  UserInfoView.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/29/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "UserInfoView.h"
#import "ConstantsHandler.h"

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
        
        //Check for the individual elements.
        UIView *personalInfoView = nil;
        UIView *secondaryView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 220.0f, 35.0f)]; //The one of skills/interests, which isn't shown in the main part of the cell.
        UIView *employmentView = nil;
        UIView *statementView = nil;
        
        //Personal info view.
        if ([userInfo objectForKey:@"age"] || [userInfo objectForKey:@"hometown"]) {
            personalInfoView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 220.0f, 30.0f)];
        }
        
        //Interests/skills in secondary view.
        UILabel *secondaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 0.0f, 150.0f, 33.0f)];
        secondaryLabel.numberOfLines = 3;
        secondaryLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
        secondaryLabel.backgroundColor = [UIColor clearColor];
        secondaryLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        UILabel *secondaryIdentifierLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 14.0f)];
        secondaryIdentifierLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
        secondaryIdentifierLabel.backgroundColor = [UIColor clearColor];
        secondaryIdentifierLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        secondaryIdentifierLabel.textAlignment = NSTextAlignmentRight;
        NSString *tagsString = @"";
        
        if ([[ConstantsHandler sharedConstants].activeMode.mainCellShows isEqual:@"skills"]) {
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
        } else {
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
        }
        
        secondaryLabel.text = tagsString;
        [secondaryLabel sizeToFit];
        [secondaryView addSubview:secondaryIdentifierLabel];
        [secondaryView addSubview:secondaryLabel];
        
        //Employment view.
        if ([userInfo objectForKey:@"education"] || [userInfo objectForKey:@"work"]) {
        }
        
        //Personal statement view.
        if ([userInfo objectForKey:@"statement"]) {
            personalInfoView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 220.0f, 30.0f)];
        }
        
        //Buttons view (let's meet / accept+deny).
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
        
        NSArray *informationArray = [[NSArray alloc] initWithObjects:personalInfoView, secondaryView, employmentView, statementView, buttonsView, nil];
        
        UIView *prevView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
        int combinedHeight = 0;
        
        for (UIView *view in informationArray) {
            if (view != nil) {
                view.frame = CGRectMake(view.frame.origin.x,
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
