#import "SUIViewSorting.h"
#import "SUIViewFrame.h"

@implementation SUIViewSorting

+ (NSArray *)sortViews:(NSArray *)views byPositionBasedOnView:(UIView *)view {
    //TODO: sorting still not 100%
    NSComparator comparatorBlock = ^(UIView *obj1, UIView *obj2) {
        if (obj1.x == obj2.x && obj1.y == obj2.y) {
            return NSOrderedSame;
        }
        if ([SUIViewSorting isView:obj1 beforeView:obj2 basedOnView:view]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    };
    NSMutableArray *mutableViews = [views mutableCopy];
    [mutableViews sortUsingComparator:comparatorBlock];
    return [mutableViews copy];
}

+ (BOOL)isView:(UIView *)firstView beforeView:(UIView *)secondView basedOnView:(UIView *)superview {
    CGRect firstFrame = [superview convertRect:firstView.frame fromView:firstView.superview];
    CGRect secondFrame = [superview convertRect:secondView.frame fromView:secondView.superview];
    if (firstFrame.origin.y <= secondFrame.origin.y) {
        return YES;
    }
    return firstFrame.origin.x <= secondFrame.origin.x;
}

@end