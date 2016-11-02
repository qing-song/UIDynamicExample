//
//  SnapViewController.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/1.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "SnapViewController.h"

@interface SnapViewController ()
{
    AppleView *pentagramView;
    int count;
}
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end

@implementation SnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    pentagramView = [[AppleView alloc] init];
    pentagramView.backgroundColor = [UIColor clearColor];
    pentagramView.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:pentagramView];

    [self.circleView setCircle];
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}


- (IBAction)dropPentagram:(UIButton *)sender {
    // 重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[pentagramView]];
    gravityBehavior.action = ^{
        count++;
        if (count == 50) {
            
            // 捕捉行为
            UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:pentagramView snapToPoint:CGPointMake(self.circleView.centerX + 25 + 25 *cos(M_PI / 3), self.circleView.centerY + 25 + 25 *cos(M_PI / 3))];
            // 阻尼系数-
            snapBehavior.damping = 0.1;
            [self.dynamicAnimator addBehavior:snapBehavior];
            sender.enabled = NO;
        }
        
    };
    [self.dynamicAnimator addBehavior:gravityBehavior];
    
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
