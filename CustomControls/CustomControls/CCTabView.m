//
//  CCTabView.m
//  CustomControl
//
//  Created by Jonathan Baliko on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCTabView.h"
#import "CCToolBarButtonCell.h"


#pragma mark - Notifications -

NSString * const CCTabViewDidChangeNumberOfTabViewItemsNotification = @"CCTabViewDidChangeNumberOfTabViewItemsNotification";
NSString * const CCTabViewWillSelectTabViewItemNotification = @"CCTabViewWillSelectTabViewItemNotification";
NSString * const CCTabViewDidSelectTabViewItemNotification = @"CCTabViewDidSelectTabViewItemNotification";


#pragma mark - Private interfaces -

@interface CCTabView ()//TODO: quand on redimensionne ca fait un sale effet, a voir

// Cell size
@property (nonatomic, assign) CGSize cellSize;


// Shared initializer
- (void)initCCTabView;

// Initialize a button cell
- (void)initButtonCell:(NSButtonCell *)buttonCell withTabViewItem:(CCTabViewItem *)tabViewItem;

// Update tab bar view frame
- (void)updateTabBarViewFrame;

// Update tab view frame
- (void)updateTabViewFrame;

// Update tab matrix frame
- (void)updateTabMatrixFrame;

// Get the index of selected tab view item
- (NSInteger)indexOfSelectedItem;

// Synchronize matrix selection with tab view selection
- (void)syncMatrixWithTabView;

// Do action for matrix
- (void)doActionForMatrix:(id)sender;

@end


#pragma mark - Implementations -

@implementation CCTabView

@synthesize delegate = _delegate, titleView = _titleView, cellSize = _cellSize, tabSize = _tabSize, tabsPosition = _tabsPosition, transition = _transition, tabsMargin = _tabsMargin;


#pragma mark - Init / Dealloc methods -

- (id)initWithFrame:(NSRect)frame {
    // Call parent method
    if ((self = [super initWithFrame:frame])) {
        // Initialize members
        
        // Initialize view
        [self initCCTabView];
    }
    
    // Return object
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // Call parent method
    if ((self = [super initWithCoder:aDecoder])) {
        // Initialize members
        
        // Initialize view
        [self initCCTabView];
    }
    
    // Return object
    return self;
}

- (void)dealloc {
    // Release tab matrix
    [_tabMatrix release];
    
    // Call parent method
    [super dealloc];
}


#pragma mark - NSTabViewDelegate protocol methods -

- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)tabView {
    // If delegate implement this method
    if ([_delegate respondsToSelector:@selector(tabViewDidChangeNumberOfTabViewItems:)]) {
        // Call method
        [_delegate tabViewDidChangeNumberOfTabViewItems:self];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:CCTabViewDidChangeNumberOfTabViewItemsNotification object:self];
}

- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    // If delegate implement this method
    if ([_delegate respondsToSelector:@selector(tabView:shouldSelectTabViewItem:)]) {
        // Call method
        return [_delegate tabView:self shouldSelectTabViewItem:(CCTabViewItem *) tabViewItem];
    }
    
    // If no delegate, we allow the selection
    return TRUE;
}

- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    // If delegate implement this method
    if ([_delegate respondsToSelector:@selector(tabView:willSelectTabViewItem:)]) {
        // Call method
        [_delegate tabView:self willSelectTabViewItem:(CCTabViewItem *) tabViewItem];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:CCTabViewWillSelectTabViewItemNotification object:self];
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    // If delegate implement this method
    if ([_delegate respondsToSelector:@selector(tabView:didSelectTabViewItem:)]) {
        // Call method
        [_delegate tabView:self didSelectTabViewItem:(CCTabViewItem *) tabViewItem];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:CCTabViewDidSelectTabViewItemNotification object:self];
}


#pragma mark - Property methods -

- (NSSize)minimumSize {
    // Calculate minimum size to contains all tabs
    CGSize minimumSize = CGSizeMake(_tabMatrix.numberOfColumns * _tabMatrix.cellSize.width, _tabMatrix.cellSize.height);
    
    // Return it
    return minimumSize;
}

- (NSRect)contentRect {
    // Use tab view as delegate to manage the message
    return _tabView.contentRect;
}

