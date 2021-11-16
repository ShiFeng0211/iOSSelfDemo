//
//  ViewController.m
//  Arithmetic
//
//  Created by yangyang38 on 2018/2/8.
//  Copyright © 2018年 weibo. All rights reserved.

#import "ViewController.h"
#import "MedianFind.h"
#import "MyBinaryTreeNode.h"
#import "DataSaveViewController.h"
#import "JSViewController.h"
#import "RunloopVC.h"
#import "SFThread.h"
#import "RuntimeObject.h"
#import "SnapshotViewController.h"
#import "ArithmeticViewController.h"
#import "RuntimeViewController.h"

#pragma mark - Enum Factory Macros


#define ENUM_VALUE(name,assign) name assign,


#define ENUM_CASE(name,assign) case name: return @#name;


#define ENUM_STRCMP(name,assign) if ([string isEqualToString:@#name]) return name;


#define DECLARE_ENUM(EnumType,ENUM_DEF) \
typedef enum EnumType { \
ENUM_DEF(ENUM_VALUE) \
}EnumType; \
NSString *NSStringFrom##EnumType(EnumType value); \
EnumType EnumType##FromNSString(NSString *string); \


#define DEFINE_ENUM(EnumType, ENUM_DEF) \
NSString *NSStringFrom##EnumType(EnumType value) \
{ \
switch(value) \
{ \
ENUM_DEF(ENUM_CASE) \
default: return @""; \
} \
} \
EnumType EnumType##FromNSString(NSString *string) \
{ \
ENUM_DEF(ENUM_STRCMP) \
return (EnumType)0; \
}

#define TEST_STATUS(XX)  \
 XX(kTestStatusOK, = 0) \
 XX(kTestStatusCached, )\
 XX(kTestStatusRetry, )

DECLARE_ENUM(TestStatus, TEST_STATUS)

DEFINE_ENUM(TestStatus, TEST_STATUS)


#define _LOCK(semaphore) dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
#define _UNLOCK(semaphore) dispatch_semaphore_signal(semaphore);


@interface ViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) dispatch_semaphore_t customLock;
@property (nonatomic) dispatch_queue_t customCurrentQueue;
@property (nonatomic) dispatch_queue_t customQueue;

@property (nonatomic) UITableView *tbView;
@property (nonatomic) NSArray *arrdata;
@property (nonatomic) SFThread *sfT;
@property (nonatomic) dispatch_source_t timer;
@property (nonatomic) dispatch_semaphore_t requestSongDataSemaphore;
@property (nonatomic,assign) BOOL testB;
@property (nonatomic,assign) int  testI;
@property (nonatomic,assign) NSInteger test3;
@property (nonatomic) RuntimeViewController *runtimerVC;

@end

static int i;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tbView];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.arrdata = @[@"算法",@"testDate",@"NSValue",@"数据持久化",@"js",@"runloop",@"snapShot",@"crash",@"runtime"];
    
    RuntimeObject *runObj = [[RuntimeObject alloc] init];
    runObj.name = @"jack";
    
    RuntimeObject *runObj2 = [[RuntimeObject alloc] init];
    runObj.name = @"tome";
    
    static int ii = 10;
    
    void (^block)(void) = ^{
        ii = 11;
        NSLog(@"ii = %d",ii);
    };
    block();
    NSLog(@"ii = %d",ii);
    
    
    _requestSongDataSemaphore = dispatch_semaphore_create(1);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify) name:@"shifeng" object:nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前线程 %@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shifeng" object:nil];
    });
}

-(void)notify {
    NSLog(@"通知来了");
    NSLog(@"通知里的线%@",[NSThread currentThread]);
}

