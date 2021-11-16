//
//  Teacher.h
//  Arithmetic
//
//  Created by v_shifeng on 2020/11/14.
//  Copyright © 2020 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Teacher : NSObject<NSCoding>
@property (nonatomic) NSString *name;
@property (nonatomic,assign) BOOL sex;
@end

NS_ASSUME_NONNULL_END
