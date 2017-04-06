//
//  HYYBubbleButton.h
//  仿钉钉按钮
//
//  Created by Self_Improve on 17/3/8.
//  Copyright © 2017年 HYY. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 bubble expand direction

 - BubbleDirectionLeft: expand to left
 - BubbleDirectionRight: expand to right
 - BubbleDirectionUp: expand to up
 - BubbleDirectionDown: expand to down
 */
typedef NS_ENUM(NSUInteger, BubbleDirection){
    BubbleDirectionLeft = 0,
    BubbleDirectionRight,
    BubbleDirectionUp,
    BubbleDirectionDown
};

@interface HYYBubbleButton : UIView<UIGestureRecognizerDelegate>
// bubble expand containt buttons, default is readonly, you can not set buttons
@property (nonatomic, strong, readonly) NSArray *buttons;

// primary view, initial view
@property (nonatomic, strong) UIView *homeBubbleView;

// judge bubble is expand, example: isCollapsed is Yes, mean bubble is not expand
@property (nonatomic, readonly) BOOL isCollapsed;

// enum, the bubble expand direction
@property (nonatomic, assign) BubbleDirection direction;

// primary view become highlight is needed animation
@property (nonatomic, assign) BOOL animatedHighlighting;

// when you choose the expand button, if you need collapse the bobble, default is Yes
@property (nonatomic, assign) BOOL collapseAfterSelection;

// expand the bubble animation time, and if you set animatedHighlighting is Yes, the primary view become highlight time, default is 0.25f
@property (nonatomic, assign) float animationDuration;

// the primary view stand alpha, default is 1.f
@property (nonatomic, assign) float defaultAlpha;

// when the primary view become highlight status, the primary alpha, default is 0.45f
@property (nonatomic, assign) float highlightAlpha;

// when bubble expand, the each button of space, default is 20px
@property (nonatomic, assign) float buttonSpacing;


/**
 init method, lifecycle

 @param frame frame
 @param direction expand direction
 @return object of HYYBubbleButton
 */
- (instancetype)initWithFrame:(CGRect)frame bubbleDirection:(BubbleDirection)direction;

// Public Methods
- (void)addButtons:(NSArray *)buttons;

- (void)addButton:(UIButton *)button;

- (void)showButtons;

- (void)dismissButtons;




@end
