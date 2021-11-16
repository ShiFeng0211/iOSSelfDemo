//
//  LinkList.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/12.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "LinkList.h"
@interface LinkList ()
@end

typedef NS_ENUM(NSInteger,MYCommonError) {
    MYCommonErrorValueNull = -100,
    MYCommonErrorListNull = -200
};

@implementation LinkList

- (instancetype)initLikListWithNunbers:(NSArray *)numbers {
    self = [super init];
    if (self) {
        for (int i=0; i<numbers.count; i++) {
            ListNode *node = [[ListNode alloc] init];
            node.content = numbers[i];
            [self insertNode:node withHandle:^(BOOL success, NSError * _Nonnull error) {
                
            }];
        }
    }
    return self;
}

- (void)insertNode:(ListNode *)node withHandle:(void(^)(BOOL success, NSError *error))completeHandle {

//    if(!node) {
//        if (completeHandle) {
//            NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
//            info[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"输入参数有误"];
//            NSError *err = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:MYCommonErrorValueNull userInfo:info];
//            completeHandle(NO,err);
//        }
//        return self;
//    }
    
    // 头插
    if (!self.headNode) {
        self.headNode = node;
        self.tailNode = self.headNode;
    } else {
        ListNode *tempNode = node;
        tempNode.next = self.headNode;
        self.headNode = tempNode;
    }
    
    
    
//    // 尾插
//    if (!self.tailNode) {
//        self.tailNode = node;
//        self.headNode = self.tailNode;
//    } else {
//        self.tailNode.next = node;
//        self.tailNode = self.tailNode.next;
//        self.tailNode.next = NULL;
//    }
    
}

-(void)printList {
   
    NSMutableString *str = [[NSMutableString alloc] init];
    ListNode *temp = self.headNode;
    while (temp) {
        [str appendFormat:@"%d",temp.value];
        temp = temp.next;
    }
    NSLog(@"列表为%@",str);
}
@end
