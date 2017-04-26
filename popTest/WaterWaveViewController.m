//
//  WaterWaveViewController.m
//  popTest  https://github.com/liangwei518/WaterWave
//
//  Created by wujunyang on 2017/4/26.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "WaterWaveViewController.h"
#import "YDWaveLoadingView.h"

@interface WaterWaveViewController ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) YDWaveLoadingView *loadingView;

@end

@implementation WaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _loadingView = [YDWaveLoadingView loadingView];
    [self.view addSubview:_loadingView];
    _loadingView.center = self.view.center;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_loadingView startLoading];
    });
}

- (void)beginLoading:(id)sender
{
    [_loadingView startLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
