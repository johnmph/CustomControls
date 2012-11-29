//
//  CCColorView.m
//  CustomControls
//
//  Created by Jonathan Baliko on 7/10/12.
//  Copyright (c) 2012 Jonathan Baliko. All rights reserved.
//

#import "CCColorView.h"


#pragma mark - Implementations -

@implementation CCColorView

@synthesize color = _color;


#pragma mark - Init / Dealloc methods -

- (id)initWithFrame:(NSRect)frame {
    // Call parent method
    if ((self = [super initWithFrame:frame])) {
        // Initialize members
        _color = nil;
    }
    
    // Return object
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // Call parent method
    if ((self = [super initWithCoder:aDecoder])) {
        // Initialize members
        _color = nil;
    }
    
    // Return object
    return self;
}

- (void)dealloc {
    // Release color
    [_color release];
    
    // Call parent method
    [super dealloc];
}


#pragma mark - Properties methods -

- (void)setColor:(NSColor *)color {
    // If color is same than current
    if ([color isEqual:_color]) {
        // Exit
        return;
    }
    
    // Release possible old color
    [_color release];
    
    // Set and retain new color
    _color = [color retain];
    
    // Invalidate display
    [self setNeedsDisplay:TRUE];
}


#pragma mark - Overriden methods -

- (void)drawRect:(NSRect)dirtyRect {
    // Choose color for filling
    [_color setFill];
    
    // Fill rect
    NSRectFill(dirtyRect);
}

@end
