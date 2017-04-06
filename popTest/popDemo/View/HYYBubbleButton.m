//
//  HYYBubbleButton.m
//  仿钉钉按钮
//
//  Created by Self_Improve on 17/3/8.
//  Copyright © 2017年 HYY. All rights reserved.
//

#import "HYYBubbleButton.h"

static CGFloat const kDefaultAnimationDuration = 0.25f;
static CGFloat const kDefaultAlpha = 1.f;
static CGFloat const kHighlightAlpha = 0.45f;
static CGFloat const kButtonSpace = 20.f;

@interface HYYBubbleButton ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) NSMutableArray *buttonContainer;

@property (nonatomic, assign) CGRect originFrame;

@end

@implementation HYYBubbleButton

#pragma mark -
#pragma mark Public Methods
- (void)addButtons:(NSArray *)buttons {
    assert(buttons != nil);
    for (UIButton *button in buttons) {
        [self addButton:button];
    }
    
    if (self.homeBubbleView != nil) {
        [self bringSubviewToFront:self.homeBubbleView];
    }
}

- (void)addButton:(UIButton *)button {
    assert(button);
    if (!_buttonContainer) {
        self.buttonContainer = [NSMutableArray array];
    }
    
    if ([_buttonContainer containsObject:button] == false) {
        [_buttonContainer addObject:button];
        [self addSubview:button];
        [button setHidden:YES];
    }
}

- (void)showButtons {
    [self _prepareForBubbleExpand];
    self.userInteractionEnabled = NO;
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];

    // setCompletionBlock need to write in the [CATransaction begin]
    [CATransaction setCompletionBlock:^{
        for (UIButton *button in _buttonContainer) {
            button.transform = CGAffineTransformIdentity;
        }
        self.userInteractionEnabled = YES;
    }];
    
    NSArray *buttonContainer = _buttonContainer;
    for (int i = 0; i < buttonContainer.count; i++) {
        UIButton *button = buttonContainer[i];
        button.hidden = NO;
        CGPoint originPosition = CGPointZero;
        CGPoint finalPosition = CGPointZero;
        switch (self.direction) {
            case BubbleDirectionUp:
            {
                originPosition = CGPointMake(self.frame.size.width / 2, self.frame.size.height - self.homeBubbleView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width / 2, button.frame.size.height / 2 + (button.frame.size.height + self.buttonSpacing) * i);
            }
                break;
                
            case BubbleDirectionDown:
            {
                originPosition = CGPointMake(self.frame.size.width / 2, self.homeBubbleView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width / 2,self.frame.size.height - ( button.frame.size.height / 2 + (button.frame.size.height + self.buttonSpacing) * i));
            }
                break;
                
            case BubbleDirectionLeft:
            {
                originPosition = CGPointMake(self.frame.size.width - self.homeBubbleView.frame.size.width, self.frame.size.height / 2);
                finalPosition = CGPointMake((button.frame.size.width / 2 + (button.frame.size.width + self.buttonSpacing) * i), self.frame.size.height / 2);
            }
                break;
                
            case BubbleDirectionRight:
            {
                originPosition = CGPointMake(self.homeBubbleView.frame.size.width, self.frame.size.height / 2);
                finalPosition = CGPointMake(self.frame.size.width - button.frame.size.width / 2 - (self.buttonSpacing + button.frame.size.width) * i, self.frame.size.height / 2);
            }
                break;
                
            default:
                break;
        }
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.f];
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.duration = _animationDuration;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        groupAnimation.fillMode = kCAFillModeForwards;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.animations = @[positionAnimation, scaleAnimation];
        // if you want each button show one by one, you need to set each button different beginTime
        groupAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)i) + 0.03f;
        [button.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
        button.layer.position = finalPosition;
        button.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
    [CATransaction commit];

    _isCollapsed = NO;
}

- (void)dismissButtons {
    self.userInteractionEnabled = NO;
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    [CATransaction setCompletionBlock:^{
        [self _finishCollapse];
        for (UIButton * button in _buttonContainer) {
            button.transform = CGAffineTransformIdentity;
            button.hidden = YES;
        }
        self.userInteractionEnabled = YES;
    }];
    for (int i = 0; i < _buttonContainer.count; i++) {
        UIButton *button = _buttonContainer[i];
        CGPoint originPosition = button.layer.position;
        CGPoint finalPosition = CGPointZero;
        switch (self.direction) {
            case BubbleDirectionUp:
            {
                finalPosition = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height - self.homeBubbleView.frame.size.height);
            }
                break;
                
            case BubbleDirectionDown:
            {
                finalPosition = CGPointMake(self.frame.size.width / 2.f, self.homeBubbleView.frame.size.height);
            }
                break;
                
            case BubbleDirectionLeft:
            {
                finalPosition = CGPointMake(self.frame.size.width - self.homeBubbleView.frame.size.width, self.frame.size.height / 2);
            }
                break;
                
            case BubbleDirectionRight:
            {
                finalPosition = CGPointMake(self.homeBubbleView.frame.size.width, self.frame.size.height / 2);
            }
                break;
                
            default:
                break;
        }
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.01f];
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.duration = _animationDuration;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        groupAnimation.fillMode = kCAFillModeForwards;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.animations = @[positionAnimation, scaleAnimation];
        // if you want each button show one by one, you need to set each button different beginTime
        groupAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)(_buttonContainer.count - i)) + 0.03f;
        [button.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
        button.layer.position = originPosition;
        button.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }
    [CATransaction commit];
    
    _isCollapsed = YES;
}

