//
//  SnapTool.h
//  Arithmetic
//
//  Created by v_shifeng on 2021/2/1.
//  Copyright © 2021 weibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SnapTool : NSObject
/** 获取屏幕截图 */
+(UIImage *) getCurrentScreenShot;
/** 获取某个view 上的截图 */
+(UIImage *) getCurrentViewShot:(UIView *) view;
/** 获取某个scrollview 上的截图 */
+(UIImage *) getCurrentScrollviewShot:(UIScrollView *) scrollview;
/** 获取某个 范围内的 截图 */
+ (UIImage *) getCurrentInnerViewShot: (UIView *) innerView atFrame:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
