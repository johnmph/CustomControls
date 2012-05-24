//
//  CCGradientView.h
//  CustomControl
//
//  Created by Jonathan Baliko on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CCGradient.h"


#pragma mark - Interfaces -

@interface CCGradientView : NSView {
    // Gradient
    CCGradient *_gradient;
}

// Gradient
@property (nonatomic, retain) CCGradient *gradient;

@end
