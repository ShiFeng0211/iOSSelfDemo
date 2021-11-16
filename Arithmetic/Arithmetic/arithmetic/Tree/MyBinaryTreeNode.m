//
//  BinaryTreeNode.m
//  Arithmetic
//
//  Created by v_shifeng on 2020/11/12.
//  Copyright © 2020 weibo. All rights reserved.
//

#import "MyBinaryTreeNode.h"
#import "KStack.h"

static NSMutableArray *treeArr;

@implementation MyBinaryTreeNode
/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *
 *  @param values 数组
 *
  *  @return 二叉树根节点
 */
+ (MyBinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    MyBinaryTreeNode *root = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [MyBinaryTreeNode addTreeNode:root value:value];
    }
    return root;
}

/**
 *  向二叉排序树节点添加一个节点
 *
 *  @param treeNode 根节点
 *  @param value    值
 *
 *  @return 根节点
 */
+ (MyBinaryTreeNode *)addTreeNode:(MyBinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [MyBinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }
    else if (value < treeNode.value) {
        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [MyBinaryTreeNode addTreeNode:treeNode.leftNode value:value];
    }
    else {
        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [MyBinaryTreeNode addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/**
 * 翻转二叉树（又叫：二叉树的镜像）
 *
 * @param rootNode 根节点
 *
 * @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (MyBinaryTreeNode *)invertBinaryTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    [MyBinaryTreeNode invertBinaryTree:rootNode.leftNode];
    [MyBinaryTreeNode invertBinaryTree:rootNode.rightNode];
    MyBinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    return rootNode;
}

/**
 *    非递归方式翻转
 */
  + (MyBinaryTreeNode *)invertBinaryTreeNot:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {  return nil; }
    if (!rootNode.leftNode && !rootNode.rightNode) {  return rootNode; }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        MyBinaryTreeNode *node = [queueArray firstObject];
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
    
        MyBinaryTreeNode *pLeft = node.leftNode;
        node.leftNode = node.rightNode;
        node.rightNode = pLeft;
    
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    
    }

    return rootNode;
}

/**
 *  二叉树中某个位置的节点（按层次遍历）
 *
 *  @param index    按层次遍历树时的位置(从0开始算)
 *  @param rootNode 树根节点
 *
 *  @return 节点
 */

+ (MyBinaryTreeNode *)sftreeNodeAtIndex:(NSInteger)index inTree:(MyBinaryTreeNode *)rootNode {
    MyBinaryTreeNode *resultNode;
    if (rootNode == nil || index< 0) return nil;
    
//    rootNode.value == index
    
    return resultNode;
}

+ (MyBinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(MyBinaryTreeNode *)rootNode {
    //按层次遍历
    if (!rootNode || index < 0) {
        return nil;
    }
    //数组当成队列
    NSMutableArray *queueArray = [NSMutableArray array];
    //压入根节点
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        MyBinaryTreeNode *node = [queueArray firstObject];
        if (index == 0) {
            return node;
        }
       [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        //移除节点，index减少
        index--;
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    
    }
    //层次遍历完，仍然没有找到位置，返回nil
    return nil;
}

/**
 *  先序遍历：先访问根，再遍历左子树，再遍历右子树。典型的递归思想。
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */


+ (void)sfpreOrderTraverseTree:(MyBinaryTreeNode *)rootNode {
    if (rootNode) {
        [treeArr addObject:[NSNumber numberWithInteger:rootNode.value]];
        [MyBinaryTreeNode sfpreOrderTraverseTree:rootNode.leftNode];
        [MyBinaryTreeNode sfpreOrderTraverseTree:rootNode.rightNode];
        
    }
}

+(void)saveRootNodeValue:(MyBinaryTreeNode *)rootNode  {
    treeArr = [NSMutableArray new];
    [MyBinaryTreeNode sfpreOrderTraverseTree:rootNode];
    NSLog(@"arr %@",treeArr);
}
/**
 *  前序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler {
    if (rootNode) {
    
        if (handler) {
            handler(rootNode);
        }
        [MyBinaryTreeNode preOrderTraverseTree:rootNode.leftNode handler:handler];
        [MyBinaryTreeNode preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  前遍历（非递归）
 *  先遍历左子树，再访问根，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTreeNot:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler {
    KStack *treeStack = [[KStack alloc] init];
    MyBinaryTreeNode *pNode = rootNode;
    while (pNode != nil || [treeStack getStackSize] != 0) {
        if (pNode != nil) {
            if (handler) {
                handler(rootNode);
            }
            [treeStack push:pNode];
            pNode = pNode.leftNode;
        } else {
            MyBinaryTreeNode *tempNode = [treeStack pop];
            pNode = tempNode.rightNode;
        }
    }
}
/**
 *  中序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)inOrderTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)  (MyBinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [MyBinaryTreeNode inOrderTraverseTree:rootNode.leftNode handler:handler];
    
        if (handler) {
            handler(rootNode);
        }
    
        [MyBinaryTreeNode inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  后序遍历
 *  先遍历左子树，再遍历右子树，再访问根
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)postOrderTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [MyBinaryTreeNode postOrderTraverseTree:rootNode.leftNode handler:handler];
        [MyBinaryTreeNode postOrderTraverseTree:rootNode.rightNode handler:handler];
        if (handler) {
            handler(rootNode);
        }
    }
}


/**
 *  层次遍历（广度优先）
 *
 *  @param rootNode 二叉树根节点
 *  @param handler  访问节点处理函数
 */
+ (void)levelTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler {
    if (!rootNode) {
        return;
    }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        MyBinaryTreeNode *node = [queueArray firstObject];
        if (handler) {
            handler(node);
        }
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先 出原则
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
}

/**
 *  二叉树的深度
 *
*  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }

    //左子树深度
    NSInteger leftDepth = [MyBinaryTreeNode depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [MyBinaryTreeNode depthOfTree:rootNode.rightNode];

    return MAX(leftDepth, rightDepth) + 1;
}

/**
 *  二叉树的宽度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树宽度
 */
+ (NSInteger)widthOfTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }

    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    NSInteger maxWidth = 1; //最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0; //当前层的宽度

    while (queueArray.count > 0) {
    
        curWidth = queueArray.count;
        //依次弹出当前层的节点
        for (NSInteger i=0; i<curWidth; i++) {
            MyBinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
            //压入子节点
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
        //宽度 = 当前层节点数
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    return maxWidth;
}

  /**
 *  二叉树的所有节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //节点数=左子树节点数+右子树节点数+1（根节点）
    return [MyBinaryTreeNode numberOfNodesInTree:rootNode.leftNode] + [MyBinaryTreeNode numberOfNodesInTree:rootNode.rightNode] + 1;
}

/**
 *  二叉树某层中的节点数
 *
 *  @param level    层
 *  @param rootNode 根节点
 *
 *  @return 层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode || level < 1) { //根节点不存在或者level<0
        return 0;
    }
    if (level == 1) { //level=1，返回1（根节点）
        return 1;
    }
    //递归：level层节点数 = 左子树level-1层节点数+右子树level-1层节点数
    return [MyBinaryTreeNode numberOfNodesOnLevel:level-1 inTree:rootNode.leftNode] + [MyBinaryTreeNode numberOfNodesOnLevel:level-1 inTree:rootNode.rightNode];
}

/**
 *  二叉树叶子节点数
 *
 *  @param rootNode 根节点
 *
*  @return 叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {
          return 0;
    }
    //左子树和右子树都是空，说明是叶子节点
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    //递归：叶子数 = 左子树叶子数 + 右子树叶子数
    return [MyBinaryTreeNode numberOfLeafsInTree:rootNode.leftNode] + [MyBinaryTreeNode numberOfLeafsInTree:rootNode.rightNode];
}

/**
 *  二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree:(MyBinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //    方案一：（递归次数较多，效率较低）
    //分3种情况：
    //1、最远距离经过根节点：距离 = 左子树深度 + 右子树深度
    NSInteger distance = [MyBinaryTreeNode depthOfTree:rootNode.leftNode] + [MyBinaryTreeNode depthOfTree:rootNode.rightNode];
   //2、最远距离在根节点左子树上，即计算左子树最远距离
    NSInteger disLeft = [MyBinaryTreeNode maxDistanceOfTree:rootNode.leftNode];
    //3、最远距离在根节点右子树上，即计算右子树最远距离
    NSInteger disRight = [MyBinaryTreeNode maxDistanceOfTree:rootNode.rightNode];

    return MAX(MAX(disLeft, disRight), distance);
}

@end
