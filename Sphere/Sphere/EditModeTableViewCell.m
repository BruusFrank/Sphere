//
//  EditModeTableViewCell.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/23/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "EditModeTableViewCell.h"

@implementation EditModeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
