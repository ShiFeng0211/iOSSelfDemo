//
//  SortViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/2.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "SortViewController.h"
#import <Masonry/Masonry.h>
static int countNum = 0;
@interface SortViewController ()
@property (nonatomic) NSMutableArray *arrNum;
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[@"气泡",@"插入",@"快排",@"奇偶排序",@"有多少个1在整数里"];
//  self.arrNum = @[@1,@2,@10,@6,@4,@9,@8,@7];
    self.arrNum = [self getRandomArr];
    
    
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.tag = i;
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(100);
            make.left.equalTo(self.view).offset(15+i*50);
            make.size.mas_equalTo(CGSizeMake(40, 30));
        }];
    }
}

-(void)clickBtn:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            [self popSort:self.arrNum];
            break;
        case 1:
            [self insertSort:self.arrNum];
            break;
        case 2:
            NSLog(@"快排之前%@",self.arrNum);
            [self sf_quickSort:self.arrNum beginIndex:0 endIndex:(int)(self.arrNum.count-1)];
            NSLog(@"快排之后%@",self.arrNum);
            NSLog(@"count = %d",countNum);
            break;
        case 3:
            NSLog(@"奇偶之前%@",self.arrNum);
            [self reorderOddEven];
            NSLog(@"奇偶之后%@",self.arrNum);
            NSLog(@"count = %d",countNum);
            break;
        case 4:
            {
                int num1 = [self numberOf1Between1AndN:13];
                NSLog(@"num is %d",num1);
            }
        default:
            break;
    }
}

-(NSMutableArray *)getRandomArr {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        int num = random()%100;
        NSNumber *n = [NSNumber numberWithInt:num];
        [arr addObject:n];
    }
    return arr;
}

int * getCArry(int num) {
   static NSInteger myArray[28];
    for (NSInteger i = 0; i<28; i++) {
        myArray[i] = i;
    }
    NSLog (@"The 4th integer is: %ld", myArray[3]);
    return myArray;
    
}

#pragma mark


-(int)numberOf1Between1AndN:(int)n {
    int *p;
    int number = 0;
    for (int i=0; i<n; i++) {
        number = number + [self numberof1:i];
    }
//    p = getCArry(13);
    
    return number;
}

-(int)numberof1:(int)n {
    int number = 0;
    while (n) {
        if (n%10 == 1) number = number+1;
        n = n/10;
    }
    return number;
}

// 冒泡
-(void)popSort:(NSArray *)arr {
    if (arr.count<1) return;
    NSMutableArray *arrNum = [NSMutableArray arrayWithArray:arr];
    
    for (int i=0; i<arrNum.count; i++) {
        BOOL flag = false;
        for (int j=0; j<arrNum.count-1-i; j++) {
            if ([arrNum[j] compare:arrNum[j+1]] == NSOrderedDescending) {
                NSNumber *temp = arrNum[j];
                arrNum[j] = arrNum[j+1];
                arrNum[j+1] = temp;
                flag = true;
            }
        }
        if (!flag) continue;
    }
    NSLog(@"排序后的 %@",arrNum);
}

// 插入

/*
 两个指针i,j.
 */
-(void)insertSort:(NSArray *)arr {
    if (arr.count<1) return;
    NSLog(@"排序前的 %@",arr);
    NSMutableArray *arrNum = [NSMutableArray arrayWithArray:arr];
    
    for (int i=1; i<arrNum.count; i++) {
        for (int j=0; j<i; j++) {
            if ([arrNum[i] compare:arrNum[j]] == NSOrderedAscending) {
                NSNumber *num = arrNum[i];
                [arrNum removeObjectAtIndex:i];
                [arrNum insertObject:num atIndex:j];
            }
        }
    }
    NSLog(@"排序后的 %@",arrNum);
    
}

// 奇数放在数组最前面
// i 指针始终在第一个奇数位置上
/*
 奇数排在偶数前面
 思路：整个数组分两个区，前面的为偶数区，后面的为奇数区，定义一个i指针始终指向第一个偶数区的元素，用j下标遍历数组，j下标发现有奇数则将前面i下标指向的第一个偶数元素进行替换，
 
 伪代码：
 1，定义两个下标 i，j，初始化指向数组第一个元素上
 2，j下标负责遍历整个数组，遇到奇数后，则与前面i下标的元素交换
 3，i下标一直指向第一个偶数元素上
 
*/


// 排列奇偶
-(void)reorderOddEven {
    int i = 0;
    for (int j=0; j<_arrNum.count; j++) {
        if ([_arrNum[j] intValue]%2 != 0) {
            // 偶数
            [_arrNum exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            
        }
    }
}

-(void)sf_quickSort:(NSMutableArray *)arr beginIndex:(int)p endIndex:(int)q {
    if (p>q) return;
    int rr = [self sf_partintion:arr beginIndex:p endIndex:q];
    [self sf_quickSort:arr beginIndex:p endIndex:rr-1];
    [self sf_quickSort:arr beginIndex:rr+1 endIndex:q];
}

-(int)sf_partintion:(NSMutableArray *)arr beginIndex:(int)p endIndex:(int)q {
    if (p > q) return p;
    int pirot = [arr[q] intValue];
    int i = p;
    for (int j=p; j<q-1; j++) {
        if ([arr[j] intValue] < pirot) {
            [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
        }
    }
    [arr exchangeObjectAtIndex:i withObjectAtIndex:q];
    return i;
}

//快排
-(void)quickSort:(NSMutableArray *)arr beginIndex:(int)p endIndex:(int)q {
    countNum++;
    if (p>=q) return;
    int r = [self partition:arr beginIndex:p endIndex:q];
    [self quickSort:arr beginIndex:p endIndex:r-1];
    [self quickSort:arr beginIndex:r+1 endIndex:q];
}

// 思路就是定义两个指针，i,j， 和一个pirot的值，
// pirot 默认取最后一个值
// j 指针负责遍历，从数组第一个位置，遍历到pirot前一个位置
// i 指针一直指向，大于pirot 分区的第一个值
// 当 j 在遍历整个数组的过程中，遇到arr[j],比pirot 小的，则把 arr[i] 和 arr[j] 调换位置，并且让i++，这样i前面的值都是比pirot 小，i后面的比pirot大
// j循环结束后,arr[i]和arr[q] 交换值，然后返回i的下标
-(int)partition:(NSMutableArray *)arr beginIndex:(int)p endIndex:(int)q {
    int pirot = [arr[q] intValue];
    int i = p;
    for (int j=p; j<=q-1; j++) {
        if ([arr[j] intValue] < pirot) {
            [arr exchangeObjectAtIndex:j withObjectAtIndex:i];
            i++;
        }
    }
    [arr exchangeObjectAtIndex:i withObjectAtIndex:q];
    return i;
}

-(int)backbag {
    int maxWeight = 100;
    int m,n;
    NSArray <NSNumber *>*weights = [[self getRandomArr] copy];
    NSArray <NSNumber *>*values = [[self getRandomArr] copy];
    NSArray <NSArray <NSNumber *>*>*array2d = @[@[],@[]];
    NSMutableArray *dp = [NSMutableArray arrayWithArray:array2d];
    
    for (int i=1; i<weights.count; i++) {
        for (int j=1;j<maxWeight;j++) {
            if (i < [weights[j] intValue]) {
                dp[i][j] = dp[i-1][j];
            } else {
                
            }
        }
    }
    return 0;
}
@end



