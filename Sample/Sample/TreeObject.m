//
//  TreeObject.m
//  TestSaveWindow
//
//  Created by Jonathan Baliko on 24/11/12.
//  Copyright (c) 2012 Jonathan Baliko. All rights reserved.
//

#import "TreeObject.h"


@interface TreeObject ()

@property (nonatomic, weak, readwrite) TreeObject *parent;

@end

@implementation TreeObject

@synthesize data = _data, childs = _childs, parent = _parent;


- (id)init {
    // Call parent method
    if ((self = [super init])) {
        // Initialize members
        _data = nil;
        _childs = [[NSMutableArray alloc] init];
        _parent = nil;
    }
    
    // Return object
    return self;
}

- (id)initWithData:(NSString *)data {
    // Call init method
    if ((self = [self init])) {
        // Set data
        self.data = data;
    }
    
    // Return object
    return self;
}

- (void)addChild:(TreeObject *)child {
    [_childs addObject:child];
    child.parent = self;
}

- (void)removeChild:(TreeObject *)child {
    [_childs removeObject:child];
    child.parent = nil;
}

@end
