//
//  KStack.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/19.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "KStack.h"

@interface KStack()

@property (nonatomic) NSMutableArray *mutableArr;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic) dispatch_semaphore_t stackSemaphore;

@end

@implementation KStack

-(instancetype)initStackWithArray:(NSArray *)arr {
    self = [super init];
    if (self) {
        self.mutableArr = [[NSMutableArray alloc] init];
        self.count = 0;
        
        for (int i=0 ; i<arr.count; i++) {
            [self push:arr[i]];
        }
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.mutableArr = [[NSMutableArray alloc] init];
        self.count = 0;
    }
    return self;
}

- (id)pop {
    if (_mutableArr.count == 0) return nil;
    NSObject *lastObj = [_mutableArr lastObject];
    [_mutableArr removeLastObject];
    _count--;
    return lastObj;
}

-(void)push:(id)obj {
    [_mutableArr addObject:obj];
    _count++;
}

-(void)clear {
    
    [_mutableArr removeAllObjects];
}

-(id)peekObj {
    return [_mutableArr lastObject];
}

-(NSInteger)getStackSize {
    return _count;
}

-(void)printStack {
    for (int i=0; i<_mutableArr.count; i++) {
        NSLog(@"%@",_mutableArr[i]);
    }
}

@end
