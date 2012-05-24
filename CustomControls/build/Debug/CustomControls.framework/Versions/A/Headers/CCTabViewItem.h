//
//  CCTabViewItem.h
//  CustomControl
//
//  Created by Jonathan Baliko on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#pragma mark - Interfaces -

@interface CCTabViewItem : NSTabViewItem {
    // Icon
    NSImage *_icon;
}

// Icon
@property (nonatomic, retain) NSImage *icon;

@end
