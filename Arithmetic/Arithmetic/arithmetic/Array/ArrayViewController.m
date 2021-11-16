//
//  ArrayViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/25.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "ArrayViewController.h"
#import "ListNode.h"
#import <CoreFoundation/CoreFoundation.h>


@interface ArrayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;
@end

@implementation ArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.arrdata = @[@"数组中是否有重复的字符",@"数组排序",@"替换字符",@"判断回文字符串"];
    
    [self testGoTo];
}

-(void)duplicateArray {
    NSArray *originalArr = @[@1, @2, @3, @1, @3];
    
    NSArray *result = [originalArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"result: %@", result);
//    NSSet *set = [NSSet setWithArray:originalArr];
//    NSLog(@"result: %@", [set allObjects]);
}

-(void)testGoTo {
    int i = 0;    // 定义一个循环计数变量
    start:       // start为goto的标签，注意冒号不可少
    NSLog(@"i : %d",i);
    i++;
    if (i < 10) {    // 如果i小于10，再次跳转到start标签处
        goto start;   // 跳转到标签处，即start: 所在的代码行
    }
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
            NSString *str = @"12qwertyu";
            if ([self isUniqueStr:str]) {
                NSLog(@"唯一的");
            } else {
                NSLog(@"不是唯一");
            }
        }
        break;
        case 1:
        {
            NSString *str1 = @"qwertyuiop";
            NSString *str2 = @"poiuytrewo";
            [self permutationStr:str1 withOtherStr:str2];
        }
        case 2:
        {
            [self replaceSpaces:@"hello world hah"];
        }
        break;
        case 3: {
            [self isPalindrome:@"abcd12344321pcba"];
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


#pragma mark PrivateMethod

-(BOOL)isUniqueStr:(NSString *)str {
    // 先判断下 ASCII 字符串还是 Unicode 字符串  ascII 字符串才128个字符，unicode字符串就很高
    
    if (str.length >= 128 ) return YES;
    const char *c = [str UTF8String];
    
    NSHashTable *hashT = [[NSHashTable alloc] init];
    for (int i = 0; i<str.length; i++) {
        if ([hashT containsObject:[NSNumber numberWithChar:c[i]]]) {
            return NO;
        }
        [hashT addObject:[NSNumber numberWithChar:c[i]]];
    }
    return YES;
}

-(BOOL)permutationStr:(NSString *)str1 withOtherStr:(NSString *)str2 {
    
    if (str1.length != str2.length) return NO;
    
    str1 = [self sortStr:str1];
    str2 = [self sortStr:str2];
    
    if ([str1 isEqualToString:str2]) {
        return YES;
    } else {
        return NO;
    }
}

-(NSString *)replaceSpaces:(NSString *)str {
    
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    return str;
}

-(BOOL)isPalindrome:(NSString *)str {
    
    NSMutableArray *charArr = [NSMutableArray arrayWithCapacity:str.length];
    NSMutableArray *palindromeStrArr = [[NSMutableArray alloc] init];
    NSString *palindromeStr = @"";
    NSInteger max = 0;
    
    for (int i=0; i<str.length; i++) {
        NSString *charStr = [str substringWithRange:NSMakeRange(i, 1)];
        [charArr addObject:charStr];
    }
    int totalLength = (int)charArr.count;
    for (int i=0; i<(charArr.count/2); i++) {
        if ([charArr[i] isEqualToString:charArr[totalLength-i-1]]) {
            
            palindromeStr = [palindromeStr stringByAppendingString:charArr[i]];
            
        } else {
            if (palindromeStr.length > max) {
                [palindromeStrArr addObject:palindromeStr];
                max = palindromeStr.length;
                palindromeStr = @"";
            }
        }
    }
    if (palindromeStrArr.count != 0) palindromeStr = palindromeStrArr[0];
    return YES;
    
    // 解法二
    
//    NSString *resultStr = @"";
//    for (int i=str.length-1; i>=0; i--) {
//        NSString *indexStr = [str substringWithRange:NSMakeRange(i, 1)];
//        resultStr = [resultStr stringByAppendingString:indexStr];
//    }
//
//    if ([resultStr isEqualToString:str]) {
//        NSLog(@"是回文");
//        return YES;
//    } else {
//        NSLog(@"不是回文");
//        return NO;
//    }
}

-(NSString *)sortStr:(NSString *)str {
    NSMutableArray *charArray1 = [NSMutableArray arrayWithCapacity:str.length];
    for (int i=0; i<str.length; ++i) {
        NSString *charStr = [str substringWithRange:NSMakeRange(i, 1)];
        [charArray1 addObject:charStr];
    }
    NSString *sortedStr = [[charArray1 sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] componentsJoinedByString:@""];
    return sortedStr;
    
    //排序
//    NSArray *originalArray = @[@"1",@"21",@"12",@"11",@"0"];
//    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
//    NSComparator finderSort = ^(id string1,id string2) {
//        if ([string1 integerValue] > [string2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }else if ([string1 integerValue] < [string2 integerValue]){
//            return (NSComparisonResult)NSOrderedAscending;
//        } else
//            return (NSComparisonResult)NSOrderedSame;
//    };
//
//    //数组排序：
//    NSArray *resultArray = [originalArray sortedArrayUsingComparator:finderSort];
//    NSLog(@"第一种排序结果：%@",resultArray);
//
//    NSArray *charArray = @[@"string 1",@"String 21",@"string 12",@"String 11",@"String 02"];
//    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
//    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
//    NSComparator sort = ^(NSString *obj1,NSString *obj2){
//        NSRange range = NSMakeRange(0,obj1.length);
//        return [obj1 compare:obj2 options:comparisonOptions range:range];
//    };
//    NSArray *resultArray2 = [charArray sortedArrayUsingComparator:sort];
//    NSLog(@"字符串数组排序结果%@",resultArray2);
//    if (str1.length != str2.length) return false;
//    NSMutableArray *letterArray = [NSMutableArray array];
//    NSString *letters = @"ABCDEF";
//    [letters enumerateSubstringsInRange:NSMakeRange(0, [letters length])
//                                options:(NSStringEnumerationByComposedCharacterSequences)
//                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//        [letterArray addObject:substring];
//    }];
//    for (NSString *i in letterArray){
//        NSLog(@"%@",i);
//    }
//
//    NSString *str = @"stack";
//    NSMutableArray *charArray1 = [NSMutableArray arrayWithCapacity:str.length];
//    for (int i=0; i<str.length; ++i) {
//        NSString *charStr = [str substringWithRange:NSMakeRange(i, 1)];
//        [charArray1 addObject:charStr];
//    }
//    NSString *sortedStr = [[charArray1 sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] componentsJoinedByString:@""];
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
