//
//  DataSaveViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2020/11/13.
//  Copyright © 2020 weibo. All rights reserved.
//

#import "DataSaveViewController.h"
#import "Student.h"
#import "Teacher.h"
#import "FMDB.h"

@interface DataSaveViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;

@property (nonatomic) NSString *tmpPath;
@property (nonatomic) NSString *cachesPath;
@property (nonatomic) NSArray *arrTest;
@property (nonatomic) NSDictionary *dicTest;
@property (nonatomic) Student *stu;
@property (nonatomic) Teacher *teacher;
@end

@implementation DataSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"数据持久化";
    
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.arrdata = @[@"plist",@"userdefault",@"fmdb",@"filemanager",@"keychain",@"keyAchive",@"Cookie"];
    
    _tmpPath =  NSTemporaryDirectory();
    _cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    _arrTest = @[@"蓝色",@"绿色",@"红色"];
    _dicTest = @{@"姓名":@"张三",@"性别":@"男"};
    
    _stu = [[Student alloc] init];
    _stu.name = @"张子枫";
    _stu.sex = YES;
    
    _teacher = [[Teacher alloc] init];
    _teacher.name = @"赖还盐";
    _teacher.sex = NO;

    UIView *swipeGestureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGes:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
    
//    [self.view addSubview:swipeGestureView];
//    [self.view bringSubviewToFront:swipeGestureView];

//    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [self.view addGestureRecognizer:tapG];
}

-(void)swipeGes:(UISwipeGestureRecognizer *)ges {
    NSLog(@"swipeGes");
}

-(void)tap:(UITapGestureRecognizer *)tapGes {
    NSLog(@"tapGes");
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
            [self testPlistFile];
        }
        break;
        case 1:
        {
            [self testUserDefault];
        }
            break;
        case 2:
        {
            [self testFMDB];
            
        }
            break;;
        case 3:
        {
            [self testFileManager];
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            [self testKeyAri];
        }
        break;
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

#pragma mark
-(void)testPlistFile {
    NSString *arrPath = [_tmpPath stringByAppendingFormat:@"arrTest.plist"];
    [_arrTest writeToFile:arrPath atomically:YES];
    
    NSArray *newArr = [NSArray arrayWithContentsOfFile:arrPath];
    NSLog(@"new array = %@",newArr);
}

-(void)testUserDefault {
    NSData *stu_data = [NSKeyedArchiver archivedDataWithRootObject:_stu];
    [[NSUserDefaults standardUserDefaults] setValue:stu_data forKey:@"student"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    sleep(1);
    
    NSData *stu_newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"student"];
    Student *stu_new = [NSKeyedUnarchiver unarchiveObjectWithData:stu_newData];
    NSLog(@"newStu %@",stu_new);
    
}

-(void)testFileManager {
    NSString *filePath = [_tmpPath stringByAppendingFormat:@"content"];
    [_dicTest writeToFile:filePath atomically:YES];
    
    NSDictionary *newDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"new dic %@",newDic);
    
    
}

