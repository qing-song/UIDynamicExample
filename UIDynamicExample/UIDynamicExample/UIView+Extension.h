#import <UIKit/UIKit.h>

@interface UIView (Circle)
/**
 *  设置圆形
 */
- (void)setCircle;

/**
 *  设置圆角
 *
 *  @param width 角度大小
 */
- (void)setCircleWithWidth:(CGFloat)width;

- (void)setCorner;

- (void)setCornerWithRadius:(CGFloat)width;

- (void)setBorderColor;

@end

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@end
