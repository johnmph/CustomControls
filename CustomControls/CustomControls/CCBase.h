//
//  CCBase.h
//  CustomControl
//
//  Created by Jonathan Baliko on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Structures -

typedef struct {
    CGFloat left;
    CGFloat right;
    CGFloat top;
    CGFloat bottom;
} CCMargin;


#pragma mark - Constantes declaration -

// Zero margin
CG_EXTERN const CCMargin CCMarginZero;


#pragma mark - Functions declaration -

// Make a margin
CG_INLINE CCMargin CCMarginMake(CGFloat left, CGFloat right, CGFloat top, CGFloat bottom);

// Check if a margin is equal to another
CG_EXTERN bool CCMarginEqualToMargin(CCMargin margin1, CCMargin margin2);


#pragma mark - Inline functions -

CG_INLINE CCMargin CCMarginMake(CGFloat left, CGFloat right, CGFloat top, CGFloat bottom) {
    CCMargin margin; margin.left = left; margin.right = right; margin.top = top; margin.bottom = bottom; return margin;
}

CG_INLINE bool __CCMarginEqualToMargin(CCMargin margin1, CCMargin margin2) {
    return margin1.left == margin2.left && margin1.right == margin2.right && margin1.top == margin2.top && margin1.bottom == margin2.bottom;
}

#define CCMarginEqualToMargin __CCMarginEqualToMargin
