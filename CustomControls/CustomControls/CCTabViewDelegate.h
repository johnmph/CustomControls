//
//  CCTabViewDelegate.h
//  CustomControls
//
//  Created by Jonathan Baliko on 29/11/12.
//
//

#import <Foundation/Foundation.h>


@class CCTabView, CCTabViewItem;

@protocol CCTabViewDelegate <NSObject>

@optional

// Called when tab view items are added or removed
- (void)tabViewDidChangeNumberOfTabViewItems:(CCTabView *)tabView;

// Called to ask if a tab view item should be selected
- (BOOL)tabView:(CCTabView *)tabView shouldSelectTabViewItem:(CCTabViewItem *)tabViewItem;

// Called when a tab view will be selected
- (void)tabView:(CCTabView *)tabView willSelectTabViewItem:(CCTabViewItem *)tabViewItem;

// Called when a tab view item is selected
- (void)tabView:(CCTabView *)tabView didSelectTabViewItem:(CCTabViewItem *)tabViewItem;

@end
