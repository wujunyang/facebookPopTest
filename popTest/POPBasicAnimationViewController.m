//
//  POPBasicAnimationViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/15.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "POPBasicAnimationViewController.h"

@interface POPBasicAnimationViewController ()
@property(strong,nonatomic)UIView *myView,*myXView,*myBackColorView,*mytimingFunctionLinearView,*mytimingFunctionEaseInEaseOutView,*mySizeView;
@property(strong,nonatomic)UILabel *myLabel;
@end

@implementation POPBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    //1:初始化一个视图块
    if (self.myView==nil) {
        self.myView=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        self.myView.backgroundColor=[UIColor redColor];
        self.myView.alpha=0;
        [self.view addSubview:self.myView];
    }
    
    //创建一个POPBasicAnimation动画 透明度的变化
    POPBasicAnimation *basicAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    basicAnimation.fromValue=@(0);
    basicAnimation.toValue=@(1);
    basicAnimation.duration=2; //设置动画的间隔时间 默认是0.4秒
    basicAnimation.repeatCount=HUGE_VALF; //重复次数 HUGE_VALF设置为无限次重复
    [self.myView pop_addAnimation:basicAnimation forKey:@"myViewAnimation"];
    
    //2:初始化一个视图块
    if (self.myXView==nil) {
        self.myXView=[[UIView alloc]initWithFrame:CGRectMake(50, 210, 50, 50)];
        self.myXView.backgroundColor=[UIColor blueColor];
        [self.view addSubview:self.myXView];
    }
    
    //创建一个POPBasicAnimation动画 X轴的变化 从50移到300位置
    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anBasic.toValue = @(300);
    anBasic.beginTime = CACurrentMediaTime() + 2.0f; //可以用来设置动画延迟执行时间，若想延迟2s，就设置为CACurrentMediaTime()+2，CACurrentMediaTime()为图层的当前时间
    anBasic.duration=5;//设置动画的间隔时间 默认是0.4秒
    [self.myXView pop_addAnimation:anBasic forKey:@"myBackColorViewAnimation"];
    
    //3:初始化一个视图块
    if (self.myBackColorView==nil) {
        self.myBackColorView=[[UIView alloc]initWithFrame:CGRectMake(250, 100, 50, 50)];
        self.myBackColorView.backgroundColor=[UIColor blackColor];
        [self.view addSubview:self.myBackColorView];
    }
    
    //创建一个POPBasicAnimation动画 视图的背影色从黑色经过5秒后渐进变成黄色
    POPBasicAnimation *anBackGroundBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anBackGroundBasic.toValue=[UIColor yellowColor];
    anBackGroundBasic.duration=5;
    [self.myBackColorView pop_addAnimation:anBackGroundBasic forKey:@"myBackColorViewAnimation"];
    
    //4:初始化一个视图块
    if (self.mytimingFunctionLinearView==nil) {
        self.mytimingFunctionLinearView=[[UIView alloc]initWithFrame:CGRectMake(0, 300, 50, 50)];
        self.mytimingFunctionLinearView.backgroundColor=[UIColor greenColor];
        [self.view addSubview:self.mytimingFunctionLinearView];
    }
    
    //创建一个POPBasicAnimation动画 视图中心以kCAMediaTimingFunctionLinear直线运行到中心点为100,64
    POPBasicAnimation *anLinearBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    anLinearBasic.toValue=[NSValue valueWithCGPoint:CGPointMake(100, 64)];
    anLinearBasic.duration=5;
    anLinearBasic.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.mytimingFunctionLinearView pop_addAnimation:anLinearBasic forKey:@"myLinearBasic"];
    
    //5:初始化一个视图块
    if (self.mytimingFunctionEaseInEaseOutView==nil) {
        self.mytimingFunctionEaseInEaseOutView=[[UIView alloc]initWithFrame:CGRectMake(100, 300, 50, 50)];
        self.mytimingFunctionEaseInEaseOutView.backgroundColor=[UIColor grayColor];
        [self.view addSubview:self.mytimingFunctionEaseInEaseOutView];
    }
    
    //创建一个POPBasicAnimation动画 视图中心以kCAMediaTimingFunctionEaseInEaseOut直线运行到中心点为200,64
    POPBasicAnimation *anEaseInEaseOutBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    anEaseInEaseOutBasic.toValue=[NSValue valueWithCGPoint:CGPointMake(200, 64)];
    anEaseInEaseOutBasic.duration=5;
    anEaseInEaseOutBasic.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.mytimingFunctionEaseInEaseOutView pop_addAnimation:anEaseInEaseOutBasic forKey:@"mytimingFunctionEaseInEaseOutView"];
    
    //6:初始化一个视图块
    if (self.mySizeView==nil) {
        self.mySizeView=[[UIView alloc]initWithFrame:CGRectMake(250, 300, 50, 50)];
        self.mySizeView.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.mySizeView];
    }
    
    //创建一个POPBasicAnimation动画 让视图块的大小从50*50 慢慢变到100*100
    POPBasicAnimation *ansizeBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
    ansizeBasic.toValue=[NSValue valueWithCGSize:CGSizeMake(100, 100)];
    ansizeBasic.duration=5;
    ansizeBasic.repeatCount=HUGE_VALF;
    [self.mySizeView pop_addAnimation:ansizeBasic forKey:@"mySizeView"];
    
    
    //7:初始化一个Label
    if (self.myLabel==nil) {
        self.myLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 300, 60, 30)];
        self.myLabel.backgroundColor=[UIColor redColor];
        self.myLabel.textAlignment=NSTextAlignmentCenter;
        self.myLabel.textColor=[UIColor whiteColor];
        self.myLabel.alpha=1;
        self.myLabel.text=@"Label";
        [self.view addSubview:self.myLabel];
    }
    
    //创建一个POPBasicAnimation动画 让视图块的大小从60*30 慢慢变到100*100  动画完成后又有一个动画变成60*30
    POPBasicAnimation* anLabelBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
    anLabelBasic.duration=3.0;
    anLabelBasic.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
    anLabelBasic.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [anLabelBasic setCompletionBlock:^(POPAnimation *ani, BOOL fin) {
        if (fin) {
            NSLog(@"self.myLabel.frame=%@",NSStringFromCGRect(self.myLabel.frame));
            
            POPBasicAnimation *newLabelAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
            newLabelAnimation.duration=3.0;
            newLabelAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(60, 30)];
            newLabelAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [self.myLabel pop_addAnimation:newLabelAnimation forKey:@"newMyLabelAnimation"];
        }
    }];
    [self.myLabel pop_addAnimation:anLabelBasic forKey:@"myLabelAnimation"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
