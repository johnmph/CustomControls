//
//  CCGradient.m
//  CustomControl
//
//  Created by Jonathan Baliko on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCGradient.h"


#pragma mark - Implementations -

@implementation CCGradient

@synthesize gradientMode = _gradientMode, angle = _angle, relativeCenterPosition = _relativeCenterPosition;


#pragma mark - Init / Dealloc methods -

- (id)init {
    // Call parent method
    if ((self = [super init])) {
        // Initialize members
        _gradientMode = CCGradientModeLinear;
        _angle = 0.0f;
        _relativeCenterPosition = CGPointZero;
    }
    
    // Return object
    return self;
}
/*
- (void)dealloc {
    // Call parent method
    [super dealloc];
}*/


#pragma mark - Overriden methods -

- (void)drawGradientInRect:(NSRect)rect {
    // Check mode
    if (_gradientMode == CCGradientModeRadial) {
        // Draw radial gradient in rect
        [self drawInRect:rect relativeCenterPosition:_relativeCenterPosition];
    } else {
        // Draw linear gradient in rect
        [self drawInRect:rect angle:_angle];
    }
}

@end
