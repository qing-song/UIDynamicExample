//
//  AppleView.m
//  UIDynamicExample
//
//  Created by qingsong on 16/11/1.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import "AppleView.h"

#define degree_TH M_PI/180

@interface AppleView ()

@property (nonatomic, assign) NSInteger radius;

@end

@implementation AppleView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.radius = 30;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.radius = 30;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    
    CGFloat r0 = self.radius * sin(18 * degree_TH) / cos(36 * degree_TH);
    CGFloat x1[5] = {0}, y1[5] = {0}, x2[5] = {0}, y2[5] = {0};
    
    for (int64_t i = 0; i < 5; i++) {
        x1[i] = centerX + self.radius * cos((90 + i * 72) * degree_TH);
        y1[i] = centerY - self.radius * sin((90 + i * 72) * degree_TH);
        
        x2[i] = centerX + r0 * cos((54 + i * 72) * degree_TH);
        y2[i] = centerY - r0 * sin((54 + i * 72) * degree_TH);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef startPath = CGPathCreateMutable();
    CGPathMoveToPoint(startPath, NULL, x1[0], y1[0]);
    
    for (int i = 1; i < 5; i++) {
        
        CGPathAddLineToPoint(startPath, NULL, x2[i], y2[i]);
        CGPathAddLineToPoint(startPath, NULL, x1[i], y1[i]);
    }
    
    CGPathAddLineToPoint(startPath, NULL, x2[0], y2[0]);
    CGPathCloseSubpath(startPath);
    
    CGContextAddPath(context, startPath);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
    
    CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1]) * 1, y1[2]);
    
    CGContextAddPath(context, startPath);
    CGContextClip(context);
    CGContextFillRect(context, range);
    
    CFRelease(startPath);
}


@end
