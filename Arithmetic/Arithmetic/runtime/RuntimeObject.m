//
//  RuntimeObject.m
//  Arithmetic
//
//  Created by v_shifeng on 2020/12/22.
//  Copyright © 2020 weibo. All rights reserved.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>

void testImp (void){
    NSLog(@"test invoke");
}

@implementation RuntimeObject

//+(void)load {
//    Method t1 = class_getInstanceMethod(self, @selector(test));
//    Method t2 = class_getInstanceMethod(self, @selector(otherTest));
//    method_exchangeImplementations(t1, t2);
//
//}

+(void)otherTest {
    NSLog(@"otherTest");
}

#pragma mark 消息转发


+(BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(test)) {
        NSLog(@"resolveClassMethod");
        class_addMethod(self, @selector(test), testImp, "v@:");
        return YES;
    } else {
        return [super resolveClassMethod:sel];
    }
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod");
        class_addMethod(self, @selector(test), testImp, "v@:");
        return YES;
    } else {
        return [super resolveInstanceMethod:sel];
    }
}

-(id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    return nil;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    } else {
        return [super methodSignatureForSelector:aSelector];
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
}






@end
