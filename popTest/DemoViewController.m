//
//  DemoViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/18.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "DemoViewController.h"
#import <POP.h>

@interface DemoViewController ()
@property (nonatomic, retain) UIView *button;
@property (nonatomic, retain) UIView *popOut;
@property (readwrite, assign) BOOL timerRunning;
@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _popOut = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TimerPopOut"]];
    [_popOut setFrame:CGRectMake(245, 70, 0, 0)];
    [self.view addSubview:_popOut];
    
    _button = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TimerButton"]];
    [_button setFrame:CGRectMake(240, 50, 46, 46)];
    [self.view addSubview:_button];
    
    _timerRunning = NO;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(demoAnimate:)]];
}


- (void)demoAnimate:(UITapGestureRecognizer*)tap
{
    _timerRunning = !_timerRunning;
    
    POPSpringAnimation *buttonAnimation = [POPSpringAnimation animation];
    buttonAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    if (_timerRunning) {
        buttonAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(37, 37)];
    }
    else {
        buttonAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(46, 46)];
    }
    buttonAnimation.springBounciness = 10.0;
    buttonAnimation.springSpeed = 10.0;
    [_button pop_addAnimation:buttonAnimation forKey:@"pop"];
    
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    if (!_timerRunning) {
        popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(245, 70, 0, 10)];
    }
    else {
        popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(180, 60, 75, 26)];
    }
    popOutAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(200, 0, 300, -200)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    [_popOut pop_addAnimation:popOutAnimation forKey:@"slide"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
