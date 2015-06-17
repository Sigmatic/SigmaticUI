#import "SUIViewFrame.h"

@implementation UIView (Frame)

#pragma mark - Get Set Frame

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect myFrame = self.frame;
    myFrame.origin.x = x;
    self.frame = myFrame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect myFrame = self.frame;
    myFrame.origin.y = y;
    self.frame = myFrame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect myFrame = self.frame;
    myFrame.size.width = width;
    self.frame = myFrame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect myFrame = self.frame;
    myFrame.size.height = height;
    self.frame = myFrame;
}

#pragma mark - Align

- (instancetype)alignLeft {
    return [self alignLeft:0];
}

- (instancetype)alignLeft:(CGFloat)margin {
    self.x = margin;
    return self;
}

- (instancetype)alignTop {
    return [self alignTop:0];
}

- (instancetype)alignTop:(CGFloat)margin {
    self.y = margin;
    return self;
}

- (instancetype)alignRight {
    return [self alignRight:0];
}

- (instancetype)alignRight:(CGFloat)margin {
    if (self.superview == nil) {
        return self;
    }
    CGFloat superviewWidth = self.superview.width;
    self.x = superviewWidth - self.width - margin;
    return self;
}

- (instancetype)alignBottom {
    return [self alignBottom:0];
}

- (instancetype)alignBottom:(CGFloat)margin {
    if (self.superview == nil) {
        return self;
    }
    CGFloat superviewHeight = self.superview.height;
    self.y = superviewHeight - self.height - margin;
    return self;
}

#pragma mark - Align In Respect to View

- (void)alignLeftOfView:(UIView *)siblingView {
    [self alignLeftOfView:siblingView margin:0];
}

- (void)alignLeftOfView:(UIView *)siblingView margin:(CGFloat)margin {
    CGFloat newX = siblingView.x - self.width - margin;
    self.x = newX;
}

- (void)alignAboveView:(UIView *)siblingView {
    [self alignAboveView:siblingView margin:0];
}

- (void)alignAboveView:(UIView *)siblingView margin:(CGFloat)margin {
    CGFloat newY = siblingView.y - self.height - margin;
    self.y = newY;
}

- (void)alignRightOfView:(UIView *)siblingView {
    [self alignRightOfView:siblingView margin:0];
}

- (void)alignRightOfView:(UIView *)siblingView margin:(CGFloat)margin {
    CGFloat newX = siblingView.x + siblingView.width + margin;
    self.x = newX;
}

- (void)alignBelowView:(UIView *)siblingView {
    [self alignBelowView:siblingView margin:0];
}

- (void)alignBelowView:(UIView *)siblingView margin:(CGFloat)margin {
    CGFloat newY = siblingView.y + siblingView.height + margin;
    self.y = newY;
}

#pragma mark - Move

- (instancetype)moveLeft:(CGFloat)points {
    self.x = self.x - points;
    return self;
}

- (instancetype)moveUp:(CGFloat)points {
    self.y = self.y - points;
    return self;
}

- (instancetype)moveRight:(CGFloat)points {
    self.x = self.x + points;
    return self;
}

- (instancetype)moveDown:(CGFloat)points {
    self.y = self.y + points;
    return self;
}

#pragma mark - Center

- (void)centerInSuperview {
    [self centerHorizontally];
    [self centerVertically];
}

- (void)centerHorizontally {
    if (self.superview == nil) {
        return;
    }
    self.center = CGPointMake(self.superview.width / 2, self.center.y);
}

- (void)centerVertically {
    if (self.superview == nil) {
        return;
    }
    self.center = CGPointMake(self.center.x, self.superview.height / 2);
}

#pragma mark - Expand and Scale

- (void)scale:(CGFloat)scale {
    CGPoint currentCenter = self.center;
    self.width = self.width * scale;
    self.height = self.height * scale;
    self.center = currentCenter;
}

@end