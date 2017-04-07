//
//  YQStartButton.m
//  YQDownloadButton
//
//  Created by yingqiu huang on 2017/2/7.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import "YQStartButton.h"

@interface YQStartButton()
    
@property (nonatomic, strong) CAShapeLayer *arrow;

@end

@implementation YQStartButton

#pragma mark - Override
- (instancetype) initWithFrame: (CGRect)frame {
    if (self = [super initWithFrame: frame]){
        [self addTarget: self
                 action: @selector(startUpDonwLoadAction)
       forControlEvents: UIControlEventTouchUpInside];
        [self addArrow];
    }
    return self;
}

#pragma mark - 绘制箭头折线
- (UIBezierPath *)drawArrow {
    CGFloat startPos = self.frame.size.width / 3.f;
    CGFloat centerPos = self.frame.size.height / 2.f;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint: CGPointMake(centerPos, startPos)];
    [path addLineToPoint: CGPointMake(centerPos, 2 * startPos)];
    
    [path moveToPoint: CGPointMake(centerPos, 2 * startPos)];
    [path addLineToPoint: CGPointMake(startPos, centerPos)];
    [path moveToPoint: CGPointMake(centerPos, 2 * startPos)];
    [path addLineToPoint: CGPointMake(2 * startPos, centerPos)];
    return path;
}

#pragma mark - Click Action
- (void)startUpDonwLoadAction {
    NSLog(@"click");
    [self.arrow removeFromSuperlayer];
    if ([_delegate respondsToSelector:@selector(startDownload)]) {
        [_delegate startDownload];
    }
    
}

#pragma mark - 添加箭头
- (void)addArrow {
    self.arrow = [CAShapeLayer layer];
    UIColor *arrowColor = [UIColor colorWithRed:79/255.0 green:240/255.0 blue:255/255.0 alpha:1];
    self.arrow.strokeColor = arrowColor.CGColor;
    self.arrow.lineWidth = 3;
    self.arrow.lineCap = kCALineCapRound; //线条拐角
    self.arrow.lineJoin = kCALineJoinRound; //终点处理
    self.arrow.path = [self drawArrow].CGPath;
    [self.layer addSublayer: self.arrow];
}

@end
