//
//  POPProgressViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/21.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "POPProgressViewController.h"

float progress = 0;

@interface POPProgressViewController ()<BLEProgressViewDelegate>
@property (nonatomic, strong) BLEProgressView *progressView;
@property (nonatomic, strong) CADisplayLink* displayLink;

@property(nonatomic,strong)UIButton *startButtom,*errorButtom,*resumeButtom;
@end

@implementation POPProgressViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blueColor];
    
    [self addProgressView];
    
    
    _startButtom=[[UIButton alloc]initWithFrame:CGRectMake(10, 400, 60, 40)];
    [_startButtom setTitle:@"开始" forState:UIControlStateNormal];
    [_startButtom addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    _startButtom.backgroundColor=[UIColor redColor];
    [self.view addSubview:_startButtom];
    
    
    _errorButtom=[[UIButton alloc]initWithFrame:CGRectMake(100, 400, 60, 40)];
    [_errorButtom setTitle:@"出错" forState:UIControlStateNormal];
    _errorButtom.backgroundColor=[UIColor redColor];
    [_errorButtom addTarget:self action:@selector(error:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_errorButtom];
    
    _resumeButtom=[[UIButton alloc]initWithFrame:CGRectMake(180, 400, 60, 40)];
    [_resumeButtom setTitle:@"重试" forState:UIControlStateNormal];
    _resumeButtom.backgroundColor=[UIColor redColor];
    [_resumeButtom addTarget:self action:@selector(resume:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resumeButtom];
}

- (void)addProgressView{
    BLEProgressView *progressView = [[BLEProgressView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 120)];
    self.progressView = progressView;
    self.progressView.delegate = self;
    [self.view addSubview:progressView];
}

#pragma mark - event response

- (void)start:(id)sender {
    [self.progressView start];
}
- (void)error:(id)sender {
    if (progress != 0) {
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        progress = 0;
    }
    
    [self.progressView fail];
}
- (void)resume:(id)sender {
    [self.progressView resume];
}

-(void)setProgress:(id)sender{
    if (progress > 100.f) {
        [self.progressView setProgess:1];
        [sender removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        progress = 0;
        return;
    }
    [self.progressView setProgess:progress/100.f];
    if (progress<10) {
        progress += 1;
    }
    else if (progress>=10 && progress <20) {
        progress += 1;
    }
    else if (progress>=20 && progress <30) {
        progress += 0.2;
    }
    else if (progress>=30 && progress <40) {
        progress += 0.2;
    }
    else if (progress>=40 && progress <50) {
        progress += 1.5;
    }
    else if (progress>=50 && progress <60) {
        progress += 1.5;
    }
    else if (progress>=60 && progress <70) {
        progress += 1.5;
    }
    else if (progress>=70 && progress <80) {
        progress += 1.5;
    }
    else if (progress>=80 && progress <90) {
        progress += 1.5;
    }
    else {
        progress += 1.5;
    }
}

#pragma mark - BLEProgressViewDelegate
-(void)progressView:(BLEProgressView *)progressView didChangedState:(ProgressState)state{
    if (state == BLEProgressStateRunning) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setProgress:) ];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
@end
