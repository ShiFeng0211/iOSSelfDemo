//
//  PriorityQueue.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/1.
//  Copyright © 2021 weibo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "comparable.h"


@interface PriorityQueue : NSObject{
    NSMutableArray *queue;
    Class type;
}

- (id)init;
- (id)initWithObjects:(NSSet *)objects;
- (id)initWithCapacity:(int)capacity;
- (id)initWithCapacity:(int)capacity andType:(Class)oType; //Queue will reject objects not of that type

#pragma mark - Useful information
- (BOOL)isEmpty;
- (BOOL)contains:(id<comparable, NSObject>)object;
- (Class)typeOfAllowedObjects; //Returns the type of objects allowed to be stored in the queue
- (int) size;

#pragma mark - Mutation
- (void)clear;
- (BOOL)add:(id<comparable, NSObject>)object;
- (void)remove:(id<comparable, NSObject>)object;

#pragma mark - Getting things out
- (id)peek;
- (id)poll;
- (id)objectMatchingObject:(id<comparable, NSObject>)object;
- (NSArray *)toArray;

#pragma mark -
- (void)print;

@end

