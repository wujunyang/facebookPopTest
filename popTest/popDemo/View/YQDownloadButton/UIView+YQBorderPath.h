//
//  UIView+YQBorderPath.h
//  YQDownloadButton
//
//  Created by yingqiu huang on 2017/2/7.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YQBorderPath)

///圆形区域的path
+ (UIBezierPath *)circlePathRect:(CGRect)rect
                       lineWidth:(CGFloat)width;

@end
