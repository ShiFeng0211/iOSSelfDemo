//
//  BinaryTreeNode.h
//  Arithmetic
//
//  Created by v_shifeng on 2020/11/12.
//  Copyright © 2020 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyBinaryTreeNode : NSObject
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) MyBinaryTreeNode *leftNode;
@property (nonatomic, strong) MyBinaryTreeNode *rightNode;

//创建二叉树
+ (MyBinaryTreeNode *)createTreeWithValues:(NSArray *)values;

//二叉树中某个位置的节点（按层次遍历）
+ (MyBinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(MyBinaryTreeNode *)rootNode;

//向二叉排序树节点添加一个节点
+ (MyBinaryTreeNode *)addTreeNode:(MyBinaryTreeNode *)treeNode value:(NSInteger)value;

//翻转二叉树
+ (MyBinaryTreeNode *)invertBinaryTree:(MyBinaryTreeNode *)rootNode;

// 非递归方式翻转
+ (MyBinaryTreeNode *)invertBinaryTreeNot:(MyBinaryTreeNode *)rootNode;

//先序遍历：先访问根，再遍历左子树，再遍历右子树。典型的递归思想。
+ (void)preOrderTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler;

+ (void)preOrderTraverseTreeNot:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler;

//中序遍历:先遍历左子树，再访问根，再遍历右子树
+ (void)inOrderTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler;

//后序遍历:先遍历左子树，再遍历右子树，再访问根
+ (void)postOrderTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler;

//层次遍历（广度优先)
+ (void)levelTraverseTree:(MyBinaryTreeNode *)rootNode handler:(void(^)(MyBinaryTreeNode *treeNode))handler;

//二叉树的宽度
+ (NSInteger)widthOfTree:(MyBinaryTreeNode *)rootNode;

//二叉树的所有节点数
+ (NSInteger)numberOfNodesInTree:(MyBinaryTreeNode *)rootNode;

//二叉树某层中的节点数
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(MyBinaryTreeNode *)rootNode;

//二叉树叶子节点数
+ (NSInteger)numberOfLeafsInTree:(MyBinaryTreeNode *)rootNode;

//二叉树最大距离（直径）
+ (NSInteger)maxDistanceOfTree:(MyBinaryTreeNode *)rootNode;


+(void)saveRootNodeValue:(MyBinaryTreeNode *)rootNode;

@end
