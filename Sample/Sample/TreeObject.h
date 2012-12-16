//
//  TreeObject.h
//  TestSaveWindow
//
//  Created by Jonathan Baliko on 24/11/12.
//  Copyright (c) 2012 Jonathan Baliko. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TreeObject : NSObject {
    // Data
    NSString *_data;
    
    // Childs
    NSMutableArray *_childs;
    
    // Parent
    __weak TreeObject *_parent;
}

// Data
@property (nonatomic, copy, readwrite) NSString *data;

// Childs
@property (nonatomic, strong, readonly) NSArray *childs;

// Parent
@property (nonatomic, weak, readonly) TreeObject *parent;


// Init with data
- (id)initWithData:(NSString *)data;

// Add child
- (void)addChild:(TreeObject *)child;

// Remove child
- (void)removeChild:(TreeObject *)child;

@end
