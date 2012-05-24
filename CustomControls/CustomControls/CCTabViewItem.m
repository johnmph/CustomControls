//
//  CCTabViewItem.m
//  TestInterfaceDesign
//
//  Created by Jonathan Baliko on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCTabViewItem.h"


#pragma mark - Implementations -

@implementation CCTabViewItem

@synthesize icon = _icon;


#pragma mark - Init / Dealloc methods -

- (id)init {
    // Call parent method
    if ((self = [super init])) {
        // Initialize members
        _icon = nil;
    }
    
    // Return object
    return self;
}

- (void)dealloc {
    // Release icon
    [_icon release];
    
    // Call parent method
    [super dealloc];
}

@end
