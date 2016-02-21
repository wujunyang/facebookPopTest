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

- (IBAction)spingAction:(id)sender {
    POPSpringAnimationViewController *basicPage=[[POPSpringAnimationViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}

- (IBAction)OtherAction:(id)sender {
    OtherViewController *basicPage=[[OtherViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}

- (IBAction)decayAction:(id)sender {
    POPDecayAnimationViewController *basicPage=[[POPDecayAnimationViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}

- (IBAction)decayDemoAction:(id)sender {
    DecayViewController *basicPage=[[DecayViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}


- (IBAction)demosAction:(id)sender {
    DemoViewController *basicPage=[[DemoViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}

- (IBAction)coreAction:(id)sender {
    
    CoreAnimationViewController *basicPage=[[CoreAnimationViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}

- (IBAction)BezirPathAction:(id)sender {
    BezierPathViewController *basicPage=[[BezierPathViewController alloc]init];
    [self.navigationController pushViewController:basicPage animated:YES];
}
@end
