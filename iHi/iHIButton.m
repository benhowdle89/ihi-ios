//
//  iHIButton.m
//  iHi
//
//  Created by Ben Howdle on 25/08/2014.
//  Copyright (c) 2014 Ben Howdle. All rights reserved.
//

#import "iHIButton.h"

@implementation iHIButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.522 green:0.773 blue:0.875 alpha:1];
        self.layer.cornerRadius = 4;
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
        
        CGRect frame = self.frame;
        frame.size.height += 10;
        self.frame = frame;
        
    }
    return self;
}

@end
