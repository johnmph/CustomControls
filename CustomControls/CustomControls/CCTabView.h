//
//  CCTabView.h
//  CustomControl
//
//  Created by Jonathan Baliko on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "CCBase.h"
#import "CCGradientView.h"
#import "CCTabViewItem.h"
#import "CCTabViewDelegate.h"


#pragma mark - Enumerations -

typedef enum {
    CCTabViewPositionCenter = 0,
    CCTabViewPositionLeft = 1,
    CCTabViewPositionRight = 2
} CCTabViewPosition;

typedef enum {
    CCTabViewTabSizeSmall = 0,
    CCTabViewTabSizeLarge = 1
} CCTabViewTabSize;


#pragma mark - Interfaces -

@interface CCTabView : NSView <NSTabViewDelegate> {
    // Tab view delegate
    id<CCTabViewDelegate> _delegate;
    
    // Tab bar view
    CCGradientView *_tabBarView;
    
    // Title view inside tab bar view
    NSTextField *_titleView;//TODO: finir la title view, voir comment faire pour exposer un maximum de propriétés en restant encapsulé
    
    // Matrix of tabs
    NSMatrix *_tabMatrix;
    
    // Cell size
    CGSize _cellSize;
    
    // Tab size
    CCTabViewTabSize _tabSize;
    
    // Tabs position
    CCTabViewPosition _tabsPosition;
    
    // Tab view
    NSTabView *_tabView;
    
    // Transition between view's tab change
    CATransition *_transition;
    
    // Tab margins
    CCMargin _tabsMargin;
    
    // Tab bar gradient
    CCGradient *_tabBarGradient;
}

// Delegate
@property (nonatomic, assign) id<CCTabViewDelegate> delegate;

// Minimum size
@property (nonatomic, readonly) NSSize minimumSize;

// Content rect
@property (nonatomic, readonly) NSRect contentRect;

// Title view
@property (nonatomic, readonly) NSTextField *titleView;

// Tab size
@property (nonatomic, assign) CCTabViewTabSize tabSize;

// Tabs position
@property (nonatomic, assign) CCTabViewPosition tabsPosition;

// Transition between view's tab change
@property (nonatomic, retain) CATransition *transition;

// Tab margins
@property (nonatomic, assign) CCMargin tabsMargin;

// Tab bar gradient
@property (nonatomic, retain) CCGradient *tabBarGradient;


// Update tab view item
- (void)updateTabViewItem:(CCTabViewItem *)item;


// *** Adding and Removing Tabs ***

// Add a tab view item
- (void)addTabViewItem:(CCTabViewItem *)tabViewItem;

// Insert a tab view item at index
- (void)insertTabViewItem:(CCTabViewItem *)tabViewItem atIndex:(NSInteger)index;

// Remove a tab view item
- (void)removeTabViewItem:(CCTabViewItem *)tabViewItem;

// Remove all tab view items
- (void)removeAllTabViewItems;


// *** Accessing Tabs ***

// Get index of a tab view item
- (NSInteger)indexOfTabViewItem:(CCTabViewItem *)tabViewItem;

// Get index of a tab view item with specified identifier
- (NSInteger)indexOfTabViewItemWithIdentifier:(id)identifier;

// Get the number of tab view items
- (NSInteger)numberOfTabViewItems;

// Get tab view item at index
- (CCTabViewItem *)tabViewItemAtIndex:(NSInteger)index;

// Get the tab view items array
- (NSArray *)tabViewItems;


// *** Selecting a Tab ***

// Select first tab view item
- (void)selectFirstTabViewItem:(id)sender;

// Select last tab view item
- (void)selectLastTabViewItem:(id)sender;

// Select next tab view item
- (void)selectNextTabViewItem:(id)sender;

// Select previous tab view item
- (void)selectPreviousTabViewItem:(id)sender;

// Select a tab view item
- (void)selectTabViewItem:(CCTabViewItem *)tabViewItem;

// Select a tab view item at index
- (void)selectTabViewItemAtIndex:(NSInteger)index;

// Select a tab view item with specified identifier
- (void)selectTabViewItemWithIdentifier:(id)identifier;

// Get the selected tab view item
- (CCTabViewItem *)selectedTabViewItem;

// Take selected tab view item from a sender
- (void)takeSelectedTabViewItemFromSender:(id)sender;

@end


#pragma mark - Notifications -

APPKIT_EXTERN NSString * const CCTabViewDidChangeNumberOfTabViewItemsNotification;
APPKIT_EXTERN NSString * const CCTabViewWillSelectTabViewItemNotification;
APPKIT_EXTERN NSString * const CCTabViewDidSelectTabViewItemNotification;
