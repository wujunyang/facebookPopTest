//
//  POPTableViewController.m
//  popTest
//
//  Created by wujunyang on 2017/2/4.
//  Copyright © 2017年 wujunyang. All rights reserved.
//

#import "POPTableViewController.h"

@interface POPTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic) NSArray *items;
@property (nonatomic,strong) UITableView  *myTableView;
@end

@implementation POPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.items) {
        self.items=@[@"CoreAnmation普通动画运用",@"BezierPath实例",@"POPBasicAnimation运用",@"POPSpringAnimation运用",@"POPDecayAnimation运用",@"POPDecayAnimation结合小实例",@"伸收小实例",@"倒计时小实例",@"缩放动画",@"用UIBezierPath实现果冻效果",@"仿钉钉弹出效果",@"注水的动作效果",@"刻度盘效果",@"进度动画效果",@"跳转动画效果",@"UIImageView自身动画效果",@"CALayer中关于Mask实现注水效果",@"POP进度条变化效果",@"POP进度条带百分比效果",@"CAEmitterLayer粒子效果的显示",@"波动动画效果"];
    }
    
    //初始化表格
    if (!_myTableView) {
        _myTableView                                = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
        _myTableView.showsVerticalScrollIndicator   = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.dataSource                     = self;
        _myTableView.delegate                       = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self.view addSubview:_myTableView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



#pragma mark UITableViewDataSource, UITableViewDelegate相关内容

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text   = self.items[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            CoreAnimationViewController *vc=[[CoreAnimationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            BezierPathViewController *vc=[[BezierPathViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            POPBasicAnimationViewController *vc=[[POPBasicAnimationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            POPSpringAnimationViewController *vc=[[POPSpringAnimationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            POPDecayAnimationViewController *vc=[[POPDecayAnimationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:
        {
            DecayViewController *vc=[[DecayViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:
        {
            DemoViewController *vc=[[DemoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:
        {
            OtherViewController *vc=[[OtherViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 8:
        {
            PopBackTopViewController *vc=[[PopBackTopViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 9:
        {
            MPUIBezierPathViewController *vc=[[MPUIBezierPathViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 10:
        {
            MPTelescopicViewController *vc=[[MPTelescopicViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 11:
        {
            MPDownloadViewController *vc=[[MPDownloadViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 12:
        {
            MPScaleViewController *vc=[[MPScaleViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 13:
        {
            MPProgressViewController *vc=[[MPProgressViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 14:
        {
            MPPushViewController *vc=[[MPPushViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 15:
        {
            MPImageViewViewController *vc=[[MPImageViewViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 16:
        {
            POPCALayerMaskViewController *vc=[[POPCALayerMaskViewController
                                               alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 17:
        {
            POPProgressBarViewController *vc=[[POPProgressBarViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 18:
        {
            POPProgressViewController *vc=[[POPProgressViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 19:
        {
            CAEmitterLayerViewController *vc=[[CAEmitterLayerViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 20:
        {
            WaterWaveViewController *vc=[[WaterWaveViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

@end
