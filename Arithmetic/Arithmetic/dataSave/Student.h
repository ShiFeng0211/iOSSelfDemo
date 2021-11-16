//
//  Student.h
//  Arithmetic
//
//  Created by v_shifeng on 2020/11/14.
//  Copyright © 2020 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject<NSCoding>

@property (nonatomic) NSString *name;
@property (nonatomic,assign) BOOL sex;
@property (nonatomic,assign) int id;
@property (nonatomic,assign) int age;
@property (nonatomic,assign) Teacher *teacher;
@end

NS_ASSUME_NONNULL_END
