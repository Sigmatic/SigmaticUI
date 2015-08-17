#import "SUINavigationControllerExtension.h"
#import "SOCArrayExtension.h"


@implementation UINavigationController (SUIExtension)

- (BOOL)isOnRootViewController {
    if (self.viewControllers.count == 0) {
        return NO;
    }
    return self.topViewController == [self.viewControllers firstObject];
}

- (void)removeNavigationBarHairline {
    [self.class removeHairlineFromNavigationBar:self.navigationBar];
}

+ (void)removeHairlineFromNavigationBar:(UINavigationBar *)navigationBar {
    UIImageView *hairlineView = [self findHairlineImageViewUnder:navigationBar];
    [hairlineView removeFromSuperview];
}

- (NSArray *)popToViewControllerWithClass:(Class)aClass animated:(BOOL)animated {
    NSArray *controllers = [self.viewControllers objectsWithClass:aClass];
    if (controllers.count == 0) {
        return nil;
    }
    return [self popToViewController:[controllers firstObject] animated:animated];
}


+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *) view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


@end