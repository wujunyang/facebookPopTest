//
//  POPSpringAnimationViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/15.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "POPSpringAnimationViewController.h"

@interface POPSpringAnimationViewController ()
@property(strong,nonatomic)UIView *myRedView,*myLayView,*myRotaView;
@property(strong,nonatomic)UIButton *myButton;
@end

@implementation POPSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view.backgroundColor=[UIColor whiteColor];
    
    //1:初始化第一个视图块
    if (self.myRedView==nil) {
        self.myRedView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 30, 30)];
        self.myRedView.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.myRedView];
    }
    
    //创建一个POPSpringAnimation动画 实现X轴运动 有反弹效果
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anSpring.toValue =@(300);
    anSpring.beginTime = CACurrentMediaTime() + 1.0f;
    anSpring.springBounciness=14.0;    //[0-20] 弹力 越大则震动幅度越大
    anSpring.springSpeed=12.0;   //[0-20] 速度 越大则动画结束越快
    [anSpring setCompletionBlock:^(POPAnimation *prop, BOOL fint) {
        if (fint) {
            NSLog(@"self.myRedView.frame=%@",NSStringFromCGRect(self.myRedView.frame));
        }
    }];
    [self.myRedView pop_addAnimation:anSpring forKey:@"myRedViewposition"];
    

    //2:初始化一个视图块
    if (self.myLayView==nil) {
        self.myLayView=[[UIView alloc]initWithFrame:CGRectMake(20, 120, 30, 30)];
        self.myLayView.backgroundColor=[UIColor blueColor];
        [self.view addSubview:self.myLayView];
    }
    
    //创建一个POPSpringAnimation动画 实现闪一下效果 从0.2到1.0的弹效果
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.2, 0.2f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.beginTime = CACurrentMediaTime() + 1.0f;
    scaleAnimation.springBounciness = 20.0f;
    scaleAnimation.springSpeed = 20.0f;
    [self.myLayView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    //3:初始化一个视图块
    if (self.myRotaView==nil) {
        self.myRotaView=[[UIView alloc]initWithFrame:CGRectMake(20, 170, 30, 30)];
        self.myRotaView.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:self.myRotaView];
    }
    
    //创建一个POPSpringAnimation动画 将视图进行旋转
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.2;
    rotationAnimation.toValue = @(1.2);
    rotationAnimation.springBounciness = 10.f;
    rotationAnimation.springSpeed = 3;
    [self.myRotaView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnim"];
    
    //4:初始化一个按键
    if (self.myButton==nil) {
        self.myButton=[[UIButton alloc]init];
        self.myButton.frame=CGRectMake(20, 220, 60, 30);
        self.myButton.backgroundColor = [UIColor grayColor];
        [self.myButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.myButton addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.myButton];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchUpInside:(id)sender
{
    //创建一个POPSpringAnimation动画  按键左右摇动
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.velocity = @2000;
    positionAnimation.springBounciness = 20;
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.myButton.userInteractionEnabled = YES;
    }];
    [self.myButton.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}
@end
