//
//  MPPushViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/7.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPPushViewController.h"

@interface MPPushViewController ()

@end

@implementation MPPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 60);
    button.layer.cornerRadius = 25.0f;
    button.backgroundColor = [UIColor colorWithRed:189/255.0 green:79/255.0 blue:70/255.0 alpha:1];
    [button addTarget:self action:@selector(pushMethod) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Menu_icn"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    self.xl_pushTranstion = [XLBubblePushTransition transitionWithAnchorRect:button.frame];
    self.xl_popTranstion = [XLBubblePopTransition transitionWithAnchorRect:button.frame];
}

-(void)pushMethod{
    MPPopViewController *vc = [[MPPopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
