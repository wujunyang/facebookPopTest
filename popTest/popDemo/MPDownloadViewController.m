//
//  MPDownloadViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/6.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPDownloadViewController.h"
#import "YQDownloadButton.h"

@interface MPDownloadViewController ()

@end

@implementation MPDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    YQDownloadButton *button = [[YQDownloadButton alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
