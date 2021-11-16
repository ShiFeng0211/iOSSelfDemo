//
//  ArithmeticViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/2/26.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "ArithmeticViewController.h"
#import "SortViewController.h"
#import "LinkViewController.h"
#import "ArrayViewController.h"
#import "TreeViewController.h"
#import "StackViewController.h"

@interface ArithmeticViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;

@end

@implementation ArithmeticViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    
    self.arrdata = @[@"数组",@"链表",@"排序",@"树",@"栈&队列"];
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
            ArrayViewController *arrayVc = [[ArrayViewController alloc] init];
            [self.navigationController pushViewController:arrayVc animated:NO];
            
        }
        break;
        case 1:
        {
            LinkViewController *linkVc = [[LinkViewController alloc] init];
            [self.navigationController pushViewController:linkVc animated:NO];
        }
            break;
        case 2:
        {
            SortViewController *sort = [[SortViewController alloc] init];
            [self.navigationController pushViewController:sort animated:NO];
        }
        break;
        case 3: {
            TreeViewController *treeVC = [[TreeViewController alloc] init];
            [self.navigationController pushViewController:treeVC animated:NO];
        }
        break;
        case 4: {

            StackViewController *stackVC = [[StackViewController alloc] init];
            [self.navigationController pushViewController:stackVC animated:NO];
        }
        break;
        case 6: {

            
        }
        default:
        break;
    }
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
