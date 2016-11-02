//
//  PushBehaviorViewController.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/1.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "PushBehaviorViewController.h"

@interface PushBehaviorViewController ()
@property (weak, nonatomic) IBOutlet AppleView *pentagramView;

@end

@implementation PushBehaviorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // 重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.pentagramView]];
    gravityBehavior.gravityDirection = CGVectorMake(-1, 0);
    gravityBehavior.magnitude = 0.01;
    [self.dynamicAnimator addBehavior:gravityBehavior];
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.pentagramView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.dynamicAnimator addBehavior:collisionBehavior];
}
- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    
    // 推动行为
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.pentagramView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake([sender velocityInView:self.view].x /5000.f, 0);
    [self.dynamicAnimator addBehavior:pushBehavior];
    
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
