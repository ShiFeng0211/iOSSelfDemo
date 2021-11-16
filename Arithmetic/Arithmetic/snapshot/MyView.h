//
//  MyView.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/1/24.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView

- (void)cutScreenWithView:(nullable UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;


- (UIImage *)wipeImageWithView:(UIView *)view currentPoint:(CGPoint)point size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
