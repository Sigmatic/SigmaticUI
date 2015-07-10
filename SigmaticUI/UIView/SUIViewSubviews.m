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


#import <SigmaticOC/SOCArrayExtension.h>
#import "SUIViewSubviews.h"
#import "SUIViewSorting.h"


@implementation UIView (SUISubviews)

- (void)removeAllSubviews {
    for (UIView *view in [self.subviews copy]) {
        [view removeFromSuperview];
    }
}

- (NSArray *)subviewsWithClass:(Class)aClass {
    NSMutableArray *results = [NSMutableArray new];
    NSArray *subviewsWithClass = [self.subviews objectsWithClass:aClass];
    [results addObjectsFromArray:subviewsWithClass];
    for (UIView *subview in self.subviews) {
        NSArray *subSubviews = [subview subviewsWithClass:aClass];
        [results addObjectsFromArray:subSubviews];
    }
    return [results copy];
}

- (NSArray *)textInputSubviews {
    NSArray *textFields = [self subviewsWithClass:[UITextField class]];
    NSArray *respondingTextFields = [self filterRespondingViews:textFields];

    NSArray *textViews = [self subviewsWithClass:[UITextView class]];
    NSArray *respondingTextViews = [self filterRespondingViews:textViews];

    NSArray *allResponders = [respondingTextFields arrayByAddingObjectsFromArray:respondingTextViews];
    return [SUIViewSorting sortViews:allResponders];
}

- (NSArray *)filterRespondingViews:(NSArray *)responders {
    NSMutableArray *results = [NSMutableArray new];
    for (UIResponder *responder in responders) {
        if ([responder canBecomeFirstResponder]) {
            [results addObject:responder];
        }
    }
    return [results copy];
}

@end