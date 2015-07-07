#import "SUIViewSubviews.h"
#import "SUIViewSorting.h"
#import <SigmaticOC/SOCArrayExtension.h>


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
    return [SUIViewSorting sortViews:allResponders byPositionBasedOnView:self];
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