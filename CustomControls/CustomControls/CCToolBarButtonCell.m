//
//  CCToolBarButtonCell.m
//  CustomControl
//
//  Created by Jonathan Baliko on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCToolBarButtonCell.h"


#pragma mark - Defines -

#define CCToolBarButtonCellLineWidth    1.5f


#pragma mark - Implementations -

@implementation CCToolBarButtonCell


#pragma mark - Overriden methods -

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    // If state is On or if it is highlighted
    if (([self state] == NSOnState) || ([self isHighlighted])) {
        // Create content gradient colors array
        NSArray *colors = [NSArray arrayWithObjects:[NSColor colorWithCalibratedWhite:0.8f alpha:0.3f], [NSColor colorWithCalibratedWhite:0.5f alpha:0.6f], [NSColor colorWithCalibratedWhite:0.7f alpha:0.3f], nil];
        
        // Create gradient
        NSGradient *gradient = [[[NSGradient alloc] initWithColors:colors] autorelease];
        
        // Draw gradient
        [gradient drawInRect:CGRectInset(cellFrame, CCToolBarButtonCellLineWidth, 0.0f) angle:90.0f];
        
        // Create border line gradient colors array
        colors = [NSArray arrayWithObjects:[NSColor colorWithCalibratedWhite:0.5f alpha:0.1f], [NSColor colorWithCalibratedWhite:0.3f alpha:0.8f], [NSColor colorWithCalibratedWhite:0.5f alpha:0.1f], nil];
        
        // Create gradient
        gradient = [[[NSGradient alloc] initWithColors:colors] autorelease];
        
        // Draw gradient
        [gradient drawInRect:CGRectMake(cellFrame.origin.x, cellFrame.origin.y, CCToolBarButtonCellLineWidth, cellFrame.size.height) angle:90.0f];
        [gradient drawInRect:CGRectMake((cellFrame.origin.x + cellFrame.size.width) - CCToolBarButtonCellLineWidth, cellFrame.origin.y, CCToolBarButtonCellLineWidth, cellFrame.size.height) angle:90.0f];
    }
    
    // Call parent method
    [super drawWithFrame:cellFrame inView:controlView];
}

@end
