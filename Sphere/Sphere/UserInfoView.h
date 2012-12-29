//
//  UserInfoView.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/29/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoView : UIView

- (id)initWithFrame:(CGRect)frame
       withUserInfo:(NSDictionary *)userInfo
       buttonTarget:(id)sender;

@end
