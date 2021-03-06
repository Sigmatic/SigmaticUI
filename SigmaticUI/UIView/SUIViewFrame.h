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


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (SUIFrame)

///---------------------
/// @name Frame Access
///---------------------

/**
The X origin point from view.frame.origin.x.
*/
@property(nonatomic) CGFloat x;

/**
The Y origin point from view.frame.origin.y.
*/
@property(nonatomic) CGFloat y;

/**
The width of the frame from view.frame.size.width.
*/
@property(nonatomic) CGFloat width;

/**
The height of the frame from view.frame.size.height.
*/
@property(nonatomic) CGFloat height;

///---------------------
/// @name Resizing
///---------------------

/**
Resizing the view to be wider (or less if in minus).
@param extraWidth the amount of extra width to add to the view.
*/
- (void)expandWidth:(CGFloat)extraWidth;

/**
Resizing the view to be taller (or less if in minus).
@param extraHeight the amount of extra height to add to the view.
*/
- (void)expandHeight:(CGFloat)extraHeight;

/**
Resize the view to be the same size as the superview.
*/
- (void)stretchToFillSuperview;

/**
Resize the view to have a consistent margin between its sides and the superview.
@param margin the space between the sides of the view and the sides of the superview.
*/
- (void)stretchToFillSuperview:(CGFloat)margin;

/**
Stretch the view to the left of its superview.
*/
- (void)stretchToLeft;

/**
Stretch the view to the left of its superview with a margin.
@param margin the space between the left of the view and the left of the superview.
*/
- (void)stretchToLeft:(CGFloat)margin;

/**
Stretch the view to the top of its superview.
*/
- (void)stretchToTop;

/**
Stretch the view to the top of its superview with a margin.
@param margin the space between the top of the view and the top of the superview.
*/
- (void)stretchToTop:(CGFloat)margin;

/**
Stretch the view to the right of its superview.
*/
- (void)stretchToRight;

/**
Stretch the view to the right of its superview with a margin.
@param margin the space between the right of the view and the right of the superview.
*/
- (void)stretchToRight:(CGFloat)margin;

/**
Stretch the view to the bottom of its superview.
*/
- (void)stretchToBottom;

/**
Stretch the view to the bottom of its superview with a margin.
@param margin the space between the bottom of the view and the bottom of the superview.
*/
- (void)stretchToBottom:(CGFloat)margin;

///---------------------
/// @name Alignment
///---------------------

/**
Align left in superview.
*/
- (void)alignLeft;

/**
Align left in superview with margin.
@param margin Margin between the superview and the left hand side of the view.
*/
- (void)alignLeft:(CGFloat)margin;

/**
Space between the left of view and left of the superview.
*/
- (CGFloat)marginToLeft;

/**
Align top in superview.
*/
- (void)alignTop;

/**
Align top in superview with margin.
@param margin Margin between the superview and the top the view.
*/
- (void)alignTop:(CGFloat)margin;

/**
Space between the top of view and top of the superview.
*/
- (CGFloat)marginToTop;

/**
Align right in superview.
*/
- (void)alignRight;

/**
Align right in superview with margin.
@param margin Margin between the superview and the right hand side of the view.
*/
- (void)alignRight:(CGFloat)margin;

/**
Space between the right of view and right of the superview.
*/
- (CGFloat)marginToRight;

/**
Align bottom in superview.
*/
- (void)alignBottom;

/**
Align bottom in superview with margin.
@param margin Margin between the superview and the bottom the view.
*/
- (void)alignBottom:(CGFloat)margin;

/**
Space between the bottom of view and bottom of the superview.
*/
- (CGFloat)marginToBottom;

///---------------------
/// @name Alignment with View
///---------------------

/**
Align to the left in respective of a sibling view.
@param siblingView The sibling view aligning view on the left of.
*/
- (void)alignLeftOfView:(UIView *)siblingView;

/**
Align to the left in respective of a sibling view with a margin.
@param siblingView The sibling view aligning view on the left of.
@param margin Margin between the left side of the sibling view and the right side of the view.
*/
- (void)alignLeftOfView:(UIView *)siblingView margin:(CGFloat)margin;

/**
Align above a sibling view.
@param siblingView The sibling view aligning view on top of.
*/
- (void)alignAboveView:(UIView *)siblingView;

/**
Align above a sibling view with a margin.
@param siblingView The sibling view aligning view on top of.
@param margin Margin between the top of the sibling view and the bottom of the view.
*/
- (void)alignAboveView:(UIView *)siblingView margin:(CGFloat)margin;

/**
Align to the right in respective of a sibling view.
@param siblingView The sibling view aligning view on the right of.
*/
- (void)alignRightOfView:(UIView *)siblingView;

/**
Align to the left in respective of a sibling view with a margin.
@param siblingView The sibling view aligning view on the right of.
@param margin Margin between the right side of the sibling view and the left side of the view.
*/
- (void)alignRightOfView:(UIView *)siblingView margin:(CGFloat)margin;

/**
Align below a sibling view.
@param siblingView The sibling view aligning the view below.
*/
- (void)alignBelowView:(UIView *)siblingView;

/**
Align below a sibling view with a margin.
@param siblingView The sibling view aligning the view below.
@param margin Margin between the bottom of the sibling view and the top of the view.
*/
- (void)alignBelowView:(UIView *)siblingView margin:(CGFloat)margin;

///---------------------
/// @name Moving
///---------------------

/**
Move to the left.
@param points The number of points to move.
*/
- (void)moveLeft:(CGFloat)points;

/**
Move up.
@param points The number of points to move.
*/
- (void)moveUp:(CGFloat)points;

/**
Move to the right.
@param points The number of points to move.
*/
- (void)moveRight:(CGFloat)points;

/**
Move down.
@param points The number of points to move.
*/
- (void)moveDown:(CGFloat)points;

///---------------------
/// @name Centering
///---------------------

/**
Center horizontally and vertically in superview.
*/
- (void)centerInSuperview;

/**
Center horizontally in superview.
*/
- (void)centerHorizontally;

/**
Center vertically in superview.
*/
- (void)centerVertically;

///---------------------
/// @name Scaling
///---------------------

/**
Scale view. Retains view center position.
@param scale The scaling factor. 2.0f doubles the frame size.
*/
- (void)scale:(CGFloat)scale;

@end