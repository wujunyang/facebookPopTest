//
//  MPScaleViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/6.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPScaleViewController.h"

@interface MPScaleViewController ()

@property (nonatomic, weak) CAShapeLayer *progressLayer;
@property (nonatomic, weak) UILabel      *label;

@end

@implementation MPScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.14 green:0.59 blue:0.83 alpha:1.00];
    
    // 外环弧线
    CAShapeLayer *outArc = [self drawCurveWithRadius:147.5];
    [self.view.layer addSublayer:outArc];
    
    // 内环弧线
    CAShapeLayer *inArc = [self drawCurveWithRadius:82.5];
    [self.view.layer addSublayer:inArc];
    
    // 绘制进度图层
    UIBezierPath *progressPath  = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                                 radius:115
                                                             startAngle:-M_PI
                                                               endAngle:0
                                                              clockwise:YES];
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.lineWidth     =  60.f;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];
    progressLayer.strokeColor   = [[UIColor whiteColor] CGColor];
    progressLayer.path          = progressPath.CGPath;
    progressLayer.strokeStart   = 0.0;
    progressLayer.strokeEnd     = 0.0;
    [self.view.layer addSublayer:progressLayer];
    _progressLayer = progressLayer;
    
    // 添加观察者，观察progressLayer的strokeEnd属性，以便为_lbel赋值
    [progressLayer addObserver:self
                    forKeyPath:@"strokeEnd"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    // 渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (id)[[UIColor colorWithRed:0.09 green:0.58 blue:0.15 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.20 green:0.63 blue:0.25 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.60 green:0.82 blue:0.22 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.97 green:0.65 blue:0.22 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.96 green:0.08 blue:0.10 alpha:1.00] CGColor],
                              nil]];
    [gradientLayer setLocations:@[@0, @0.25, @0.5, @0.75, @1]];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    [gradientLayer setMask:progressLayer];
    
    [self.view.layer addSublayer:gradientLayer];
    
    // 绘制刻度
    CGFloat perAngle = M_PI / 50; // 一刻度的弧度值
    CGFloat calWidth = perAngle / 5; // 刻度线的宽度
    
    for (int i = 1; i< 50; i++) {
        
        CGFloat startAngel = -M_PI + perAngle * i;
        CGFloat endAngel   = startAngel + calWidth;
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                                radius:140
                                                            startAngle:startAngel
                                                              endAngle:endAngel
                                                             clockwise:YES];
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if (i % 5 == 0) {
            
            perLayer.strokeColor = [[UIColor whiteColor] CGColor];
            perLayer.lineWidth   = 10.f;
            
            CGPoint point = [self calculateTextPositonWithArcCenter:self.view.center angle:-startAngel];
            
            UILabel *calibration       = [[UILabel alloc] initWithFrame:CGRectMake(point.x - 10, point.y - 10, 20, 20)];
            calibration.text           = [NSString stringWithFormat:@"%d", i * 2];
            calibration.font           = [UIFont systemFontOfSize:10];
            calibration.textColor      = [UIColor whiteColor];
            calibration.textAlignment  = NSTextAlignmentCenter;
            [self.view addSubview:calibration];
            
        }else{
            
            perLayer.strokeColor = [[UIColor colorWithRed:0.22 green:0.66 blue:0.87 alpha:1.0] CGColor];
            perLayer.lineWidth   = 5;
        }
        
        perLayer.path = tickPath.CGPath;
        
        [self.view.layer addSublayer:perLayer];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 40,
                                                               self.view.center.y - 50,
                                                               80,
                                                               50)];
    label.textColor = [UIColor whiteColor];
    label.text = @"0";
    label.font = [UIFont boldSystemFontOfSize:35];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    _label = label;
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                             self.view.center.y + 50,
                                                             self.view.bounds.size.width,
                                                             50)];
    tip.text = @"点击屏幕试试看！";
    tip.textColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    tip.font = [UIFont systemFontOfSize:20.f];
    tip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tip];
}

/**
 绘制弧线
 
 @param radius 半径
 @return CAShapeLayer
 */
- (CAShapeLayer *)drawCurveWithRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                        radius:radius
                                                    startAngle:-M_PI
                                                      endAngle:0
                                                     clockwise:YES];
    CAShapeLayer *curve = [CAShapeLayer layer];
    curve.lineWidth     = 5.f;
    curve.fillColor     = [[UIColor clearColor] CGColor];
    curve.strokeColor   = [[UIColor whiteColor] CGColor];
    curve.path          = path.CGPath;
    
    return curve;
}

/**
 计算Label位置
 
 @param center 中心点
 @param angel 角度
 @return CGPoint
 */
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center angle:(CGFloat)angel
{
    CGFloat calRadius = 125.f; // 刻度Label中心点所在圆弧的半径
    CGFloat x = calRadius * cosf(angel);
    CGFloat y = calRadius * sinf(angel);
    
    return CGPointMake(center.x + x, center.y - y);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"strokeEnd"]) {
        
        NSInteger value = [change[@"new"] floatValue] * 100;
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.f;
        _label.text = [NSString stringWithFormat:@"%zd", value];
        [_label.layer addAnimation:animation forKey:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInteger currentSpeed = arc4random_uniform(100);
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:1.f];
    _progressLayer.strokeEnd = currentSpeed * 0.01;
    [CATransaction commit];
}

- (void)dealloc
{
    [_progressLayer removeObserver:self forKeyPath:@"strokeEnd"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
