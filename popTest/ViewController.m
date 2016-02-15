//
//  ViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PopBasicAction:(id)sender {
    
    POPBasicAnimationViewController *basicPage=[[POPBasicAnimationViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}
@end
