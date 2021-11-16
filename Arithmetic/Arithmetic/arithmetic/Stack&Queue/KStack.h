//
//  KStack.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/19.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KStack : NSObject

-(instancetype)initStackWithArray:(NSArray *)arr;

-(id)pop;

-(void)push:(id)obj;

-(void)clear;

-(id)peekObj;

-(NSInteger)getStackSize;

-(void)printStack;

@end

NS_ASSUME_NONNULL_END
