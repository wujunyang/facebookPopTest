//
//  MPUIBezierPathViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/5.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPUIBezierPathViewController.h"

@interface MPUIBezierPathViewController ()

@end

@implementation MPUIBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    RYCuteView *cuteView = [[RYCuteView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    cuteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cuteView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
