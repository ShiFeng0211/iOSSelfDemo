//
//  ListNode.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/6.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode 

- (id)copyWithZone:(nullable NSZone *)zone {
    ListNode *listNode = [[ListNode alloc] init];
    return listNode;
}


- (int)value {
    if (_content != nil && [_content isKindOfClass:NSClassFromString(@"NSNumber")]) {
        return [(NSNumber *)_content intValue];
    }
    return 0;
}

// 打印从当前节点开始之后所有的节点数据
- (void)printAllListNode {
    ListNode *curNode = self;
    while (curNode) {
        ListNode *preNode = curNode.previous;
        ListNode *nextNode = curNode.next;
        NSLog(@"curNode=%p, value=%d, preNode=%p, nextNode=%p",curNode, curNode.value, preNode, nextNode);
        curNode = curNode.next;
    }
}

@end
