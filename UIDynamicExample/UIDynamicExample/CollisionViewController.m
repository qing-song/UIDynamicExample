//
//  CollisionViewController.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/1.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "CollisionViewController.h"

@interface CollisionViewController ()
<UICollisionBehaviorDelegate>
@property (weak, nonatomic) IBOutlet AppleView *pentagramView;
@property (weak, nonatomic) IBOutlet UILabel *touchBoundLabel;

@end

@implementation CollisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Collision";
    
    self.touchBoundLabel.layer.hidden = YES;
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // 重力行为
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.pentagramView]];
    // 1. 设置重力的方向（是一个角度）
    // 重力方向（是一个角度，以x轴正方向为0°，顺时针正数，逆时针负数）
    gravityBehaviour.angle = (M_PI_2);
    
    // 2. 设置重力的加速度，重力的加速度越大，碰撞就越厉害
    // 量级（用来控制加速度，1.0代表加速度是1000 points /second²）
    gravityBehaviour.magnitude = 0.5;

    [self.dynamicAnimator addBehavior:gravityBehaviour];
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.pentagramView]];
    // 让参照视图的边框成为碰撞检测的边界
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.dynamicAnimator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.pentagramView]];
    itemBehavior.elasticity = 0.6;
    [self.dynamicAnimator addBehavior:itemBehavior];
    collisionBehavior.collisionDelegate = self;

}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {

    [self touchBound];
}

- (void)touchBound {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"hidden"];
    [animation setToValue:[NSNumber numberWithBool:NO]];
    [animation setDuration:0.2];
    [animation setRemovedOnCompletion:YES];
    [self.touchBoundLabel.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
