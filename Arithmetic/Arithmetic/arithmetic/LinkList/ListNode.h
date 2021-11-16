//
//  ListNode.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/6.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 模拟链表实现
 */
@interface ListNode : NSObject<NSCopying>

/** 上个节点 */
@property (strong , nonatomic,nullable) ListNode *previous;

/** 下个节点 */
@property (strong , nonatomic, nullable) ListNode *next;


/** 当前节点内容 */
@property (strong , nonatomic) id content;

/** int */
@property(nonatomic, assign) int value;

/** 打印从当前节点开始之后所有的节点数据 */
- (void)printAllListNode;

@end
NS_ASSUME_NONNULL_END
