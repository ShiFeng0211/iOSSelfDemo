//
//  LinkList.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/12.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinkList : NSObject

@property (nonatomic) ListNode *headNode;
@property (nonatomic) ListNode *tailNode;

- (instancetype)initLikListWithNunbers:(NSArray *)numbers;

- (void)insertNode:(ListNode *)node withHandle:(void(^)(BOOL success, NSError *error))completeHandle;

- (void)printList;

@end

NS_ASSUME_NONNULL_END
