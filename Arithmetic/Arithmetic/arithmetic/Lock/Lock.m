//
//  Lock.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/20.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "Lock.h"

@interface Lock()

@property (nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation Lock

-(instancetype)init {
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}


-(void)lock {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
}

-(void)unLock {
    dispatch_semaphore_signal(_semaphore);
}

@end


@implementation ReadWriteLock {
    Lock *_readLock;
    Lock *_writeLock;
    NSInteger _readCount;
}

- (instancetype)init {
    if (self = [super init]) {
        _readLock = [Lock new];
        _writeLock = [Lock new];
        _readCount = 0;
    }
    return self;
}

- (void)lockRead {
    [_readLock lock];
    _readCount++;
    if (_readCount == 1) {
        [_writeLock lock];
    }
    [_readLock unlock];
}

- (void)unlockRead {
    [_readLock lock];
    _readCount--;
    if (_readCount == 0) {
        [_writeLock unlock];
    }
    [_readLock unlock];
}

- (void)lockWrite {
    [_writeLock lock];
}

- (void)unlockWrite {
    [_writeLock unlock];
}

@end
