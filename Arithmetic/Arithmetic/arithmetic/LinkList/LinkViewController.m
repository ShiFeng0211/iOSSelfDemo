//
//  LinkViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/6.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "LinkViewController.h"
#import <Masonry/Masonry.h>
#import "ListNode.h"
#import "LinkedArray.h"
#import "LinkList.h"

typedef struct {
    ListNode *tailNode;
    int size;
} ListTailNodeAndSize;

@interface LinkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;
@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.arrdata = @[@"链表中倒数第K个节点",@"反转链表",@"合并链表（递归）",@"创建链表",@"移除重复节点",@"判断链表是否相交"];
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrdata.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.arrdata[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            NSArray *arr = [[self getRandomArr] copy];
            NSLog(@"生成的数组为%@",arr);
            LinkedArray *linkedArr = [[LinkedArray alloc] initLiknedArrayWithNunbers:arr];
            ListNode *findNode = [self findKthToTail:linkedArr Kth:3];
            NSLog(@"find link Node value = %@",findNode.content);
        }
        break;
        case 1:
        {
            NSArray *arr = [[self getRandomArr] copy];
            NSLog(@"生成的数组为%@",arr);
            LinkedArray *linkedArr = [[LinkedArray alloc] initLiknedArrayWithNunbers:arr];
            [self reserseList:linkedArr];
            NSLog(@"反转后的链表 %@",linkedArr);
        }
        case 2:
        {
            NSArray *arr1 = [[self getRandomArr] copy];
            NSLog(@"生成的数组为%@",arr1);
            LinkedArray *linkedArr1 = [[LinkedArray alloc] initLiknedArrayWithNunbers:arr1];
            NSArray *arr2 = [[self getRandomArr] copy];
            NSLog(@"生成的数组为%@",arr2);
            LinkedArray *linkedArr2 = [[LinkedArray alloc] initLiknedArrayWithNunbers:arr2];

            ListNode *mergeNode = [self mergeLinked:[linkedArr1 getFirstListNode] withOtherLink:[linkedArr2 getFirstListNode]];
            NSLog(@"合并后的 %@",mergeNode);
        }
        break;
        case 3: {
            LinkList *list = [[LinkList alloc] init];
            for (int i=0; i<5; i++) {
                ListNode *node = [[ListNode alloc] init];
                node.content = [NSNumber numberWithInt:i];
                [list insertNode:node
                      withHandle:^(BOOL success, NSError * _Nonnull error) {
                    NSLog(@"error = %@",error.description);
                }];
                
                
            }
            [list printList];
        }
        break;
        case 4: {
            NSArray *arr1 = @[@1,@2,@3,@4,@5,@6,@3,@8,@4,@3];
            LinkList *linkList = [[LinkList alloc] initLikListWithNunbers:arr1];
            [self deleteDups:linkList];
            [linkList printList];
        }
        break;
        case 5: {
            NSArray *arr1 = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
            NSArray *arr2 = @[@33,@44,@55,@6,@7,@8,@9,@10];
            LinkList *linkList1 = [[LinkList alloc] initLikListWithNunbers:arr1];
            LinkList *linkList2 = [[LinkList alloc] initLikListWithNunbers:arr2];
            [self findIntersection:linkList1 withList:linkList2];
        }
            break;
        case 6: {
            NSArray *arr1 = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
            LinkList *linkList = [[LinkList alloc] initLikListWithNunbers:arr1];
            [self FindBeginning:linkList];
            
        }
        default:
        break;
    }
}

#pragma mark

-(NSMutableArray *)getRandomArr {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        int num = random()%100;
        NSNumber *n = [NSNumber numberWithInt:num];
        [arr addObject:n];
    }
    return arr;
}

//删除重复节点
-(void)deleteDups:(LinkList *)listList {
    
    [listList printList];
    NSMutableSet *myMutableSet = [[NSMutableSet alloc] init];
    ListNode *node = listList.headNode;
    ListNode *preNode;
    while (node) {
        if ([myMutableSet containsObject:node.content]) {
            // 删除节点 ,因为拿不到前节点，所以要把nex节点的值复制到当前节点，然后删除next节点
            preNode.next = node.next;
        } else {
            preNode = node;
            [myMutableSet addObject:node.content];
        }
        node = node.next;
    }
}

// 查找单向链表中倒数第k个节点
/*
    思路
*/

-(ListNode *)findKthToTail:(LinkedArray *)linkedArr Kth:(int)k {
    
    ListNode *aheadNode = (ListNode *)[linkedArr objectAtIndex:0];
    ListNode *findNode = (ListNode *)[linkedArr objectAtIndex:0];
    
    for (int i=0; i<k-1; i++) {
        aheadNode = aheadNode.next;
    }

    while (aheadNode.next.content) {
        aheadNode = aheadNode.next;
        findNode = findNode.next;
    }

    return findNode;
}

