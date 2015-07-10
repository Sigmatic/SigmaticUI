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


#import "SUIViewSorting.h"
#import "SUIViewFrame.h"

@implementation SUIViewSorting

+ (NSArray *)sortViews:(NSArray *)views {
    NSComparator comparatorBlock = ^(UIView *obj1, UIView *obj2) {
        if (obj1.x == obj2.x && obj1.y == obj2.y) {
            return NSOrderedSame;
        }
        if ([SUIViewSorting isView:obj1 beforeView:obj2]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    };
    NSMutableArray *mutableViews = [views mutableCopy];
    [mutableViews sortUsingComparator:comparatorBlock];
    return [mutableViews copy];
}

+ (BOOL)isView:(UIView *)firstView beforeView:(UIView *)secondView {
    CGRect firstFrame = [firstView.superview convertRect:firstView.frame toView:nil];
    CGRect secondFrame = [secondView.superview convertRect:secondView.frame toView:nil];
    if (firstFrame.origin.y < secondFrame.origin.y) {
        return YES;
    }
    return firstFrame.origin.x < secondFrame.origin.x;
}

@end