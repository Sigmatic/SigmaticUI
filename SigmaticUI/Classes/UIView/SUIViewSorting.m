#import "SUIViewSorting.h"
#import "SUIViewFrame.h"

@implementation SUIViewSorting

+ (NSArray *)sortViews:(NSArray *)views byPositionBasedOnView:(UIView *)view {
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