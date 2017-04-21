//
//  POPProgressBarViewController.m
//  popTest
//
//  Created by wujunyang on 2017/4/21.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "POPProgressBarViewController.h"

@interface POPProgressBarViewController ()

@property(nonatomic,strong)UIView *popCircle;

@end

@implementation POPProgressBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"点击视图查看效果";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.popCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    [self resetCircle];
    
    [self.view addSubview:self.popCircle];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handlePan:(UITapGestureRecognizer *)pan {
    [self performTransactionAnimation];
}

-(void)performTransactionAnimation
{
    [self.popCircle pop_removeAllAnimations];
    
    
    //设置里面进度条效果
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.98].CGColor;
    progressLayer.lineCap   = kCALineCapRound;
    progressLayer.lineJoin  = kCALineJoinBevel;
    progressLayer.lineWidth = 26.0;
    progressLayer.strokeEnd = 0.0;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline moveToPoint:CGPointMake(25.0, 25.0)];
    [progressline addLineToPoint:CGPointMake(400.0, 25.0)];
    progressLayer.path = progressline.CGPath;
    
    [self.popCircle.layer addSublayer:progressLayer];
    //
    //二维平面上分别沿着 X 和 Y 坐标轴进行缩放的动画 缩小成一个小圆
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.springBounciness = 5;
    scaleAnim.springSpeed = 12;
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(0.3, 0.3)];
    
    //再进行拉长
    POPSpringAnimation *boundsAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    boundsAnim.springBounciness = 10;
    boundsAnim.springSpeed = 6;
    boundsAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 800, 50)];
    
    //拉长动画结束后进行
    boundsAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            //然后再开始进度条的动画
            //UIGraphicsBeginImageContext这个方法来获取图形上下文进行绘制,那么UIGraphicsBeginImageContextWithOptions这个方法里面有3个属性，一个是size就是绘制的范围，还有一个是opaque,也就是这个图层是否完全透明，一般情况下最好设置为YES，这样可以让图层在渲染的时候效率更高。最关键的一个就是scale这个参数，那么这个参数的意思就是缩放比例，一般是1.0但是如果是在Retina屏幕上最好不要自己手动打个设置他的缩放比例，直接设置0，系统就会自动进行最佳的缩放
            //UIGraphicsBeginImageContextWithOptions(self.popCircle.frame.size, NO, 0.0);
            POPBasicAnimation *progressBoundsAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            progressBoundsAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            progressBoundsAnim.duration = 1.0;
            progressBoundsAnim.fromValue = @0.0;
            progressBoundsAnim.toValue = @1.0;
            
            [progressLayer pop_addAnimation:progressBoundsAnim forKey:@"AnimateBounds"];
            progressBoundsAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                if (finished) {
                  //  UIGraphicsEndImageContext();
                }
            };
            
            
        }
    };
    
    [self.popCircle.layer pop_addAnimation:boundsAnim forKey:@"AnimateBounds"];
    [self.popCircle.layer pop_addAnimation:scaleAnim forKey:@"AnimateScale"];
}


-(void)resetCircle
{
    [self.popCircle.layer pop_removeAllAnimations];
    for (CAShapeLayer *layer in self.popCircle.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    self.popCircle.layer.opacity = 1.0;
    [self.popCircle.layer setMasksToBounds:YES];
    [self.popCircle.layer setBackgroundColor:[UIColor colorWithRed:0.16 green:0.72 blue:1.0 alpha:1.0].CGColor];
    [self.popCircle.layer setCornerRadius:25.0f];
    [self.popCircle setBounds:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    self.popCircle.layer.position = CGPointMake(self.view.center.x, 180.0);
    
}

@end
