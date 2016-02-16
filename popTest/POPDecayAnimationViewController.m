//
//  POPDecayAnimationViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/16.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "POPDecayAnimationViewController.h"

@interface POPDecayAnimationViewController ()
@property(strong,nonatomic)UIView *myView,*myRotationView;
@property (nonatomic) BOOL animated;

@property(strong,nonatomic)UILabel *myLabel;
@property (nonatomic) BOOL labelAnimated;
@end

@implementation POPDecayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //1:初始化第一个视图块
    if (self.myView==nil) {
        self.myView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 30, 30)];
        self.myView.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.myView];
    }
    
    //创建一个POPDecayAnimation动画 实现X轴运动 减慢速度的效果 通过速率来计算运行的距离 没有toValue属性
    POPDecayAnimation *anSpring = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anSpring.velocity = @(500); //速率
    anSpring.beginTime = CACurrentMediaTime() + 1.0f;
    [anSpring setCompletionBlock:^(POPAnimation *prop, BOOL fint) {
        if (fint) {
            NSLog(@"myView=%@",NSStringFromCGRect(self.myView.frame));
        }
    }];
    [self.myView pop_addAnimation:anSpring forKey:@"myViewposition"];
    
    
    //2:初始化一个视图块
    if(self.myRotationView==nil)
    {
        self.myRotationView=[[UIView alloc]initWithFrame:CGRectMake(20, 130, 30, 30)];
        self.myRotationView.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.myRotationView];
    }
    
    //创建一个POPDecayAnimation动画  连续不停的转动
    [self performAnimation];
    
    //3:初始化一个Label
    if (self.myLabel==nil) {
        self.myLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 180, 160, 30)];
        self.myLabel.text=@"我将会不断的改变";
        [self.view addSubview:self.myLabel];
    }
    
    [self labelPerformAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)performAnimation
{
    [self.myRotationView.layer pop_removeAllAnimations];
    POPDecayAnimation *anRotaion=[POPDecayAnimation animation];
    anRotaion.property=[POPAnimatableProperty propertyWithName:kPOPLayerRotation];
    
    if (self.animated) {
        anRotaion.velocity = @(-150);
    }else{
        anRotaion.velocity = @(150);
        anRotaion.fromValue =  @(25.0);
    }
    
    self.animated = !self.animated;
    
    anRotaion.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self performAnimation];
        }
    };
    
    [self.myRotationView.layer pop_addAnimation:anRotaion forKey:@"myRotationView"];
}

-(void)labelPerformAnimation
{
    [self.myLabel pop_removeAllAnimations];
    POPDecayAnimation *anRotaion=[POPDecayAnimation animation];
    anRotaion.property=[POPAnimatableProperty propertyWithName:kPOPLabelTextColor];
    
    if (self.labelAnimated) {
        anRotaion.velocity = [UIColor blackColor];
    }else{
        anRotaion.velocity =[UIColor greenColor];
        anRotaion.fromValue  = [UIColor colorWithRed:0.2 green:0.1 blue:0.3 alpha:1];
    }
    
    self.labelAnimated = !self.labelAnimated;
    
    anRotaion.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self labelPerformAnimation];
        }
    };
    
    [self.myLabel pop_addAnimation:anRotaion forKey:@"myLabelAnimated"];
}
@end
