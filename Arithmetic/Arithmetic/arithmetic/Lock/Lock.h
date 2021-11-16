//
//  Lock.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/20.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Lock : NSObject

-(void)lock;
-(void)unlock;

@end


@interface ReadWriteLock : NSObject

- (void)lockRead;
- (void)unlockRead;

- (void)lockWrite;
- (void)unlockWrite;

@end
NS_ASSUME_NONNULL_END
