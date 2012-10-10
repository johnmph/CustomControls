//
//  CCColorView.h
//  CustomControls
//
//  Created by Jonathan Baliko on 7/10/12.
//  Copyright (c) 2012 Jonathan Baliko. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#pragma mark - Interfaces -

@interface CCColorView : NSView {
    // Color
    NSColor *_color;
}

// Color
@property (nonatomic, retain, readwrite) NSColor *color;

@end