- (void)setCellSize:(CGSize)cellSize {
    // If same size than current
    if (CGSizeEqualToSize(cellSize, _cellSize)) {
        // Exit
        return;
    }
    
    // Set new cell size
    _cellSize = cellSize;
    
    // Resize cell of matrix
    [_tabMatrix setCellSize:_cellSize];
    
    // Update tab bar view frame
    [self updateTabBarViewFrame];
    
    // Update tab view frame
    [self updateTabViewFrame];
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (void)setTabSize:(CCTabViewTabSize)tabSize {
    // If same size than current
    if (tabSize == _tabSize) {
        // Exit
        return;
    }
    
    // Set new tab size
    _tabSize = tabSize;
    
    // Check tab size
    switch (_tabSize) {
        case CCTabViewTabSizeLarge:
            self.cellSize = CGSizeMake(50.0f, 54.0f);
        break;
        
        default:
            self.cellSize = CGSizeMake(23.0f, 25.0f);
        break;
    }
    
    // Browse all existing cells
    for (NSButtonCell *cell in [_tabMatrix cells]) {
        // Update image position
        [cell setImagePosition:(_tabSize == CCTabViewTabSizeLarge) ? NSImageAbove : NSImageOnly];
    }
}

- (void)setTabsPosition:(CCTabViewPosition)tabsPosition {
    // If same position than current
    if (tabsPosition == _tabsPosition) {
        // Exit
        return;
    }
    
    // Set new tabs position
    _tabsPosition = tabsPosition;
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (void)setTabsMargin:(CCMargin)tabsMargin {
    // If same margin than current
    if (CCMarginEqualToMargin(tabsMargin, _tabsMargin)) {
        // Exit
        return;
    }
    
    // Set new tabs margin
    _tabsMargin = tabsMargin;
    
    // Update tab bar view frame
    [self updateTabBarViewFrame];
    
    // Update tab view frame
    [self updateTabViewFrame];
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (CCGradient *)tabBarGradient {
    // Return gradient of tab bar view
    return _tabBarView.gradient;
}

- (void)setTabBarGradient:(CCGradient *)tabBarGradient {
    // Set gradient of tab bar view
    _tabBarView.gradient = tabBarGradient;
}


#pragma mark - Private methods -

- (void)initCCTabView {
    // Initialize members
    _delegate = nil;
    _cellSize = CGSizeZero;
    _tabSize = -1;
    _tabsPosition = -1;
    _transition = nil;
    _tabsMargin = CCMarginMake(8.0f, 8.0f, 0.0f, 0.0f);
    
    // Create a tab bar view
    _tabBarView = [[[CCGradientView alloc] init] autorelease];
    
    // Create default gradient
    CCGradient *gradient = [[[CCGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.68f alpha:1.0f] endingColor:[NSColor colorWithCalibratedWhite:0.82f alpha:1.0f]] autorelease];
    
    // Set angle of gradient
    gradient.angle = 90.0f;
    
    // Set gradient
    _tabBarView.gradient = gradient;
    
    // Set autoresize mask
    [_tabBarView setAutoresizingMask:NSViewWidthSizable | NSViewMinYMargin];
    
    // Add it to view
    [self addSubview:_tabBarView];
    
    // Create a tab view
    _tabView = [[[NSTabView alloc] init] autorelease];
    
    // Set its delegate
    _tabView.delegate = self;
    
    // Enable layer for tab view
    _tabView.layer = [CALayer layer];
    _tabView.wantsLayer = TRUE;
    
    // Set its layer's delegate
    _tabView.layer.delegate = self;
    
    // Set its tab mode
    [_tabView setTabViewType:NSNoTabsNoBorder];
    
    // Set autoresize mask
    [_tabView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    // Add it to view
    [self addSubview:_tabView];
    
    /*
    // Create title view
    _titleView = [[[NSTextField alloc] initWithFrame:_tabBarView.bounds] autorelease];
    
    // Disable editing
    [_titleView setEditable:FALSE];
    
    // Disable bezeled mode
    [_titleView setBezeled:NO];
    
    // Disable drawing background
    [_titleView setDrawsBackground:NO];
    
    // Disable selectable mode
    [_titleView setSelectable:NO];
    
    // Set title
    [_titleView setStringValue:@"Test"];
    
    // Add it to view
    [_tabBarView addSubview:_titleView];*/
    
    // Create tab matrix
    _tabMatrix = [[NSMatrix alloc] init];
    
    // Set matrix mode
    [_tabMatrix setMode:NSRadioModeMatrix];
    
    // Disable empty selection
    [_tabMatrix setAllowsEmptySelection:FALSE];
    
    // Disable selection by rect
    [_tabMatrix setSelectionByRect:FALSE];
    
    // Set cell class
    [_tabMatrix setCellClass:[CCToolBarButtonCell class]];
    
    // Set intercell spacing
    [_tabMatrix setIntercellSpacing:NSMakeSize(1.0f, 0.0f)];
    
    // Add target / action to matrix
    [_tabMatrix setTarget:self];
    [_tabMatrix setAction:@selector(doActionForMatrix:)];
    
    // Add matrix to tab bar
    [_tabBarView addSubview:_tabMatrix];
    
    // Set default tab size
    self.tabSize = CCTabViewTabSizeSmall;
    
    // Set default position
    self.tabsPosition = CCTabViewPositionCenter;
}

- (void)initButtonCell:(NSButtonCell *)buttonCell withTabViewItem:(CCTabViewItem *)tabViewItem {
    // Set its button type
    [buttonCell setButtonType:NSRadioButton];
    
    // Set highlights mode
    [buttonCell setHighlightsBy:NSPushInCellMask];
    
    // Set its image
    [buttonCell setImage:tabViewItem.icon];
    
    // Set its title
    [buttonCell setTitle:tabViewItem.label];
    
    // Set image position
    [buttonCell setImagePosition:(_tabSize == CCTabViewTabSizeLarge) ? NSImageAbove : NSImageOnly];
    
    // Set font style
    [buttonCell setBackgroundStyle:NSBackgroundStyleRaised];
    [buttonCell setFont:[NSFont controlContentFontOfSize:11.0f]];
}

- (void)updateTabBarViewFrame {
    // Calculate tab bar view height
    CGFloat height = _cellSize.height + _tabsMargin.top + _tabsMargin.bottom;
    
    // Calculate tab bar view frame
    _tabBarView.frame = CGRectMake(0.0f, self.frame.size.height - height, self.frame.size.width, height);
}

- (void)updateTabViewFrame {
    // Calculate tab view frame
    _tabView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, _tabBarView.frame.origin.y + 1.0f);
}

- (void)updateTabMatrixFrame {
    // Recalculate size of matrix
    [_tabMatrix sizeToCells];
    
    // Get tab matrix frame
    NSRect frame = _tabMatrix.frame;
    
    // Calculate y position
    frame.origin.y = (_tabBarView.frame.size.height - frame.size.height) - _tabsMargin.top;
    
    // Create default autoresizeMask
    NSUInteger autoresizeMask = 0;
    
    // Calculate x position
    switch (_tabsPosition) {
        case CCTabViewPositionLeft:
            // Calculate left position
            frame.origin.x = _tabsMargin.left;
            
            // Set autoresize mask
            autoresizeMask = NSViewMaxXMargin;
        break;
        
        case CCTabViewPositionRight:
            // Calculate right position
            frame.origin.x = (_tabBarView.frame.size.width - frame.size.width) - _tabsMargin.right;
            
            // Set autoresize mask
            autoresizeMask = NSViewMinXMargin;
        break;
        
        default:
            // Calculate center position
            frame.origin.x = (_tabBarView.frame.size.width - frame.size.width) / 2.0f;
            
            // Set autoresize mask
            autoresizeMask = NSViewMinXMargin | NSViewMaxXMargin;
        break;
    }
    
    // Set tab matrix frame
    _tabMatrix.frame = frame;
    
    // Set autoresize mask
    [_tabMatrix setAutoresizingMask:autoresizeMask];
}

- (NSInteger)indexOfSelectedItem {
    // Return index of selected item or -1 if no item selected
    return [_tabMatrix selectedColumn];
}

- (void)syncMatrixWithTabView {
    // Sync selected tab in matrix
    [_tabMatrix selectCellAtRow:0 column:[_tabView indexOfTabViewItem:[_tabView selectedTabViewItem]]];
}

- (void)doActionForMatrix:(id)sender {
    // Check if selection has not changed
    if ([_tabMatrix selectedColumn] == [_tabView indexOfTabViewItem:[_tabView selectedTabViewItem]]) {
        // Exit
        return;
    }
    
    // Update tab selection
    [_tabView takeSelectedTabViewItemFromSender:self];
}

- (id<CAAction>)actionForLayer:(CALayer *)theLayer forKey:(NSString *)theKey {
    // Check if not good layer
    if (theLayer != _tabView.layer) {
        // Exit
        return nil;
    }
    
    // Return transition
    return _transition;
}


#pragma mark - Public methods -

- (void)updateTabViewItem:(CCTabViewItem *)item {
    // Get index of item
    NSInteger index = [_tabView indexOfTabViewItem:item];
    
    // If not found
    if (index == NSNotFound) {
        // Exit
        return;
    }
    
    // Get cell from matrix
    NSButtonCell *buttonCell = [_tabMatrix cellAtRow:0 column:index];
    
    // Initialize cell with item
    [self initButtonCell:buttonCell withTabViewItem:item];
}

- (void)addTabViewItem:(CCTabViewItem *)tabViewItem {
    // Add item to tab view
    [_tabView addTabViewItem:tabViewItem];
    
    // Get number of tab view items
    NSInteger numberTabViewItems = [_tabView numberOfTabViewItems];
    
    // Add new cell to matrix (use renewRows:columns: if matrix is empty else addColumn will raises an NSRangeException from the doc)
    if (numberTabViewItems > 1) {
        [_tabMatrix addColumn];
    } else {
        [_tabMatrix renewRows:1 columns:numberTabViewItems];
    }
    
    // Get the added button cell
    NSButtonCell *buttonCell = [_tabMatrix cellAtRow:0 column:numberTabViewItems - 1];
    
    // Initialize it
    [self initButtonCell:buttonCell withTabViewItem:tabViewItem];
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (void)insertTabViewItem:(CCTabViewItem *)tabViewItem atIndex:(NSInteger)index {
    // Insert it into tab view
    [_tabView insertTabViewItem:tabViewItem atIndex:index];
    
    // Insert column to matrix
    [_tabMatrix insertColumn:index];
    
    // Get the added button cell
    NSButtonCell *buttonCell = [_tabMatrix cellAtRow:0 column:index];
    
    // Initialize it
    [self initButtonCell:buttonCell withTabViewItem:tabViewItem];
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (void)removeTabViewItem:(CCTabViewItem *)tabViewItem {
    // Get index of tab view item
    NSInteger index = [_tabView indexOfTabViewItem:tabViewItem];
    
    // Remove it from tab view
    [_tabView removeTabViewItem:tabViewItem];
    
    // If index is not ok
    if (index == NSNotFound) {
        // Exit
        return;
    }
    
    // Remove column from matrix
    [_tabMatrix removeColumn:index];
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (void)removeAllTabViewItems {
    NSTabViewItem *tabViewItem;
    
    // Browse all tab view items
    while ([_tabView numberOfTabViewItems] > 0) {
        // Get first tab view item
        tabViewItem = [_tabView tabViewItemAtIndex:0];
        
        // Remove it
        [_tabView removeTabViewItem:tabViewItem];
        
        // Remove colum from matrix
        [_tabMatrix removeColumn:0];
    }
    
    // Update tab matrix frame
    [self updateTabMatrixFrame];
}

- (NSInteger)indexOfTabViewItem:(CCTabViewItem *)tabViewItem {
    // Use tab view as delegate to manage the message
    return [_tabView indexOfTabViewItem:tabViewItem];
}

- (NSInteger)indexOfTabViewItemWithIdentifier:(id)identifier {
    // Use tab view as delegate to manage the message
    return [_tabView indexOfTabViewItemWithIdentifier:identifier];
}

- (NSInteger)numberOfTabViewItems {
    // Use tab view as delegate to manage the message
    return [_tabView numberOfTabViewItems];
}

- (CCTabViewItem *)tabViewItemAtIndex:(NSInteger)index {
    // Use tab view as delegate to manage the message
    return (CCTabViewItem *) [_tabView tabViewItemAtIndex:index];
}

- (NSArray *)tabViewItems {
    // Use tab view as delegate to manage the message
    return [_tabView tabViewItems];
}

- (void)selectFirstTabViewItem:(id)sender {
    // Use tab view as delegate to manage the message
    [_tabView selectFirstTabViewItem:sender];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (void)selectLastTabViewItem:(id)sender {
    // Use tab view as delegate to manage the message
    [_tabView selectLastTabViewItem:sender];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (void)selectNextTabViewItem:(id)sender {
    // Use tab view as delegate to manage the message
    [_tabView selectNextTabViewItem:sender];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (void)selectPreviousTabViewItem:(id)sender {
    // Use tab view as delegate to manage the message
    [_tabView selectPreviousTabViewItem:sender];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (void)selectTabViewItem:(CCTabViewItem *)tabViewItem {
    // Use tab view as delegate to manage the message
    [_tabView selectTabViewItem:tabViewItem];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (void)selectTabViewItemAtIndex:(NSInteger)index {
    // Use tab view as delegate to manage the message
    [_tabView selectTabViewItemAtIndex:index];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (void)selectTabViewItemWithIdentifier:(id)identifier {
    // Use tab view as delegate to manage the message
    [_tabView selectTabViewItemWithIdentifier:identifier];
    
    // Sync matrix with tab view
    [self syncMatrixWithTabView];
}

- (CCTabViewItem *)selectedTabViewItem {
    // Use tab view as delegate to manage the message
    return (CCTabViewItem *) [_tabView selectedTabViewItem];
}

- (void)takeSelectedTabViewItemFromSender:(id)sender {
    // Use tab view as delegate to manage the message
    [_tabView takeSelectedTabViewItemFromSender:sender];
}

@end
