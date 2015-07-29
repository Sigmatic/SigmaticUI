#import "SUICenterControllerHolder.h"


@implementation SUICenterControllerHolder

+ (instancetype)newWithController:(UIViewController *)controller {
    SUICenterControllerHolder *holder = [self new];
    [holder setViewController:controller];
    return holder;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }

    if (!other || ![[other class] isEqual:[self class]]) {
        return NO;
    }
    SUICenterControllerHolder *otherHolder = other;
    return otherHolder.viewController == self.viewController;
}


@end