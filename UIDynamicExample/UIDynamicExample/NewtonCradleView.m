//
//  NewtonCradleView.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/2.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "NewtonCradleView.h"
#import "BallView.h"

@interface NewtonCradleView ()
{
    //球的个数
    NSUInteger ballCount;
    //球和锚点
    NSArray *_balls;
    NSMutableArray *_anchors;
    UIDynamicAnimator *_animator;
    UIPushBehavior *pushBehavior;
}
@end

@implementation NewtonCradleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        ballCount = 5;
        
        [self createBallAndAnchors];
        
        [self applyDynamicBehaviors];
    }
    return self;
}

- (void)createBallAndAnchors {
    
    NSMutableArray *ballsArray = @[].mutableCopy;
    NSMutableArray *anchorsArray = @[].mutableCopy;
    CGFloat ballSize = CGRectGetWidth(self.bounds)/(3.0*(ballCount-1));
    
    for (NSInteger i = 0; i < ballCount; i++) {
        BallView * ball = [[BallView alloc] initWithFrame:CGRectMake(0, 0, ballSize, ballSize)];
        CGFloat x = CGRectGetWidth(self.bounds) / 3 + i * ballSize;
        CGFloat y = CGRectGetHeight(self.bounds)/1.5;
        ball.center = CGPointMake(x, y);
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBallPan:)];
        [ball addGestureRecognizer:panGesture];
        [ball addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:Nil];
        [ballsArray addObject:ball];
        [ball setCircle];
        [self addSubview:ball];
        
        UIView *blueBox = [self createAnchorForBall:ball];
        [anchorsArray addObject:blueBox];
        [self addSubview:blueBox];
    }
    
    _balls = ballsArray;
    _anchors = anchorsArray;
}

- (UIView *)createAnchorForBall:(BallView *)ball
{
    CGPoint anchor = ball.center;
    //根据球的位置确定描点的位置
    anchor.y -= CGRectGetHeight(self.bounds) / 4.0;
    UIView *blueBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    blueBox.backgroundColor = [UIColor redColor];
    blueBox.center = anchor;
    [blueBox setCircle];
    return blueBox;
}

- (void)applyDynamicBehaviors {
    
    UIDynamicBehavior *behavior = [[UIDynamicBehavior alloc] init];
    
    // 为每个球到对应的锚点添加一个ArrahmentBehavior
    for (int i = 0; i < ballCount; i++) {
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:_balls[i] attachedToAnchor:[_anchors[i] center]];
        [behavior addChildBehavior:attachment];
    }
    
    // 重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:_balls];
    gravity.magnitude = 1;
    [behavior addChildBehavior:gravity];
    
    // 碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:_balls];
    [behavior addChildBehavior:collision];
    
    // 为所有的球的动力行为做一个公有配置，像空气阻力，摩擦力，弹性密度等
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:_balls];
    
    itemBehavior.elasticity = 1.0;
    itemBehavior.allowsRotation = NO;
    itemBehavior.resistance = 1.f;
    [behavior addChildBehavior:itemBehavior];
    
    UIDynamicAnimator *dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self];

    [dynamicAnimator addBehavior:behavior];
    
    _animator = dynamicAnimator;
}

- (void)handleBallPan:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if (pushBehavior) {
            [_animator removeBehavior:pushBehavior];
        }
        pushBehavior = [[UIPushBehavior alloc] initWithItems:@[sender.view] mode:UIPushBehaviorModeContinuous];
        [_animator addBehavior:pushBehavior];
    }
    
    pushBehavior.pushDirection = CGVectorMake([sender translationInView:self].x / 10.f, 0);
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [_animator removeBehavior:pushBehavior];
        pushBehavior = nil;
    }
}

#pragma mark - Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Observer方法，当ball的center属性发生变化时，刷新整个view
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (BallView *ball in _balls) {
        
        CGPoint anchor = [[_anchors objectAtIndex:[_balls indexOfObject:ball]] center];
        CGPoint ballCenter = [ball center];
        
        CGContextMoveToPoint(context, anchor.x, anchor.y);
        CGContextAddLineToPoint(context, ballCenter.x, ballCenter.y);
        CGContextSetLineWidth(context, 1.0f);
        [[UIColor blackColor] setStroke];
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

-(void)dealloc
{
    for (BallView *ball in _balls) {
        [ball removeObserver:self forKeyPath:@"center"];
    }
}

@end
