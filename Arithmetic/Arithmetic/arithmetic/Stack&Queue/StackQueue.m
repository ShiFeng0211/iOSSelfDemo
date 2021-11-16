//
//  StackQueue.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/21.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "StackQueue.h"
#import "KStack.h"

@interface StackQueue()
@property (nonatomic,assign) NSInteger count;
@property (nonatomic)KStack *inStack;
@property (nonatomic)KStack *outStack;
@end

@implementation StackQueue

-(instancetype)init {
    self = [super init];
    if (self) {
        self.inStack = [[KStack alloc] init];
        self.outStack = [[KStack alloc] init];
        self.count = 0;
    }
    return self;
}

-(void)add:(NSObject *)obj {
    [self.inStack push:obj];
}

-(id)peek {
    [self changedStack];
    if (self.outStack.getStackSize != 0) {
        return [self.outStack peekObj];
    } else {
        return nil;
    }
}

-(void)changedStack {
    if (self.outStack.getStackSize == 0) {
        while (self.inStack.getStackSize != 0) {
            NSObject *o = [self.inStack pop];
            [self.outStack push:o];
        }
    }
}

-(id)pull {
    [self changedStack];
    if (self.outStack.getStackSize != 0) {
        return [self.outStack peekObj];
    } else {
        return nil;
    }
}

-(NSInteger)getQueueSize {
    return [self.inStack getStackSize] + [self.outStack getStackSize];
}

@end