// 判断链表是否是个环，若是环返回slow 和 fast 指针相遇的node，若不是则返回一个为空的node

-(ListNode *)meetingNode:(LinkedArray *)linkedarr {
    
    if (linkedarr.size == 0) {
        return nil;
    }
    
    ListNode *slowNode = (ListNode *)[linkedarr objectAtIndex:0];
    ListNode *fastNode = (ListNode *)[linkedarr objectAtIndex:0];
    
    while (fastNode && slowNode) {
        if (fastNode == slowNode) {
            return fastNode;
        }
        
        slowNode = slowNode.next;
        fastNode = fastNode.next;
        
        if (fastNode) {
            fastNode = fastNode.next;
        }
    }
    
    return nil;
}

// 查找linked 环里的个数
-(int)findLoopNodeNumbs:(LinkedArray *)linkedArr {
    int loopNum = 1;
    ListNode *meetNode = [self meetingNode:linkedArr];
    ListNode *tempNode = meetNode;
    
    while (tempNode != meetNode) {
        tempNode = tempNode.next;
        loopNum++;
    }
    return loopNum;
}

// 查找linked 环的入口
-(ListNode *)entryNodeOfLoop:(LinkedArray *)arr {
    ListNode *node1 = (ListNode *)[arr objectAtIndex:0];
    ListNode *node2 = (ListNode *)[arr objectAtIndex:0];
    LinkedArray *linkedNodes = [[LinkedArray alloc] initLiknedArrayWithNunbers:[self getRandomArr]];
    int loopNum = [self findLoopNodeNumbs:linkedNodes];
    //先让ndel1 走
    for (int i=0; i<loopNum; i++) {
        node1 = node1.next;
    }
    while (node2 != node1) {
        node1 = node1.next;
        node2 = node2.next;
    }
    return node1;
}

//反转链表
-(ListNode *)reserseList:(LinkedArray *)linkedArr {
    
    ListNode *pReversedHead = nil;
    ListNode *pNode = (ListNode *)[linkedArr objectAtIndex:0];
    ListNode *pPer = nil;
    
    while (pNode) {
        ListNode *pNext = pNode.next;
        if (pNext == nil) {
            pReversedHead = pNode;
        }
        
        pNode.next = pPer;
        pPer = pNode;
        pNode = pNext;
    }
    return nil;
}

-(ListNode *)mergeLinked:(ListNode *)note1 withOtherLink:(ListNode *)note2 {
    if (note1 == nil && note2 != nil) {
        return note2;
    } else if (note2 == nil && note1 != nil) {
        return note1;
    } else if ((note2 == nil && note1 == nil)) {
        return nil;
    }
    
    ListNode *mergeList;
    if (note1.content < note2.content) {
        mergeList = note1;
        mergeList.next = [self mergeLinked:note1.next withOtherLink:note2];
    } else if (note2.content < note1.content) {
        mergeList.next = [self mergeLinked:note1 withOtherLink:note2.next];
    }
    
    return nil;
}

-(ListNode *)findIntersection:(LinkList *)list1 withList:(LinkList *)list2 {
    // 获取列表尾部node 以及 列表大小
    ListTailNodeAndSize list1Tail = [self getTailNode:list1];
    ListTailNodeAndSize list2Tail = [self getTailNode:list2];
    
    // tail node 不等，提前退出
//    if (list1Tail.tailNode != list2Tail.tailNode) {
//        return nil;
//    }

    int list1Size = list1Tail.size;
    int list2Size = list2Tail.size;
    
    LinkList *shortList = (list1Size<list2Size)?list1:list2;
    LinkList *longList = (list1Size<list2Size)?list2:list1;
    
    
    for (int i=0; i<(abs(list1Size-list2Size)); i++) {
        while (longList.headNode) {
            longList.headNode = longList.headNode.next;
        }
    }
    
    while (shortList.headNode != longList.headNode) {
        shortList.headNode = shortList.headNode.next;
        longList.headNode = longList.headNode.next;
    }
    
    return longList.headNode;
}

-(ListTailNodeAndSize)getTailNode:(LinkList *)list {
    ListNode *tailNode = list.headNode;
    int listSize = 1;
    while (tailNode.next) {
        listSize ++;
        tailNode = tailNode.next;
    }
    ListTailNodeAndSize tailNodeStruct = {tailNode,listSize};
    return tailNodeStruct;
}

// 判断有没有环，并返回环的入口
-(ListNode *)FindBeginning:(LinkList *)list {
    
    ListNode *fastNode = list.headNode;
    ListNode *slowNode = list.headNode;
    
    return nil;
}

#pragma mark Getter
-(UITableView *)tbView {
    if(!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tbView.backgroundColor = [UIColor whiteColor];
    }
    return _tbView;
}
@end