#pragma mark - 
#pragma mark Private Methods
- (void)_defaultInit {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    // set property default value
    self.direction = BubbleDirectionUp;
    self.animatedHighlighting = YES;
    self.collapseAfterSelection = YES;
    self.animationDuration = kDefaultAnimationDuration;
    self.defaultAlpha = kDefaultAlpha;
    self.highlightAlpha = kHighlightAlpha;
    self.buttonSpacing = kButtonSpace;
    self.originFrame = self.frame;
    _isCollapsed = YES;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGesture:)];
    
    // set cancelsTouchesInView = NO, when you click the button, the tapGestureRecognizer also can respond.
    self.tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:self.tapGestureRecognizer];
    self.tapGestureRecognizer.delegate = self;
}

// the method is used to collapes the bubble when you click the expansion button
- (void)_handleTapGesture:(UITapGestureRecognizer *)sender {
    if (self.tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [self.tapGestureRecognizer locationOfTouch:0 inView:self];
        
        // select button collapse the bubble, now status is expand, touchLoacation is not in primary view.
        if (_collapseAfterSelection && _isCollapsed == NO && CGRectContainsPoint(self.homeBubbleView.frame, touchLocation) == false ) {
            [self dismissButtons];
        }
    }
}

- (float)_expandBubbleWidth {
    float width = 0;
    for (UIButton *button in _buttonContainer) {
        width += button.frame.size.width + self.buttonSpacing;
    }
    return width;
}

- (float)_expandBubbleHeight {
    float height = 0;
    for (UIButton *button in _buttonContainer) {
        height += button.frame.size.height + self.buttonSpacing;
    }
    return height;
}

- (void)_prepareForBubbleExpand {
    float buttonHeight = [self _expandBubbleHeight];
    float buttonWidth = [self _expandBubbleWidth];
    switch (self.direction) {
        case BubbleDirectionUp:
        {
            self.homeBubbleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            CGRect frame = self.frame;
            frame.origin.y -= buttonHeight;
            frame.size.height += buttonHeight;
            self.frame = frame;
        }
            break;
            
        case BubbleDirectionDown:
        {
            self.homeBubbleView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            CGRect frame = self.frame;
            frame.size.height += buttonHeight;
            self.frame = frame;
        }
            break;
            
        case BubbleDirectionLeft:
        {
            self.homeBubbleView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            CGRect frame = self.frame;
            frame.origin.x -= buttonWidth;
            frame.size.width += buttonWidth;
            self.frame = frame;
        }
            break;
            
        case BubbleDirectionRight:
        {
            self.homeBubbleView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
            CGRect frame = self.frame;
            frame.size.width += buttonWidth;
            self.frame = frame;
        }
            break;
            
        default:
            break;
    }
}

- (void)_finishCollapse {
    self.frame = _originFrame;
}

- (void)_animatedWithBlock:(void (^)(void))animationBlock {
    [UIView transitionWithView:self duration:kDefaultAnimationDuration options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseInOut animations:animationBlock completion:NULL];
}

- (void)_setTouchHighted:(BOOL)highlighted {
    float alphaValue = highlighted ? _highlightAlpha : _defaultAlpha;
    if (self.homeBubbleView.alpha == alphaValue) return;

    if (_animatedHighlighting) {
        [self _animatedWithBlock:^{
            if (self.homeBubbleView != nil) {
                self.homeBubbleView.alpha = alphaValue;
            }
        }];
    } else {
        if (self.homeBubbleView != nil) {
            self.homeBubbleView.alpha = alphaValue;
        }
    }
}

- (UIView *)_subviewForPoint:(CGPoint)point {
    for (UIView *subview in self.subviews) {
        if (CGRectContainsPoint(subview.frame, point)) {
            return subview;
        }
    }
    return self;
}

#pragma mark -
#pragma mark Setter/Getter
- (void)setHomeBubbleView:(UIView *)homeBubbleView {
    if (_homeBubbleView != homeBubbleView) {
        _homeBubbleView = homeBubbleView;
    }
    
    if ([_homeBubbleView isDescendantOfView:self] == false) {
        [self addSubview:_homeBubbleView];
    }
}

- (NSArray *)buttons {
    return [_buttonContainer copy];
}

#pragma mark - 
#pragma mark Touch Handing Methods
//  touch the view, when you click the button, button will become the responder, not the view, if want collapse the view, you need to add a gesture to view, and you need to set button and gesture alse support the respond, you need to rewrite gesture delegate.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(self.homeBubbleView.frame, [touch locationInView:self])) {
        [self _setTouchHighted:YES];
    }
}

// the method is used to show or collapse the bubble when you click the primary view
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self _setTouchHighted:NO];
    if (CGRectContainsPoint(self.homeBubbleView.frame, [touch locationInView:self])) {
        if (_isCollapsed) {
            [self showButtons];
        } else {
            [self dismissButtons];
        }
    }
}

// when you canclled, view set highlight NO
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self _setTouchHighted:NO];
}

// when you moved, if you touch beyond the view, set view highlight NO
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self _setTouchHighted:CGRectContainsPoint(self.homeBubbleView.frame, [touch locationInView:self])];
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self];
    if ([self _subviewForPoint:touchLocation] != self && _collapseAfterSelection) {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _defaultInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame bubbleDirection:(BubbleDirection)direction {
    if (self = [super initWithFrame:frame]) {
        [self _defaultInit];
        _direction = direction;
    }
    return self;
}


@end
