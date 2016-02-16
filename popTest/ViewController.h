//
//  ViewController.h
//  popTest
//
//  Created by wujunyang on 16/2/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

#import "POPBasicAnimationViewController.h"
#import "POPSpringAnimationViewController.h"
#import "POPDecayAnimationViewController.h"
#import "OtherViewController.h"

@interface ViewController : UIViewController
- (IBAction)PopBasicAction:(id)sender;
- (IBAction)spingAction:(id)sender;

- (IBAction)OtherAction:(id)sender;
- (IBAction)decayAction:(id)sender;

@end

