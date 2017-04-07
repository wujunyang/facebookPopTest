//
//  UIView+YQBorderPath.m
//  YQDownloadButton
//
//  Created by yingqiu huang on 2017/2/7.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import "UIView+YQBorderPath.h"

@implementation UIView (YQBorderPath)

///圆形区域的path
+ (UIBezierPath *)circlePathRect:(CGRect)rect
                       lineWidth:(CGFloat)width {
    //没有直接使用rect防止传入的是frame而不是试图的bounds
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [path setLineWidth:width];
    
    return path;
}
@end
