//
//  PopBackTopViewController.m
//  popTest
//
//  Created by wujunyang on 2017/2/4.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "PopBackTopViewController.h"

@interface PopBackTopViewController ()
@property(nonatomic,strong)UIView *myTopView;
@property(nonatomic,strong)UIView *myImageView;

@property(nonatomic,strong)UIView *myTitleView;
@property(nonatomic,strong)UILabel *myTitleLabel;
@end

@implementation PopBackTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.title=@"返回顶部效果";
    
    //翻动效果
    if(!self.myTitleView)
    {
        self.myTitleView=[UIView new];
        self.myTitleView.backgroundColor=[UIColor blackColor];
        self.myTitleView.alpha=0.3;
        [self.view addSubview:self.myTitleView];
        [self.myTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 150));
            make.top.mas_equalTo(100);
            make.left.mas_equalTo(100);
        }];
    }
    
    if (!self.myTitleLabel) {
        self.myTitleLabel=[UILabel new];
        self.myTitleLabel.textColor=[UIColor redColor];
        self.myTitleLabel.textAlignment=NSTextAlignmentCenter;
        self.myTitleLabel.text=@"购物车信息";
        [self.myTitleView addSubview:self.myTitleLabel];
        [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
        }];
    }
    
    //增加动画
    [self myAddViewAnimation];
    
    
    //底部圆角
    if (!self.myTopView) {
        self.myTopView=[UIView new];
        self.myTopView.backgroundColor=[UIColor blueColor];
        self.myTopView.layer.cornerRadius=50;
        self.myTopView.layer.masksToBounds=YES;
        [self.view addSubview:self.myTopView];
        [self.myTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.bottom.mas_equalTo(-200);
            make.right.mas_equalTo(-100);
        }];
    }
    
    
    if (!self.myImageView) {
        self.myImageView=[UIView new];
        self.myImageView.backgroundColor=[UIColor redColor];
        [self.myTopView addSubview:self.myImageView];
        [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.center.mas_equalTo(0);
        }];
    }
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [self.myTopView addGestureRecognizer:singleTap];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"响应效果了");
    
    POPBasicAnimation *basicAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    basicAnimation.toValue=@5;
    [self.myTopView.layer pop_addAnimation:basicAnimation forKey:@"myTopViewPop"];
    
    
    POPBasicAnimation *basicSizeAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    basicSizeAnimation.toValue= [NSValue valueWithCGSize:CGSizeMake(200, 100)];
    [self.myTopView.layer pop_addAnimation:basicSizeAnimation forKey:@"myTopViewSizePop"];
    
    
    [basicSizeAnimation setCompletionBlock:^(POPAnimation *ani, BOOL fin) {
        if (fin) {
            
            POPBasicAnimation *bAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
            bAnimation.toValue= [NSValue valueWithCGSize:CGSizeMake(100, 100)];
            bAnimation.beginTime = CACurrentMediaTime() + 2.0f;
            [self.myTopView.layer pop_addAnimation:bAnimation forKey:@"myTopViewbackSizePop"];
            
            POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
            anBasic.beginTime = CACurrentMediaTime() + 2.0f; //可以用来设置动画延迟执行时间，若想延迟2s，就设置为CACurrentMediaTime()+2，CACurrentMediaTime()为图层的当前时间
            anBasic.toValue=@50;
            [self.myTopView.layer pop_addAnimation:anBasic forKey:@"myTopViewbackPop"];
            

        }
    }];
}

-(void)myAddViewAnimation
{
    POPBasicAnimation *basicAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationY];
    basicAnimation.toValue= @(160);
    [self.myTitleView.layer pop_addAnimation:basicAnimation forKey:@"mybasicAnimation"];
    
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animation];
    alphaAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    alphaAnimation.toValue= @(0.1);
    alphaAnimation.beginTime = CACurrentMediaTime() + 2.0f;
    [self.myTitleView pop_addAnimation:alphaAnimation forKey:@"myalphaAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
