//
//  MenuTableViewCellView.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/17/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "MenuTableViewCellView.h"

@implementation MenuTableViewCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame cellType:(CellType)type cellData:(NSDictionary *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        if (type == CellTypeSharing) {
            [self addSubview:[self cellViewForSharingWithFrame:frame cellData:data]];
        }else if (type == CellTypeMode){
            [self addSubview:[self cellViewForModeWithFrame:frame cellData:data]];
        }else if (type == CellTypeFilter){
            [self addSubview:[self cellViewForFilterWithFrame:frame cellData:data]];
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

- (UIView *)cellViewForSharingWithFrame:(CGRect)frame cellData:(NSDictionary *)data
{
    UIView *sharingView = [[UIView alloc] initWithFrame:frame];
    sharingView.backgroundColor = [UIColor clearColor];
    
    CGRect titleFrame = CGRectMake(frame.origin.x + 20.0f, frame.origin.y, frame.size.width - 50.0f, frame.size.height);
    UILabel *sharingTitle = [[UILabel alloc] initWithFrame:titleFrame];
    sharingTitle.textColor = [UIColor darkTextColor];
    sharingTitle.font = [UIFont fontWithName:@"Arial" size:13];
    sharingTitle.backgroundColor = [UIColor clearColor];
        
    sharingTitle.text = [data objectForKey:@"title"];
    
    [sharingView addSubview:sharingTitle];
    
    return sharingView;
}

- (UIView *)cellViewForModeWithFrame:(CGRect)frame cellData:(NSDictionary *)data
{
    UIView *modeView = [[UIView alloc] initWithFrame:frame];
    modeView.backgroundColor = [UIColor clearColor];
    
    CGRect titleFrame = CGRectMake(frame.origin.x + 70.0f, frame.origin.y, frame.size.width - 50.0f, frame.size.height);
    UILabel *modeTitle = [[UILabel alloc] initWithFrame:titleFrame];
    modeTitle.textColor = [UIColor darkTextColor];
    modeTitle.font = [UIFont fontWithName:@"Arial" size:13];
    modeTitle.backgroundColor = [UIColor clearColor];
    
    UIImageView *modeImage = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 7.0f, 30.0f, 30.0f)];
    
    modeTitle.text = [data objectForKey:@"title"];
    modeImage.image = [[data objectForKey:@"image"] scaleAndCropToFit:(30.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    [modeView addSubview:modeImage];
    [modeView addSubview:modeTitle];
    
    return modeView;
}

- (UIView *)cellViewForFilterWithFrame:(CGRect)frame cellData:(NSDictionary *)data
{
    UIView *filterView = [[UIView alloc] initWithFrame:frame];
    filterView.backgroundColor = [UIColor clearColor];
    
    CGRect titleFrame = CGRectMake(frame.origin.x + 20.0f, frame.origin.y, frame.size.width - 50.0f, frame.size.height);
    UILabel *filterTitle = [[UILabel alloc] initWithFrame:titleFrame];
    
    filterTitle.textColor = [UIColor darkTextColor];
    filterTitle.font = [UIFont fontWithName:@"Arial" size:13];
    filterTitle.backgroundColor = [UIColor clearColor];
        
    filterTitle.text = [data objectForKey:@"title"];
    
    [filterView addSubview:filterTitle];
    
    return filterView;
}

@end
