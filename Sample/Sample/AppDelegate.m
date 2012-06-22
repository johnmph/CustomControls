//
//  AppDelegate.m
//  Sample
//
//  Created by Jonathan Baliko on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

// Update size
- (void)updateSize;

@end

@implementation AppDelegate

@synthesize window = _window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // TODO: Check why i need to call updateTabViewFrame here to correct the frame of _tabView._tabView, maybe it's related to auto layout
    [_tabView performSelector:@selector(updateTabViewFrame)];
    
    // Update controls
    _sizeControl.selectedSegment = (_tabView.tabSize == CCTabViewTabSizeSmall) ? 0 : 1;
    _positionControl.selectedSegment = (_tabView.tabsPosition == CCTabViewPositionCenter) ? 0 : ((_tabView.tabsPosition == CCTabViewPositionLeft) ? 1 : 2);
    
    if (_tabView.transition) {
        _transitionControl.selectedSegment = (_tabView.transition.type == kCATransitionFade) ? 1 : 2;
    } else {
        _transitionControl.selectedSegment = 0;
    }
    
    // Add 3 items
    NSView *views[] = { _view1, _view2, _view3 };
    
    for (int x = 0; x < 3; ++x) {
        // Create tab view item
        CCTabViewItem *tabViewItem = [[CCTabViewItem alloc] init];
        
        // Set label
        tabViewItem.label = [NSString stringWithFormat:@"Item %d", x];
        
        // Set view
        tabViewItem.view = views[x];
        
        // Add it to tab view
        [_tabView addTabViewItem:tabViewItem];
    }
    
    // Update size
    [self updateSize];
}


#pragma mark - Private methods -

- (void)updateSize {
    // Browse items
    for (int x = 0; x < [_tabView numberOfTabViewItems]; ++x) {
        // Get current tab view item
        CCTabViewItem *tabViewItem = [_tabView tabViewItemAtIndex:x];
        
        // Create image name
        NSString *imageName = [NSString stringWithFormat:@"Item%d-%@", x + 1, ((_tabView.tabSize == CCTabViewTabSizeSmall) ? @"Small" : @"Large")];
        
        // Set tab view item icon
        tabViewItem.icon = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:imageName]];
        
        // Only needed because i didn't resize the small icons
        if (_tabView.tabSize == CCTabViewTabSizeSmall) {
            CGSize iconSize = [tabViewItem.icon size];
            [tabViewItem.icon setSize:NSMakeSize(iconSize.width * 0.65f, iconSize.height * 0.65f)];
        }
        
        // Update tab view item to take change
        [_tabView updateTabViewItem:tabViewItem];
    }
    
    // Set tabs margin
    if (_tabView.tabSize == CCTabViewTabSizeSmall) {
        _tabView.tabsMargin = CCMarginMake(8.0f, 8.0f, 0.0f, 0.0f);
    } else {
        _tabView.tabsMargin = CCMarginMake(8.0f, 8.0f, 6.0f, 6.0f);
    }
}


#pragma mark - Public methods -

- (void)doActionForSizeChange:(id)sender {
    // Set size
    _tabView.tabSize = _sizeControl.selectedSegment;
    
    // Update size
    [self updateSize];
}

- (void)doActionForPositionChange:(id)sender {
    // Set position
    _tabView.tabsPosition = _positionControl.selectedSegment;
}

- (void)doActionForTransitionChange:(id)sender {
    // If transition
    if (_transitionControl.selectedSegment) {
        // Create transition
        CATransition *transition = [[CATransition alloc] init];
        
        // Check transition type
        switch (_transitionControl.selectedSegment) {
            case 1:
                // Set transition type
                transition.type = kCATransitionFade;
            break;
            
            case 2:
                // Set transition type
                transition.type = kCATransitionPush;
            break;
        }
        
        // Set transition of tab view
        _tabView.transition = transition;
    } else {
        // Reset transition
        _tabView.transition = nil;
    }
}

- (void)doActionForRemoveAll:(id)sender {
    // Remove all tab view items
    [_tabView removeAllTabViewItems];
}

@end