-(void) testFMDB {
    NSString *fmdbPath = [_tmpPath stringByAppendingFormat:@"student.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:fmdbPath];
    if ([db open]) {
        // do something
    } else {
        NSLog(@"fail to open database");
    }
    // 创建
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
//    [db close];//注意每次操作完数据库后要关闭一下
    
    // 插入
    
    for (int i = 0; i < 4; i++) {

        //插入数据
        NSString *name = [NSString stringWithFormat:@"测试名字%d",i];
        int age = 10+i;
        NSString *sex = @"男";
        //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
//        BOOL result = [db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
        //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
            BOOL result = [db executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
        //3.参数是数组的使用方式
        //    BOOL result = [db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
        if (result) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }
    
    //查寻
    FMResultSet *resulte = [db executeQuery:@"SELECT * FROM t_student"];
    while ([resulte next]) {
        int totalCount = [resulte intForColumnIndex:2];
        int age = [resulte intForColumnIndex:0];
        NSString *n = [resulte objectForColumnIndex:1];
        int idNum = [resulte intForColumn:@"id"];
        NSString *name = [resulte objectForColumn:@"name"];
        NSLog(@"姓名：%@",name);
    }
    
    [self handleTransaction];
}



-(void)testKeyChian {
    
}

-(void)testKeyAri {
    NSString *keyArchiver_path = [_tmpPath stringByAppendingFormat:@"keyArchiver_arr"];
    BOOL success = [NSKeyedArchiver archiveRootObject:_arrTest toFile:keyArchiver_path];
    
    if (success) {
            NSLog(@"归档成功");
        } else {
            NSLog(@"归档失败");
    }
    
    NSArray *newArr = [NSKeyedUnarchiver unarchiveObjectWithFile:keyArchiver_path];
    NSLog(@"newArr %@",newArr);

    
    
    NSInteger age = 27;
    NSString *name = @"shixueqian";
    NSArray *array = @[@"one",@"two"];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:name forKey:@"name"];
    [archiver encodeInteger:age forKey:@"age"];
    [archiver encodeObject:array forKey:@"numbers"];
    
    //完成归档
    [archiver finishEncoding];
    NSString *keyArchiver_mutableData = [_tmpPath stringByAppendingFormat:@"keyArchiver_data"];
        //将归档好的数据写到文件里面
    [data writeToFile:keyArchiver_mutableData atomically:YES];
    
    NSMutableData *d = [NSMutableData dataWithContentsOfFile:keyArchiver_mutableData];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:d];
    NSString *name1 = [unarchiver decodeObjectForKey:@"name"];
    NSInteger age1 = [unarchiver decodeIntegerForKey:@"age"];
    NSArray *numbers1 = [unarchiver decodeObjectForKey:@"numbers"];
    [unarchiver finishDecoding];
        
    NSString *path_stu = [_tmpPath stringByAppendingPathComponent:@"student"];
    BOOL success1 = [NSKeyedArchiver archiveRootObject:_stu toFile:path_stu];
        if (success1) {
            NSLog(@"归档成功");
        }else {
            NSLog(@"归档失败");
        }
    
    
    Student *newStu = [NSKeyedUnarchiver unarchiveObjectWithFile:path_stu];
    NSLog(@"newStu=%@",newStu);
}

// 工厂类中存储cookie的方法
+ (void)saveCookies {
    // 创建一个可变字典存放cookie
    NSMutableDictionary *fromappDict = [NSMutableDictionary dictionary];
    [fromappDict setObject:@"fromapp" forKey:NSHTTPCookieName];
    [fromappDict setObject:@"ios" forKey:NSHTTPCookieValue];
    // kDomain是公司app网址
    [fromappDict setObject:@"baidu" forKey:NSHTTPCookieDomain];
    [fromappDict setObject:@"carlife" forKey:NSHTTPCookieOriginURL];
    [fromappDict setObject:@"/" forKey:NSHTTPCookiePath];
    [fromappDict setObject:@"0" forKey:NSHTTPCookieVersion];

    // 将可变字典转化为cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:fromappDict];

    // 获取cookieStorage
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
 
    // 存储cookie
    [cookieStorage setCookie:cookie];
}

- (void) handleTransaction {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test1.db"];
    FMDatabase *db = [[FMDatabase alloc]initWithPath:dbPath];
    [db open];
    if (![db isOpen]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text1 (name text,age,integer,ID integer)"];
    if (result) {
        NSLog(@"create table success");
    }
    //1.开启事务
    [db beginTransaction];
    NSDate *begin = [NSDate date];
    BOOL rollBack = NO;
    @try {
       //2.在事务中执行任务
        for (int i = 0; i< 500; i++) {
            NSString *name = [NSString stringWithFormat:@"text_%d",i];
            NSInteger age = i;
            NSInteger ID = i *1000;
            
            BOOL result = [db executeUpdate:@"insert into text1(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
            if (result) {
                NSLog(@"在事务中insert success");
            }
        }
    }
    @catch(NSException *exception) {
        //3.在事务中执行任务失败，退回开启事务之前的状态
        rollBack = YES;
        [db rollback];
    }
    @finally {
        //4. 在事务中执行任务成功之后
        rollBack = NO;
        [db commit];
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"在事务中执行插入任务 所需要的时间 = %f",time);
    
}


@end
