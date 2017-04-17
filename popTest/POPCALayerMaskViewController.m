//
//  POPCALayerMaskViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/17.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "POPCALayerMaskViewController.h"

@interface POPCALayerMaskViewController ()
@property (strong, nonatomic) UIImageView *grayHead;
@property (strong, nonatomic) UIImageView *greenHead;
@property (strong, nonatomic) CAShapeLayer *maskLayerUp;
@property (strong, nonatomic) CAShapeLayer *maskLayerDown;

@property (strong, nonatomic) TNActivityIndicator *loadingIndicator;
@end

static const CFTimeInterval duration = 5.0;

@implementation POPCALayerMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (!self.grayHead) {
        self.grayHead=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
        self.grayHead.image=[UIImage imageNamed:@"bull_head_gray"];
        [self.view addSubview:self.grayHead];
    }
    
    if (!self.greenHead) {
        self.greenHead=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
        self.greenHead.image=[UIImage imageNamed:@"bull_head_green"];
        [self.view addSubview:self.greenHead];
    }
    
    self.greenHead.layer.mask = [self greenHeadMaskLayer];
    
    
    if (!self.loadingIndicator) {
        self.loadingIndicator=[[TNActivityIndicator alloc]initWithFrame:CGRectMake(200, 200, 30, 30)];
        [self.view addSubview:self.loadingIndicator];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.loadingIndicator startAnimating];
    [self startGreenHeadAnimation];
}

- (void)startGreenHeadAnimation
{
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    downAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(10.0f, 10.0f)];
    downAnimation.duration = duration;
    [self.maskLayerUp addAnimation:downAnimation forKey:@"downAnimation"];
    
    CABasicAnimation *upAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    upAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(35.0f, 35.0f)];
    upAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(20.0f, 20.0f)];
    upAnimation.duration = duration;
    [self.maskLayerDown addAnimation:upAnimation forKey:@"upAnimation"];
}

- (CALayer *)greenHeadMaskLayer
{
    CALayer *mask = [CALayer layer];
    mask.frame = self.greenHead.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor; // Any color but clear will be OK
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                           radius:15.0f
                                                       startAngle:0
                                                         endAngle:2*M_PI
                                                        clockwise:YES].CGPath;
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor; // Any color but clear will be OK
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                             radius:15.0f
                                                         startAngle:0
                                                           endAngle:2*M_PI
                                                          clockwise:YES].CGPath;
    self.maskLayerDown.position = CGPointMake(35.0f, 35.0f);
    [mask addSublayer:self.maskLayerDown];
    
    return mask;
}

@end
