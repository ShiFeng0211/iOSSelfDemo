//
//  SnapshotViewController.m
//  Arithmetic
//
//  Created by v_shifeng on 2021/1/22.
//  Copyright © 2021 weibo. All rights reserved.
//

#import "SnapshotViewController.h"
#import "Masonry.h"
#import "MyView.h"

@interface SnapshotViewController ()
@property (nonatomic) MyView *v1;
@end

@implementation SnapshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.title = @"snapshot";
    _v1 = [[MyView alloc] init];
    [self.view addSubview:_v1];
    [_v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(300, 600));
    }];
    
//    UIImage *img = [self getImg2];
//    UIImageView *imaView = [[UIImageView alloc] initWithImage:img];
//    imaView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imaView];
//    [imaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(350, 300));
//    }];
}

- (UIImage *)getImg {
    UIImage *img = [UIImage imageNamed:@"logo.png"];
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0,0, img.size.width, img.size.height)];
    NSString *text = @"hello work";
    [text drawAtPoint:CGPointMake(120, 120) withAttributes:nil];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 4.关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (UIImage *)getImg1 {
    UIImage *img = [UIImage imageNamed:@"logo.png"];
    UIGraphicsBeginImageContext(img.size);
//    [img drawInRect:CGRectMake(0,0, img.size.width, img.size.height)];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    [path addClip];
//    [img drawAtPoint:CGPointZero];
    [img drawInRect:CGRectMake(0,0, img.size.width, img.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (UIImage *)getImg2 {
    UIImage *img = [UIImage imageNamed:@"logo.png"];
//    UIGraphicsBeginImageContext(img.size);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    [[UIColor blueColor] setStroke];
    [path stroke];
    [path addClip];
    [img drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(UIImage *)getImg3 {
    UIImage *image;
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

-(void)graphicPic {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
}

+ (void)cutScreenWithView:(nullable UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block {
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [_v1 cutScreenWithView:_v1 successBlock:^(UIImage * _Nullable image, NSData * _Nullable imagedata) {
//        NSLog(@"");
//        UIImageView *imageV = [[UIImageView alloc] init];
//        imageV.contentMode = UIViewContentModeScaleAspectFit;
//        [imageV setImage:image];
//
//        [self.view addSubview:imageV];
//        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.centerY.equalTo(self.view);
//            make.size.mas_equalTo(CGSizeMake(350, 300));
//
//        }];
//    }];
    
//    UIImage *newImg = [self getImg3];
//    UIImageView *imageV = [[UIImageView alloc] init];
//    imageV.contentMode = UIViewContentModeScaleAspectFit;
//    [imageV setImage:newImg];
//
//    [self.view addSubview:imageV];
//    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(350, 300));
//
//    }];
    
    
//  UIGraphicsBeginImageContext(self.view.bounds.size);
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5);
//    CGContextFillRect(context, CGRectMake(2, 2, 270, 270));
//    CGContextStrokePath(context);

    
    
    UIGraphicsBeginImageContext(CGSizeMake(300, 500));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddRect(context, CGRectMake(2, 2, 270, 270));
    CGContextStrokePath(context);
}

-(void)snapshot {
    UIGraphicsBeginImageContext(self.view.bounds.size);   //self为需要截屏的UI控件 即通过改变此参数可以截取特定的UI控件
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"image:%@",image); //至此已拿到image
    
    
    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
    imaView.contentMode = UIViewContentModeScaleAspectFit;

    [self.view addSubview:imaView];
    [imaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(350, 300));
    }];

//    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
//    imaView.frame = CGRectMake(0, 700, 500, 500);
//    [self.view addSubview:imaView];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);//把图片保存在本地
    
}

@end
