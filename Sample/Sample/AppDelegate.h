//
//  AppDelegate.h
//  Sample
//
//  Created by Jonathan Baliko on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CustomControls/CustomControls.h>
#import "TreeObject.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate> {
    // Tab view
    IBOutlet CCTabView *_tabView;
    
    // Views for tabs
    IBOutlet NSOutlineView *_view1;
    IBOutlet NSView *_view2;
    IBOutlet NSView *_view3;
    
    // Controls
    IBOutlet NSSegmentedControl *_sizeControl;
    IBOutlet NSSegmentedControl *_positionControl;
    IBOutlet NSSegmentedControl *_transitionControl;
    
    // Split view
    IBOutlet CCSplitView *_splitView;
    
    // Colors view
    IBOutlet CCColorView *_colorView1;
    IBOutlet CCColorView *_colorView2;
    IBOutlet CCColorView *_colorView3;
    
    // Root object
    TreeObject *_rootObject;
}

// Window
@property (assign) IBOutlet NSWindow *window;

// Root object
@property (nonatomic, retain, readonly) TreeObject *rootObject;


// Controls actions
- (IBAction)doActionForSizeChange:(id)sender;
- (IBAction)doActionForPositionChange:(id)sender;
- (IBAction)doActionForTransitionChange:(id)sender;
- (IBAction)doActionForRemoveAll:(id)sender;
- (IBAction)doActionForLButton:(id)sender;
- (IBAction)doActionForRButton:(id)sender;

@end
