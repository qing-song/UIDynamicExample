//
//  BallView.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/2.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "BallView.h"

@implementation BallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
