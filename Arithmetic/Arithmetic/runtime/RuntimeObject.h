//
//  RuntimeObject.h
//  Arithmetic
//
//  Created by v_shifeng on 2020/12/22.
//  Copyright © 2020 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeObject : NSObject

@property (nonatomic) NSString *name;

-(void)test;

+(void)otherTest;
@end

NS_ASSUME_NONNULL_END
