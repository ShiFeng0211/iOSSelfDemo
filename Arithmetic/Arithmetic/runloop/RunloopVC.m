//
//  RunloopVC.m
//  Arithmetic
//
//  Created by v_shifeng on 2020/12/9.
//  Copyright © 2020 weibo. All rights reserved.
//

#import "RunloopVC.h"
#import "SFThread.h"
#import "Masonry.h"

@interface RunloopVC ()
@property (nonatomic) SFThread *subThread;
@property (nonatomic) SFThread *timerThread;
@property (nonatomic) BOOL isStopped;
@end

@implementation RunloopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"runloop";
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
//    imageV.size = CGSizeMake(315, 289);
    [imageV setImage:[UIImage imageNamed:@"logo.png"]];

    [self.view addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(315, 289));
    }];
    

//    SFThread *newThread = [[SFThread alloc] initWithTarget:self selector:@selector(logText) object:nil];
//    [newThread start];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchbegan");
    [self performSelector:@selector(logText) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

-(void)logText {
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
}

-(void)setupSubThread {
    NSLog(@"setupSubThread");
    NSLog(@"%@",[NSThread currentThread]);
    NSRunLoop *currentLoop = [NSRunLoop currentRunLoop];
    [currentLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [currentLoop run];
}
@end

