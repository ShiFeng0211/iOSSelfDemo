//
//  RuntimeViewController.m
//  Arithmetic
//
//  Created by feng shi on 2021/11/15.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "RuntimeViewController.h"
#import "Person.h"

@interface RuntimeViewController ()

@property (nonatomic) NSTimer *tt;

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
//    [self testAllocAndInit];
    _tt = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    
}

-(void)timeAction {
    NSLog(@"定时器");
}

-(void)testAllocAndInit {
    Person *person1 = [Person alloc];
    Person *person2 = [person1 init];
    Person *person3 = [person1 init];
    
    NSLog(@"%@--%p--%p",person1,person1,&person1);
    NSLog(@"%@--%p--%p",person2,person2,&person2);
    NSLog(@"%@--%p--%p",person3,person3,&person3);
}


@end
