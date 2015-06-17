#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Frame)
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

- (instancetype)alignLeft;

- (instancetype)alignLeft:(CGFloat)margin;

- (instancetype)alignTop;

- (instancetype)alignTop:(CGFloat)margin;

- (instancetype)alignRight;

- (instancetype)alignRight:(CGFloat)margin;

- (instancetype)alignBottom;

- (instancetype)alignBottom:(CGFloat)margin;

- (void)alignLeftOfView:(UIView *)siblingView;

- (void)alignLeftOfView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)alignAboveView:(UIView *)siblingView;

- (void)alignAboveView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)alignRightOfView:(UIView *)siblingView;

- (void)alignRightOfView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)alignBelowView:(UIView *)siblingView;

- (void)alignBelowView:(UIView *)siblingView margin:(CGFloat)margin;

- (instancetype)moveLeft:(CGFloat)points;

- (instancetype)moveUp:(CGFloat)points;

- (instancetype)moveRight:(CGFloat)points;

- (instancetype)moveDown:(CGFloat)points;

- (void)centerInSuperview;

- (void)centerHorizontally;

- (void)centerVertically;

- (void)scale:(CGFloat)scale;
@end