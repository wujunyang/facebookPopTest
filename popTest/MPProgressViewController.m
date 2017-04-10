//
//  MPProgressViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/7.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPProgressViewController.h"

@interface MPProgressViewController ()

@property(nonatomic,strong)UIView *topView,*bottomView;

@end

@implementation MPProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 100)];
    [self.view addSubview:_topView];
    
    [XLPaymentLoadingHUD showIn:_topView];
    
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 220, 200, 100)];
    [self.view addSubview:_bottomView];
    
    [XLPaymentSuccessHUD showIn:_bottomView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
