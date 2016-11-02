//
//  AttachmentViewController.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/1.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()
@property (weak, nonatomic) IBOutlet AppleView *pentagramView;

@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@end

@implementation AttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.pentagramView]];
    gravityBehavior.magnitude = 1;
    [self.dynamicAnimator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.pentagramView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.dynamicAnimator addBehavior:collisionBehavior];
    
}
- (IBAction)handleAttachmentTapGesture:(UIPanGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint center = CGPointMake(self.pentagramView.centerX, self.pentagramView.centerY + 20);

            // 附着行为
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.pentagramView attachedToAnchor:center];
            // 1. 距离 与锚点的距离
            attachment.length = 50;
            // 2. 跳跃度
            attachment.damping = 1;
            // 3. in Hertz   幅度
            attachment.frequency = 1;
            self.attachmentBehavior = attachment;
            [self.dynamicAnimator addBehavior:attachment];
        }
            break;
         case UIGestureRecognizerStateChanged:
        {
            [self.attachmentBehavior setAnchorPoint:[sender locationInView:self.view]];
        }
            break;
            case UIGestureRecognizerStateEnded:
        {
            [self.dynamicAnimator removeBehavior:self.attachmentBehavior];
        }
            break;
        default:
            break;
    }
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
