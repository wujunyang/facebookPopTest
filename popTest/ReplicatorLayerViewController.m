//
//  ReplicatorLayerViewController.m
//  popTest
//
//  Created by wujunyang on 2017/5/19.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "ReplicatorLayerViewController.h"

@interface ReplicatorLayerViewController ()

@end

@implementation ReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0, 100, 10, 80);
    layer.backgroundColor = [[UIColor whiteColor] CGColor];
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    [layer addAnimation:self.scaleAnimation forKey:@"scaleAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
    replicatorLayer.frame = CGRectMake(0, 0, 80, 80);
    
    //        设置复制层里面包含子层的个数
    replicatorLayer.instanceCount = 6;
    
    //        设置子层相对于前一个层的偏移量
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    
    //        设置子层相对于前一个层的延迟时间
    replicatorLayer.instanceDelay = 0.2;
    
    //        设置层的颜色，(前提是要设置层的背景颜色，如果没有设置背景颜色，默认是透明的，再设置这个属性不会有效果。
    replicatorLayer.instanceColor = [[UIColor greenColor] CGColor];
    //        颜色的渐变，相对于前一个层的渐变（取值-1~+1）.RGB有三种颜色，所以这里也是绿红蓝三种。
    replicatorLayer.instanceGreenOffset = -0.2;
    replicatorLayer.instanceRedOffset = -0.2;
    replicatorLayer.instanceBlueOffset = -0.2;
    
    
    //        需要把子层加入到复制层中，复制层按照前面设置的参数自动复制
    [replicatorLayer addSublayer:layer];
    
    
    
    //        将复制层加入view的层里面进行显示
    [self.view.layer addSublayer:replicatorLayer];
    
    
}


- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0.1;
    anim.duration = 0.4;
    anim.autoreverses = YES;
    anim.repeatCount = CGFLOAT_MAX;
    return anim;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//CAReplicatorLayer的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。
//属性说明：
//instanceCount：拷贝图层的次数,包括其所有的子图层,默认值是1,也就是没有任何子图层被复制。
//
//preservesDepth：如果设置为YES,图层将保持于CATransformLayer类似的性质和相同的限制
//
//instanceDelay：设置子层相对于前一个层的延迟时间
//instanceTransform： 设置子层相对于前一个层的偏移量
//instanceColor：设置层的颜色，(前提是要设置层的背景颜色，如果没有设置背景颜色，默认是透明的，再设置这个属性不会有效果。
//instanceRedOffset、instanceGreenOffset、instanceBlueOffset：颜色的渐变，相对于前一个层的渐变（取值-1~+1）.RGB有三种颜色，所以这里也是绿红蓝三种。
//instanceAlphaOffset：相对于前一个层透明图的渐变。


@end
