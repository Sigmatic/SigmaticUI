// Copyright (c) 2015 Sigmatic
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


#import "SUIViewFrame.h"

@implementation UIView (SUIFrame)

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

- (void)alignLeft {
    [self alignLeft:0];
}

- (void)alignLeft:(CGFloat)margin {
    self.x = margin;
}

- (void)alignTop {
    [self alignTop:0];
}

- (void)alignTop:(CGFloat)margin {
    self.y = margin;
}

- (void)alignRight {
    [self alignRight:0];
}

- (void)alignRight:(CGFloat)margin {
    if (self.superview == nil) {
        return;
    }
    CGFloat superviewWidth = self.superview.width;
    self.x = superviewWidth - self.width - margin;
}

- (void)alignBottom {
    [self alignBottom:0];
}

- (void)alignBottom:(CGFloat)margin {
    if (self.superview == nil) {
        return;
    }
    CGFloat superviewHeight = self.superview.height;
    self.y = superviewHeight - self.height - margin;
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

- (void)moveLeft:(CGFloat)points {
    self.x = self.x - points;
}

- (void)moveUp:(CGFloat)points {
    self.y = self.y - points;
}

- (void)moveRight:(CGFloat)points {
    self.x = self.x + points;
}

- (void)moveDown:(CGFloat)points {
    self.y = self.y + points;
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
    if (scale <= 0) {
        NSLog(@"Warning: scaling to zero or below. Using abosolute value");
        scale = fabs(scale);
    }
    CGPoint currentCenter = self.center;
    self.width = self.width * scale;
    self.height = self.height * scale;
    self.center = currentCenter;
}

@end