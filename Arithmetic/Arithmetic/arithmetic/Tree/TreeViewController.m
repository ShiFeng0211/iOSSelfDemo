//
//  TreeViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/11.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "TreeViewController.h"
#import "MyBinaryTreeNode.h"

@interface TreeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;

@end

@implementation TreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.arrdata = @[@"创建二叉树",@"反转二叉树"];
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
            NSArray *arr1 = @[@2,@7,@1,@9,@8,@1,@3,@4,@0];
            MyBinaryTreeNode *treeNode = [MyBinaryTreeNode createTreeWithValues:arr1];
            [MyBinaryTreeNode preOrderTraverseTree:treeNode handler:^(MyBinaryTreeNode *treeNode) {
                NSLog(@"%ld",(long)treeNode.value);
            }];
            
            // 非递归前序
            NSLog(@"非递归前序");
            MyBinaryTreeNode *treeNode1 = [MyBinaryTreeNode createTreeWithValues:arr1];
            [MyBinaryTreeNode preOrderTraverseTreeNot:treeNode1 handler:^(MyBinaryTreeNode *treeNode) {
                NSLog(@"%ld",(long)treeNode.value);
            }];
            
        }
        break;
        case 1:
        {
            NSArray *arr = [[self getRandomArr] copy];
            MyBinaryTreeNode *treeNode = [MyBinaryTreeNode createTreeWithValues:arr];
            [MyBinaryTreeNode preOrderTraverseTree:treeNode handler:^(MyBinaryTreeNode *treeNode) {
                NSLog(@"%ld",(long)treeNode.value);
            }];
            MyBinaryTreeNode *treeNodeInvert = [MyBinaryTreeNode invertBinaryTree:treeNode];
            // 反转后
            NSLog(@"反转后的");
            [MyBinaryTreeNode preOrderTraverseTree:treeNodeInvert handler:^(MyBinaryTreeNode *treeNode) {
                NSLog(@"%ld",(long)treeNode.value);
            }];
            
        }
        case 2:
        {
            NSArray *arr1 = [[self getRandomArr] copy];
        }
        break;
        case 4: {
            
        }
        break;
        case 5: {
            
        }
        break;
        case 6: {
            
        }
        default:
        break;
    }
}

-(NSMutableArray *)getRandomArr {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i=0; i<20; i++) {
        int num = arc4random()%8;
        NSNumber *n = [NSNumber numberWithInt:num];
        [arr addObject:n];
        
    }
    NSSet *set = [NSSet setWithArray:arr];
    arr = [[set allObjects] copy];
    return arr;
}

-(MyBinaryTreeNode *)creatTreeNodes {
    [self getRandomArr];
    
    return nil;
}


- (MyBinaryTreeNode *)createTreeWithValues {
    MyBinaryTreeNode *root = nil;
    NSArray *values = [[self getRandomArr] copy];
    
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        
    }
    return root;
}

-(void)mirrorTree:(MyBinaryTreeNode *)treeNode {
    
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
