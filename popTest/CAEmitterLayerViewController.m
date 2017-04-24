//
//  CAEmitterLayerViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/24.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "CAEmitterLayerViewController.h"
#import "WclEmitterButton.h"


@interface CAEmitterLayerViewController ()
@property(nonatomic,strong)WclEmitterButton *myButton;
@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (self.myButton==nil) {
        self.myButton=[[WclEmitterButton alloc]initWithFrame:CGRectMake(100, 150, 15, 15)];
        [self.myButton setImage:[UIImage imageNamed:@"priase_dafault"] forState:UIControlStateNormal];
        [self.myButton setImage:[UIImage imageNamed:@"priase_select"] forState:UIControlStateSelected];
        [self.myButton addTarget:self action:@selector(wclButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.myButton];
    }
}

- (void)wclButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
