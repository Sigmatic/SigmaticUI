#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Frame)
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

- (void)alignLeft;

- (void)alignLeft:(CGFloat)margin;

- (void)alignTop;

- (void)alignTop:(CGFloat)margin;

- (void)alignRight;

- (void)alignRight:(CGFloat)margin;

- (void)alignBottom;

- (void)alignBottom:(CGFloat)margin;

- (void)alignLeftOfView:(UIView *)siblingView;

- (void)alignLeftOfView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)alignAboveView:(UIView *)siblingView;

- (void)alignAboveView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)alignRightOfView:(UIView *)siblingView;

- (void)alignRightOfView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)alignBelowView:(UIView *)siblingView;

- (void)alignBelowView:(UIView *)siblingView margin:(CGFloat)margin;

- (void)moveLeft:(CGFloat)points;

- (void)moveUp:(CGFloat)points;

- (void)moveRight:(CGFloat)points;

- (void)moveDown:(CGFloat)points;

- (void)centerInSuperview;

- (void)centerHorizontally;

- (void)centerVertically;

- (void)scale:(CGFloat)scale;
@end