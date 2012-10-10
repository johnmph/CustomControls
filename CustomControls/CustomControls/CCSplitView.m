//
//  CCSplitView.m
//  CustomControls
//
//  Created by Jonathan Baliko on 8/10/12.
//  Copyright (c) 2012 Jonathan Baliko. All rights reserved.
//

#import "CCSplitView.h"
#import <QuartzCore/QuartzCore.h>


#pragma mark - Private interfaces -

@interface CCSplitView ()

// Parse divider index in a key
- (BOOL)parseDividerIndex:(NSInteger *)index fromKey:(NSString *)key;

@end


#pragma mark - Implementations -

@implementation CCSplitView

NSString *const DividerPositionKey = @"dividerPosition";


#pragma mark - Init / Dealloc methods -



#pragma mark - NSKeyValueCoding protocol methods -

- (id)valueForUndefinedKey:(NSString *)key {
    // If found a divider index in key
    NSInteger index;
    
    if ([self parseDividerIndex:&index fromKey:key]) {
        // Get position of divider at index
        CGFloat position = [self positionForDividerAtIndex:index];
        
        // Return position in NSNumber object wrapper
        return [NSNumber numberWithFloat:position];
    }
    
    // Call parent method
    return [super valueForUndefinedKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // If found a divider index in key
    NSInteger index;
    
    if ([self parseDividerIndex:&index fromKey:key]) {
        // Ensure that value is a NSNumber
        NSAssert([value isKindOfClass:[NSNumber class]], @"value %@ must be a NSNumber object", value);
        
        // Set divider position
        [self setPosition:[value floatValue] ofDividerAtIndex:index];
    } else {
        // Call parent method
        [super setValue:value forUndefinedKey:key];
    }
}


#pragma mark - NSAnimatablePropertyContainer protocol methods -

+ (id)defaultAnimationForKey:(NSString *)key {
    // If divider position key
    if ([key isEqualToString:DividerPositionKey]) {
        // Return simple linear interpolation animation
        return [CABasicAnimation animation];
    }
    
    // Call parent method
    return [super defaultAnimationForKey:key];
}

- (id)animationForKey:(NSString *)key {
    // If key starts with divider position key
    if ([key hasPrefix:DividerPositionKey]) {
        // Set key as divider position key
        key = DividerPositionKey;
    }
    
    // Call parent method
    return [super animationForKey:key];
}


#pragma mark - Private methods -

- (BOOL)parseDividerIndex:(NSInteger *)index fromKey:(NSString *)key {
    // If key doesn't start with divider position key
    if (![key hasPrefix:DividerPositionKey]) {
        // Not found
        return FALSE;
    }
    
    // Get index
    *index = [[key substringFromIndex:DividerPositionKey.length] integerValue];
    
    // Found
    return TRUE;
}


#pragma mark - Public methods -

- (CGFloat)positionForDividerAtIndex:(NSInteger)index { // TODO: isFlipped ? ( http://openradar.appspot.com/8250671 )
    // Get frame of view at left of divider at index
    NSRect frame = [[self.subviews objectAtIndex:index] frame];
    
    // Get position of divider regarding its orientation
    CGFloat position = (self.isVertical) ? NSMaxX(frame) : NSMaxY(frame);
    
    // Return position
    return position;// + ([self dividerThickness] * 0.5f);//TODO: voir si a partir de gauche ou du milieu pour sa position mais normalement ok a gauche
}

- (void)setPosition:(CGFloat)position ofDividerAtIndex:(NSInteger)dividerIndex animated:(BOOL)animated {
    // If animated
    if (animated) {
        // Create key with divider index
        NSString *key = [NSString stringWithFormat:@"%@%li", DividerPositionKey, dividerIndex];
        
        // Animate setting of the divider position
        [[self animator] setValue:[NSNumber numberWithFloat:position] forKey:key];
    } else {
        // Set position of divider
        [self setPosition:position ofDividerAtIndex:dividerIndex];
    }
}

@end
