//
//  StackViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/5/21.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "StackViewController.h"
#import "StackQueue.h"
#import "KStack.h"

@interface StackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;
@end

@implementation StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    
    self.arrdata = @[@"返回最小栈元素",@"栈实现队列",@"栈排序"];
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
            
        }
        break;
        case 1:
        {
            [self createStackQueue];
        }
        break;
        case 2:
        {
            [self sortStack];
        }
        break;
        case 3: {

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

-(void)sortStack {
    KStack *rStack = [[KStack alloc] initStackWithArray:@[@2,@5,@9,@7,@4,@8,@0,@4,@5,@3]];
    KStack *sStack = [[KStack alloc] init];
    NSNumber *temp;
    
    [rStack printStack];
    
    while ([rStack getStackSize] != 0) {
        temp =  [rStack pop];
        NSNumber *peekObj = [sStack peekObj];
        while (([sStack getStackSize]>0) && ([peekObj intValue] > [temp intValue])) {
            [rStack push:[sStack pop]];
        }
        [sStack push:temp];
        
    }
    NSLog(@"排序后");
    [sStack printStack];
}

-(void)createStackQueue {
    
    StackQueue *sQueue = [[StackQueue alloc] init];
    [sQueue add:@1];
    [sQueue add:@2];
    [sQueue add:@3];
    
    NSLog(@"pull = %@",[sQueue pull]);
    
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
