//
//  CCSplitView.h
//  CustomControls
//
//  Created by Jonathan Baliko on 8/10/12.
//  Copyright (c) 2012 Jonathan Baliko. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#pragma mark - Interfaces -

@interface CCSplitView : NSSplitView {
}

// Get position of a divider
- (CGFloat)positionForDividerAtIndex:(NSInteger)index;

// Set position of a divider animated
- (void)setPosition:(CGFloat)position ofDividerAtIndex:(NSInteger)dividerIndex animated:(BOOL)animated;

@end