- (UIImage *)downsampleImageAt:(NSURL *)imageURL
                            to:(CGSize)pointSize
                        scaled:(CGFloat)scale {
// 利用图像地址创建image source
    NSDictionary *imageSourceOptions = @{
    (__bridge NSString *)kCGImageSourceShouldCache: @NO // 􏷌􏸒􏹗􏳐􏰐􏰡􏶢 􏵯
    };
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL,
                                                              (__bridge CFDictionaryRef)imageSourceOptions);
    
    
    // 下采样
    CGFloat maxDimensionInPixels = MAX(pointSize.width, pointSize.height) * scale;
    NSDictionary *downsampleOptions =@{
        (__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
        (__bridge NSString *)kCGImageSourceShouldCacheImmediately: @YES, // 􏹘􏲳􏹗􏳐􏰉􏰑􏰗􏲦􏶊􏶢􏵯缩小图像的同时进行解码
        (__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform: @YES,
        (__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize: @(maxDimensionInPixels)};
    
    CGImageRef downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (__bridge CFDictionaryRef)downsampleOptions);
    UIImage *image = [[UIImage alloc] initWithCGImage:downsampledImage];
        
    CGImageRelease(downsampledImage);
    CFRelease(imageSource);
    return image;
}

- (void)start
{
    for (int i = 0; i<10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_semaphore_wait(_requestSongDataSemaphore, DISPATCH_TIME_FOREVER);
            
            
            NSLog(@"i = %d",i);
        });
        
        if (i/100 == 0) {
            dispatch_semaphore_signal(_requestSongDataSemaphore);
        }
    }
//    dispatch_semaphore_wait(_requestSongDataSemaphore, DISPATCH_TIME_FOREVER);
//
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//
//    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 3.0* NSEC_PER_SEC), DISPATCH_TIME_FOREVER
//                              , 0.1 * NSEC_PER_SEC);
//
//    dispatch_source_set_event_handler(_timer, ^{
//        NSLog(@"shifeng timer");
//    });
//
//    dispatch_source_set_cancel_handler(_timer, ^{
//        NSLog(@"timersource cancel handle block");
//    });
//
//    dispatch_resume(_timer);
}


-(void)setupSubThread {
    
    NSTimer *tt = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:tt forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
    
}

-(void)timerCount {
    i = i +1;
    NSLog(@"timer = %d",i);
}

