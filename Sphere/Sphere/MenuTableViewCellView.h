//
//  MenuTableViewCellView.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/17/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+ScaleAndCrop.h"
#import "ConstantsHandler.h"

@interface MenuTableViewCellView : UIView

typedef enum CellType{
    CellTypeSharing,
    CellTypeMode,
    CellTypeFilter
} CellType;

- (id)initWithFrame:(CGRect)frame cellType:(CellType)type cellData:(NSDictionary *)data;

@end
