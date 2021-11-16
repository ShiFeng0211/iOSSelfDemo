//
//  MyView.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/1/24.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "MyView.h"
#import "Masonry.h"
#import <UIKit/UIKit.h>


@implementation MyView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
//        UIImageView *imageV = [[UIImageView alloc] init];
//        imageV.contentMode = UIViewContentModeScaleAspectFit;
//        UIImage *img = [UIImage imageNamed:@"logo.png"];
//        [imageV setImage:img];
//        [self addSubview:imageV];
//        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.centerY.equalTo(self);
//            make.size.mas_equalTo(CGSizeMake(100, 80));
//        }];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 1, 1.0, 1.0, 1.0);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextAddRect(context, CGRectMake(2, 2, 270, 270));
//    CGContextStrokePath(context);
    
    
//    [[UIColor yellowColor] setFill];
//    UIGraphicsPushContext(UIGraphicsGetCurrentContext());
//    [[UIColor redColor] setFill];
//    UIGraphicsPopContext();
//    UIRectFill(CGRectMake(90, 200, 100, 100)); // red colo
    
//    [[UIColor redColor] setFill];
//    CGContextSaveGState(UIGraphicsGetCurrentContext());
//    [[UIColor yellowColor] setFill];
//    CGContextRestoreGState(UIGraphicsGetCurrentContext());
//    UIRectFill(CGRectMake(90, 200, 100, 100)); // red color
    
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    [[UIColor blueColor] setFill];
    [p fill];
}

- (void)cutScreenWithView:(nullable UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block {
    //1、开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.截屏
    [view.layer renderInContext:ctx];
    //4、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.转化成为Data
    //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    //6、关闭上下文
    UIGraphicsEndImageContext();
    //7.回调
    block(newImage, data);
}

-(void)btn1:(UIButton *)btn {
    [btn removeFromSuperview];
}

-(void)btn2:(UIButton *)btn {
    [self addSubview:btn];
}

- (UIImage *)wipeImageWithView:(UIView *)view currentPoint:(CGPoint)point size:(CGSize)size {
    //计算位置
//    CGFloat offsetX = point.x - size.width * 0.5;
//    CGFloat offsetY = point.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(point.x, point.y
                                 , size.width, size.height);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把图片绘制上去
    [view.layer renderInContext:ctx];
    //把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    //重新赋值图片
    return newImage;
}

@end
