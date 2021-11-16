//
//  PriorityQueue.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/1.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "PriorityQueue.h"

#define INITIAL_CAPACITY 50
@implementation PriorityQueue

#pragma mark - Initialization
- (id)init{
    return [self initWithCapacity:INITIAL_CAPACITY andType:nil];
}

- (id)initWithObjects:(NSSet *)objects{
    self = [self initWithCapacity:INITIAL_CAPACITY andType:nil];
    for (id<comparable, NSObject>object in objects){
        [self add:object];
    }
    return self;
}

- (id)initWithCapacity:(int)capacity{
    return [self initWithCapacity:capacity andType:nil];
}

- (id)initWithCapacity:(int)capacity andType:(Class)oType{
    self = [super init];
    if(self){
        queue = [[NSMutableArray alloc] init];
        type = oType;
    }
    return self;
}

#pragma mark - Useful information
- (BOOL)isEmpty{
    if(queue.count == 0){
        return YES;
    }
    else{ return NO;}
}

- (BOOL)contains:(id<comparable, NSObject>)object{
    //Search the array to see if the object is already there
    for(id<comparable> o in queue){
        if([o isEqual:object]){
            return YES;
        }
    }
    return NO;
}

- (Class)typeOfAllowedObjects{
    NSLog(@"Allowed Types: %@", type);
    return type;
}

- (int) size{
    return [queue count];
}

#pragma mark - Mutation
//Mutation
- (void)clear{
    [queue removeAllObjects];
}

//A "greater" object (compareTo returns 1) is at the end of the queue.
- (BOOL)add:(id<comparable, NSObject>)object{
    //Make sure the object's type is the same as the type of the queue
    if(type == nil){
//        NSLog(@"Type is nil");
        type = [object class];
    }
    if([object class] != type){
        NSLog(@"ERROR: Trying to add incorrect object");
        return NO;
    }

    if([queue count] == 0){
        [queue addObject:object];
        return YES;
    }
    for(int i = 0; i < [queue count]; i++){
        if([object compareTo:queue[i]] < 0){
            [queue insertObject:object atIndex:i];
            return YES;
        }
    }
    [queue addObject:object];
    return YES;
}

- (void)remove:(id<comparable, NSObject>)object{
    [queue removeObject:object];
}

#pragma mark - Getting things out
- (id)peek{
    return queue[0];
}

- (id)poll{
    //Get the object at the front
    id head = queue[0];

    //Remove and return that object
    [queue removeObject:head];
    return head;
}

- (id)objectMatchingObject:(id<comparable, NSObject>)object{
    //Search the array to see if the object is already there
    for(id<comparable> o in queue){
        if([o isEqual:object]){
            return o;
        }
    }
    return nil;
}

- (NSArray *)toArray{
    return [[NSArray alloc] initWithArray:queue];
}

#pragma mark -
- (NSString *)description{
    return [NSString stringWithFormat:@"PriorityQueue: %@ allows objects of type %@", queue, type];
}

- (void)print{
    NSLog(@"%@", [self description]);
}

@end
