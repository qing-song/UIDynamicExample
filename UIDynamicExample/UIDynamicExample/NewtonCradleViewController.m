//
//  NewtonCradleViewController.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/2.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "NewtonCradleViewController.h"
#import "NewtonCradleView.h"

@interface NewtonCradleViewController ()

@end

@implementation NewtonCradleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NewtonCradleView *newtonCradleView = [[NewtonCradleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    [self.view addSubview:newtonCradleView];
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
