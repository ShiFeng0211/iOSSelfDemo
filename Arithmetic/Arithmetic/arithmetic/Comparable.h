//
//  Comparable.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/3/1.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//NOTE: Class must check to make sure it is the same class as whatever is passed in
@protocol comparable

- (int)compareTo:(id<comparable, NSObject>)object;
- (BOOL)isEqual:(id<comparable, NSObject>)object;

@end

NS_ASSUME_NONNULL_END
