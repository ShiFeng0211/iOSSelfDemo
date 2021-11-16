//
//  StackQueue.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/21.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StackQueue : NSObject

-(void)add:(NSObject *)obj;

-(id)peek;

-(id)pull;

-(NSInteger)getQueueSize;

@end

NS_ASSUME_NONNULL_END
