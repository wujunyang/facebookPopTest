//
//  MPTelescopicViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/5.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "MPTelescopicViewController.h"

@interface MPTelescopicViewController ()

@end

@implementation MPTelescopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
}

- (void)creatView {
    // up
    UILabel *homeLabel = [self creatHomeView:@"U"];
    HYYBubbleButton *hyyBtn = [[HYYBubbleButton alloc] initWithFrame:(CGRectMake(self.view.bounds.size.width / 2.f + 40.f, self.view.bounds.size.height - 150.f, homeLabel.bounds.size.width, homeLabel.bounds.size.height)) bubbleDirection:(BubbleDirectionUp)];
    hyyBtn.buttonSpacing = 35.f;
    hyyBtn.homeBubbleView = homeLabel;
    [hyyBtn addButtons:[self creatBubbleBtnArray]];
    [self.view addSubview:hyyBtn];
    
    // down
    UILabel *homeLabel1 = [self creatHomeView:@"D"];
    HYYBubbleButton *hyyBtn1 = [[HYYBubbleButton alloc] initWithFrame:(CGRectMake(self.view.bounds.size.width / 2.f - 80.f, 150.f, homeLabel1.bounds.size.width, homeLabel1.bounds.size.height)) bubbleDirection:(BubbleDirectionDown)];
    hyyBtn1.homeBubbleView = homeLabel1;
    [hyyBtn1 addButtons:[self creatBubbleBtnArray]];
    [self.view addSubview:hyyBtn1];
    
    // left
    UILabel *homeLabel2 = [self creatHomeView:@"L"];
    HYYBubbleButton *hyyBtn2 = [[HYYBubbleButton alloc] initWithFrame:(CGRectMake(self.view.bounds.size.width - 60.f, self.view.frame.size.height - 80.f, homeLabel2.bounds.size.width, homeLabel2.bounds.size.height)) bubbleDirection:(BubbleDirectionLeft)];
    hyyBtn2.homeBubbleView = homeLabel2;
    [hyyBtn2 addButtons:[self creatBubbleBtnArray]];
    [self.view addSubview:hyyBtn2];
    
    // right
    UILabel *homeLabel3 = [self creatHomeView:@"R"];
    HYYBubbleButton *hyyBtn3 = [[HYYBubbleButton alloc] initWithFrame:(CGRectMake(20.f, 80.f, homeLabel3.bounds.size.width, homeLabel3.bounds.size.height)) bubbleDirection:(BubbleDirectionRight)];
    hyyBtn3.homeBubbleView = homeLabel3;
    hyyBtn3.buttonSpacing = 10.f;
    [hyyBtn3 addButtons:[self creatBubbleBtnArray]];
    [self.view addSubview:hyyBtn3];
    
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"you click the button with tag of %ld",sender.tag);
}

- (NSArray *)creatBubbleBtnArray {
    NSMutableArray *buttonsArr = [NSMutableArray array];
    int i = 0;
    for (NSString *title in @[@"A",@"B",@"C",@"D",@"E",@"F"]) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [button setBackgroundColor:[UIColor colorWithRed:229. / 255. green:229. / 255. blue:229. / 255. alpha:1.]];
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.width / 2.f;
        button.clipsToBounds = YES;
        button.tag = i++;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [buttonsArr addObject:button];
    }
    return [buttonsArr copy];
}

- (UILabel *)creatHomeView:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0.f, 0.f, 40.f, 40.f))];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor = [UIColor lightGrayColor];
    label.clipsToBounds = YES;
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
