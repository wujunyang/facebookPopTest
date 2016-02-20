//
//  CoreAnimationViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/19.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()
@property(strong,nonatomic)UIView *ui_View,*bound_View,*bgColor_View,*y_View,*my_View,*my_pathView,*my_GroupView;
@property(strong,nonatomic)UIView *my_transition,*my_pushTranstion;

@property(strong,nonatomic)UIImageView *my_ImageView;
@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self animationOfBlock];
    
    [self animationButtonOfBlock];
    
    [self animationMyView];
    
    [self animatioBoundView];
    
    [self animationBgColorView];
    
    [self animationYView];
    
    [self animationValues];
    
    [self animationPath];
    
    [self animationGroup];
    
    [self animationTransition];
    
    [self animationPushTransition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animationOfBlock
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 80, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    [UIView animateWithDuration:1 //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionTransitionFlipFromLeft//动画效果
                     animations:^{
                         
                         //动画设置区域
                         redView.backgroundColor=[UIColor greenColor];
                         redView.frame=CGRectMake(50, 100, 200, 200);
                         redView.alpha=0.5;
                         
                     } completion:^(BOOL finish){
                         //动画结束时调用
                         
                         NSLog(@"当前的坐标：%@",NSStringFromCGRect(redView.frame));
                         NSLog(@"我结束了");
                     }];
    
    
}

-(void)animationButtonOfBlock
{
    //初始化一个View，用来显示动画
    UIButton *myButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 280, 60, 60)];
    myButton.backgroundColor=[UIColor grayColor];
    [myButton setTitle:@"你好" forState:UIControlStateNormal];
    
    [self.view addSubview:myButton];
    
    [UIView animateWithDuration:1 //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionTransitionFlipFromLeft//动画效果
                     animations:^{
                         
                         //动画设置区域
                         myButton.backgroundColor=[UIColor blueColor];
                         myButton.frame=CGRectMake(50, 280, 100, 100);
                         myButton.alpha=0.5;
                         
                     } completion:^(BOOL finish){
                         //动画结束时调用
                         NSLog(@"我结束了");
                     }];
    
    
}

//缩放变化
-(void)animationMyView
{
    if (self.ui_View==nil) {
        self.ui_View=[[UIView alloc]initWithFrame:CGRectMake(250, 200, 50, 50)];
        self.ui_View.backgroundColor=[UIColor blackColor];
        [self.view addSubview:self.ui_View];
    }
    
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pulse.duration = 0.5 + (rand() % 10) * 0.05;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:.8];
    pulse.toValue = [NSNumber numberWithFloat:1.2];
    [self.ui_View.layer addAnimation:pulse forKey:nil];
}

//大小变化
-(void)animatioBoundView
{
    
    if (self.bound_View==nil) {
        self.bound_View=[[UIView alloc]initWithFrame:CGRectMake(330,200,50,50)];
        self.bound_View.backgroundColor=[UIColor blackColor];
        [self.view addSubview:self.bound_View];
    }
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anim.duration = 1.f;
    anim.fromValue=[NSValue valueWithCGRect:CGRectMake(300,200,50,50)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(10,10,200,200)];
    anim.byValue  = [NSValue valueWithCGRect:self. bound_View.bounds];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    
    [self.bound_View.layer addAnimation:anim forKey:nil];
}

//背景色变化
-(void)animationBgColorView
{
    if (self.bgColor_View==nil) {
        self.bgColor_View=[[UIView alloc]initWithFrame:CGRectMake(10,300,50,50)];
        self.bgColor_View.backgroundColor=[UIColor grayColor];
        [self.view addSubview:self.bgColor_View];
    }
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim.duration = 3.f;
    anim.toValue = (id)[UIColor redColor].CGColor;
    anim.fromValue =  (id)[UIColor greenColor].CGColor;
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.repeatCount = CGFLOAT_MAX;
    
    [self.bgColor_View.layer addAnimation:anim forKey:nil];
}

-(void)animationYView
{
    if (self.y_View==nil) {
        self.y_View=[[UIView alloc]initWithFrame:CGRectMake(100,300,50,50)];
        self.y_View.backgroundColor=[UIColor greenColor];
        [self.view addSubview:self.y_View];
    }
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=@50;
    animation.duration=5;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.y_View.layer addAnimation:animation forKey:nil];
}


//values方式
-(void)animationValues
{
    if (self.my_View==nil) {
        self.my_View=[[UIView alloc]initWithFrame:CGRectMake(120,350,50,50)];
        self.my_View.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.my_View];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.values=@[value1,value2,value3,value4,value5];
    animation.repeatCount=MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate=self;
    [self.my_View.layer addAnimation:animation forKey:nil];
}


//path方式
-(void)animationPath
{
    if (self.my_pathView==nil) {
        self.my_pathView=[[UIView alloc]initWithFrame:CGRectMake(120,350,50,50)];
        self.my_pathView.backgroundColor=[UIColor blueColor];
        [self.view addSubview:self.my_pathView];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    animation.path=path;
    CGPathRelease(path);
    animation.repeatCount=MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate=self;
    [self.my_pathView.layer addAnimation:animation forKey:nil];
}

-(void)animationGroup
{
    if (self.my_GroupView==nil) {
        self.my_GroupView=[[UIView alloc]initWithFrame:CGRectMake(120,350,50,50)];
        self.my_GroupView.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:self.my_GroupView];
    }
    
    //贝塞尔曲线路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(10.0, 10.0)];
    [movePath addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
    
    //关键帧动画（位置）
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    
    //缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:posAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 5;
    
    [self.my_GroupView.layer addAnimation:animGroup forKey:nil];
}

//从下往上运动
-(void)animationTransition
{
    //y点就是当要运动后到的Y值
    if (self.my_transition==nil) {
        self.my_transition=[[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-250,[UIScreen mainScreen].bounds.size.width,250)];
        self.my_transition.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.my_transition];
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    //添加动画
    [self.my_transition.layer addAnimation:animation forKey:nil];
}


//从上往下运动
-(void)animationPushTransition
{
    //y点就是当要运动后到的Y值
    if (self.my_pushTranstion==nil) {
        self.my_pushTranstion=[[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width,250)];
        self.my_pushTranstion.backgroundColor=[UIColor blueColor];
        [self.view addSubview:self.my_pushTranstion];
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.4f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    
    //添加动画
    [self.my_pushTranstion.layer addAnimation:animation forKey:nil];
}

@end
