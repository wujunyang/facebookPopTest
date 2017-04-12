//
//  MPImageViewViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/12.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPImageViewViewController.h"

@interface MPImageViewViewController ()
{
    NSInteger _code;
}

@property(nonatomic,strong)UIImageView * headView;

@property(nonatomic,strong)NSTimer * time;

@property(nonatomic,strong)UIImageView * bottomView;

@end

@implementation MPImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * blueView = [[UIView alloc] initWithFrame:CGRectMake(1001, 100, 100, 100)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIImageView * bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 205, 60, 15)];
    bottomView.animationImages = @[[UIImage imageNamed:@"3"],[UIImage imageNamed:@"002"],[UIImage imageNamed:@"02"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"02"],[UIImage imageNamed:@"002"],[UIImage imageNamed:@"3"]];
    bottomView.animationDuration = 0.8;
    [bottomView startAnimating];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIImageView * headView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [headView setImage:[UIImage imageNamed:@"1"]];
    [self.view addSubview:headView];
    self.headView = headView;
    
    _code = 1;
    
    
    NSTimer * time = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animat) userInfo:nil repeats:YES];
    [time fire];
    self.time = time;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(100, 300, 100, 100);
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"停止" forState:UIControlStateNormal];
    [button setTitle:@"开始" forState:UIControlStateSelected];
    [self.view addSubview:button];
    
}

-(void)click:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.headView removeFromSuperview];
        [self.bottomView removeFromSuperview];
        [self.time invalidate];
        [self.bottomView stopAnimating];
    }else{
        
        [self.view addSubview:self.bottomView];
        [self.view addSubview:self.headView];
        self.time = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animat) userInfo:nil repeats:YES];
        [self.time fire];
        [self.bottomView startAnimating];
    }
}

-(void)animat{
    
    _headView.alpha = 1;
    [UIView animateWithDuration:0.4 animations:^{
        CGRect fram = _headView.frame;
        fram.origin.y += 50;
        _headView.frame = fram;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect fram = _headView.frame;
            fram.origin.y -= 50;
            _headView.frame = fram;
            _code = _code%3 + 1;
            switch (_code) {
                case 1:
                    [_headView setImage:[UIImage imageNamed:@"1"]];
                    break;
                case 2:
                    [_headView setImage:[UIImage imageNamed:@"01"]];
                    break;
                case 3:
                    [_headView setImage:[UIImage imageNamed:@"001"]];
                    break;
                    
                default:
                    break;
            }
        }];
    }];
    
}

@end
