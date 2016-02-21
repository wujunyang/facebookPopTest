//
//  BezierPathViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/21.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "BezierPathViewController.h"

@interface BezierPathViewController ()
@property(strong,nonatomic)CAShapeLayer *trackLayer,*progressLayer,*CurvedLineLayer;
@property(strong,nonatomic)UIBezierPath *trackPath,*progressPath;

//创建全局属性
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self createBezierPath:CGRectMake(20, 80, 100, 100)];
    
    [self circleBezierPath];
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
    
    [self fiveAnimation];
    
    [self createDottedLine];
    
    [self createCurvedLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//画两个圆形
-(void)createBezierPath:(CGRect)mybound
{
    //外圆
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(mybound.size.width - 0.7)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    
    _trackLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.strokeColor=[UIColor grayColor].CGColor;
    _trackLayer.path = _trackPath.CGPath;
    _trackLayer.lineWidth=5;
    _trackLayer.frame = mybound;
    
    //内圆
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(mybound.size.width - 0.7)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * 0.7 - M_PI_2 clockwise:YES];
    
    _progressLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor=[UIColor redColor].CGColor;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = _progressPath.CGPath;
    _progressLayer.lineWidth=5;
    _progressLayer.frame = mybound;
}


-(void)circleBezierPath
{
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 150, 150);
    self.shapeLayer.position = self.view.center;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 2.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
}

- (void)circleAnimationTypeOne
{
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
        self.shapeLayer.strokeStart += 0.1;
    }else if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += 0.1;
    }
    
    if (self.shapeLayer.strokeEnd == 0) {
        self.shapeLayer.strokeStart = 0;
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
}

- (void)circleAnimationTypeTwo
{
    CGFloat valueOne = arc4random() % 100 / 100.0f;
    CGFloat valueTwo = arc4random() % 100 / 100.0f;
    
    self.shapeLayer.strokeStart = valueOne < valueTwo ? valueOne : valueTwo;
    self.shapeLayer.strokeEnd = valueTwo > valueOne ? valueTwo : valueOne;
}

//画一个五边形
-(void)fiveAnimation
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    //开始点 从上左下右的点
    [aPath moveToPoint:CGPointMake(100,100)];
    //划线点
    [aPath addLineToPoint:CGPointMake(60, 140)];
    [aPath addLineToPoint:CGPointMake(60, 240)];
    [aPath addLineToPoint:CGPointMake(160, 240)];
    [aPath addLineToPoint:CGPointMake(160, 140)];
    [aPath closePath];
    //设置定点是个5*5的小圆形（自己加的）
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100-5/2.0, 0, 5, 5)];
    [aPath appendPath:path];
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    //设置边框颜色
    shapelayer.strokeColor = [[UIColor redColor]CGColor];
    //设置填充颜色 如果只要边 可以把里面设置成[UIColor ClearColor]
    shapelayer.fillColor = [[UIColor blueColor]CGColor];
    //就是这句话在关联彼此（UIBezierPath和CAShapeLayer）：
    shapelayer.path = aPath.CGPath;
    [self.view.layer addSublayer:shapelayer];
}

//画一条虚线
-(void)createDottedLine
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.view.bounds];
    [shapeLayer setPosition:self.view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
    [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 89);
    CGPathAddLineToPoint(path, NULL, 320,89);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self.view layer] addSublayer:shapeLayer];
}

//画一个弧线
-(void)createCurvedLine
{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    [aPath moveToPoint:CGPointMake(20, 100)];
    [aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    
    self.CurvedLineLayer=[CAShapeLayer layer];
    self.CurvedLineLayer.path=aPath.CGPath;
    [self.view.layer addSublayer:self.CurvedLineLayer];
}

@end