-(void)testMemory {

    struct Person1 {
        char a;
        long b;
        int c;
        short d;
    }MyPerson1;

    struct Person2 {
        long b;
        char a;
        int c;
        short d;
    }MyPerson2;

    struct Person3 {
        long b;
        int c;
        char a;
        short d;
    }MyPerson3;

    MyPerson1.a = 'a';
    MyPerson1.b = 8;
    MyPerson1.c = 4;
    MyPerson1.d = 2;
    
    MyPerson2.b = 18;
    MyPerson2.a = 'a';
    MyPerson2.c = 14;
    MyPerson2.d = 12;
    
    MyPerson3.b = 28;
    MyPerson3.c = 24;
    MyPerson3.a = 'a';
    MyPerson3.d = 22;
//    
//    NSLog(@"Adress====
//          ===MyPerson1:%p,MyPerson2:%p,MyPerson3:%p",&MyPerson1,&MyPerson2,&MyPerson3);
//    NSLog(@"Size=======MyPerson1:%lu,MyPerson2:%lu,MyPerson3:%lu",sizeof(MyPerson1),sizeof(MyPerson2),sizeof(MyPerson3));
    
    //
    UIView *vv = [[UIView alloc] init];
    
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
            ArithmeticViewController *avc = [[ArithmeticViewController alloc] init];
            [self.navigationController pushViewController:avc animated:YES];
        }
        break;
            
        case 1:
        {
            [self testDate];
        }
        case 3:
        {
            DataSaveViewController *dataVC = [[DataSaveViewController alloc] init];
            [self.navigationController pushViewController:dataVC animated:YES];
        }
        break;
        case 4: {
            JSViewController *js = [[JSViewController alloc] init];
            [self.navigationController pushViewController:js animated:YES];
        }
            break;
        case 5: {
            RunloopVC *runloopVC = [[RunloopVC alloc] init];
            [self.navigationController pushViewController:runloopVC animated:YES];
            
        }
            break;
        case 6: {
            SnapshotViewController *snapVC = [[SnapshotViewController alloc] init];
            [self.navigationController pushViewController:snapVC animated:YES];
            
        }
        case 8: {
            // runtime test
            _runtimerVC = [[RuntimeViewController alloc] init];
            [self.navigationController pushViewController:_runtimerVC animated:YES];

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

#pragma mark privateMethod

-(void)testDate {
//    __weak typeof(self) weakSelf = self;
//    __strong typeof(self) strongSelf = self;
//    NSDate *today = [NSDate new];
//    NSTimeInterval time_t1 = [today timeIntervalSinceNow];
//    NSTimeInterval time_t2 =[today timeIntervalSince1970]*1000;
//    NSLog(@"today =%@, time_t1 = %.f, time_t2 = %f",today,time_t1,time_t2);
    static float tt = 0.0;
    tt = tt + 100;
    NSLog(@"tt = %f",tt);
    
}

-(void)treeTest {
    NSArray *arr = [NSArray arrayWithObjects:@(7),@(6),@(3),@(2),@(1),@(9),@(10),@(12),@(14),@(4),@(14), nil];

//    BinaryTreeNode *tree = [BinaryTreeNode createTreeWithValues:arr];
//    BinaryTreeNode *tree1 = [BinaryTreeNode treeNodeAtIndex:3 inTree:tree];
//    NSLog(@"%@",tree1);

    NSMutableArray *orderArray = [NSMutableArray array];
//    [BinaryTreeNode preOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray addObject:@(treeNode.value)];
//    }];
//    [BinaryTreeNode saveRootNodeValue:tree];
    
    NSLog(@"先序遍历结果：%@", [orderArray componentsJoinedByString:@","]);
    
//    NSMutableArray *orderArray1 = [NSMutableArray array];
//    [BinaryTreeNode inOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//
//        [orderArray1 addObject:@(treeNode.value)];
//
//    }];
//    NSLog(@"中序遍历结果：%@", [orderArray1 componentsJoinedByString:@","]);
//
//    @synchronized (self.class) {
//
//    }
//    NSMutableArray *orderArray2 = [NSMutableArray array];
//    [BinaryTreeNode postOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray2 addObject:@(treeNode.value)];
//
//    }];
//    NSLog(@"后序遍历结果：%@", [orderArray2 componentsJoinedByString:@","]);
//
//
//    NSMutableArray *orderArray3 = [NSMutableArray array];
//    [BinaryTreeNode levelTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray3 addObject:@(treeNode.value)];
//
//    }];
//    NSLog(@"层次遍历结果：%@", [orderArray3 componentsJoinedByString:@","]);
    

//    NSArray *arr = [NSArray arrayWithObjects:@(7),@(6),@(3),@(2),@(1),@(9),@(10),@(12),@(14),@(4),@(14), nil];
//    BinaryTreeNode *tree = [BinaryTreeNode new];
//    tree = [BinaryTreeNode createTreeWithValues:arr];
//
//    BinaryTreeNode *tree1 = [BinaryTreeNode treeNodeAtIndex:3 inTree:tree];
//    NSLog(@"%@",tree1);
//
//    NSMutableArray *orderArray = [NSMutableArray array];
//    [BinaryTreeNode preOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray addObject:@(treeNode.value)];
//    }];
//    NSLog(@"先序遍历结果：%@", [orderArray componentsJoinedByString:@","]);
//
//    NSMutableArray *orderArray1 = [NSMutableArray array];
//   [BinaryTreeNode inOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//
//        [orderArray1 addObject:@(treeNode.value)];
//
//    }];
//    NSLog(@"中序遍历结果：%@", [orderArray1 componentsJoinedByString:@","]);
//
//
//    NSMutableArray *orderArray2 = [NSMutableArray array];
//    [BinaryTreeNode postOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray2 addObject:@(treeNode.value)];
//
//    }];
//    NSLog(@"后序遍历结果：%@", [orderArray2 componentsJoinedByString:@","]);
//
//
//    NSMutableArray *orderArray3 = [NSMutableArray array];
//    [BinaryTreeNode levelTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray3 addObject:@(treeNode.value)];
//
//    }];
//    NSLog(@"层次遍历结果：%@", [orderArray3 componentsJoinedByString:@","]);
}

@end
