//
//  CCGradientView.m
//  CustomControl
//
//  Created by Jonathan Baliko on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCGradientView.h"


#pragma mark - Implementations -

@implementation CCGradientView

@synthesize gradient = _gradient;


#pragma mark - Init / Dealloc methods -

- (id)initWithFrame:(NSRect)frame {
    // Call parent method
    if ((self = [super initWithFrame:frame])) {
        // Initialize members
        _gradient = nil;
    }
    
    // Return object
    return self;
}

- (void)dealloc {
    // Release gradient
    [_gradient release];
    
    // Call parent method
    [super dealloc];
}


#pragma mark - Overriden methods -

- (void)drawRect:(NSRect)dirtyRect {
    // Draw gradient
    [_gradient drawGradientInRect:self.bounds];
}

@end
