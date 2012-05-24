//
//  AppDelegate.h
//  Sample
//
//  Created by Jonathan Baliko on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CustomControls/CustomControls.h>


@interface AppDelegate : NSObject <NSApplicationDelegate> {
    // Tab view
    IBOutlet CCTabView *_tabView;
    
    // Views for tabs
    IBOutlet NSView *_view1;
    IBOutlet NSView *_view2;
    IBOutlet NSView *_view3;
    
    // Controls
    IBOutlet NSSegmentedControl *_sizeControl;
    IBOutlet NSSegmentedControl *_positionControl;
    IBOutlet NSSegmentedControl *_transitionControl;
}

// Window
@property (assign) IBOutlet NSWindow *window;


// Controls actions
- (IBAction)doActionForSizeChange:(id)sender;
- (IBAction)doActionForPositionChange:(id)sender;
- (IBAction)doActionForTransitionChange:(id)sender;

@end
