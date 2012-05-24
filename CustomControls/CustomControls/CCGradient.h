//
//  CCGradient.h
//  CustomControl
//
//  Created by Jonathan Baliko on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#pragma mark - Enumerations -

typedef enum {
    CCGradientModeLinear = 0,
    CCGradientModeRadial = 1
} CCGradientMode;


#pragma mark - Interfaces -

@interface CCGradient : NSGradient {
    // Gradient mode
    CCGradientMode _gradientMode;
    
    // Angle for linear gradient
    CGFloat _angle;
    
    // Relative center position for radial gradient
    NSPoint _relativeCenterPosition;
}

// Gradient mode
@property (nonatomic, assign) CCGradientMode gradientMode;

// Angle for linear gradient
@property (nonatomic, assign) CGFloat angle;

// Relative center position for radial gradient
@property (nonatomic, assign) NSPoint relativeCenterPosition;


// Draw gradient with current mode in rect
- (void)drawGradientInRect:(NSRect)rect;

@end
