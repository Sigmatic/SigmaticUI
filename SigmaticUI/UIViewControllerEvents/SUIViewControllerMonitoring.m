#import "SUIViewControllerMonitoring.h"
#import "SUIControllerEventManager.h"
#import <objc/runtime.h>

@implementation UIViewController (Monitoring)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        [self swizzleSelectorInClass:class originalSelector:@selector(viewDidLoad)
                    swizzledSelector:@selector(sui_viewDidLoad)];
        [self swizzleSelectorInClass:class originalSelector:@selector(viewWillAppear:)
                    swizzledSelector:@selector(sui_viewWillAppear:)];
        [self swizzleSelectorInClass:class originalSelector:@selector(viewDidAppear:)
                    swizzledSelector:@selector(sui_viewDidAppear:)];
        [self swizzleSelectorInClass:class originalSelector:@selector(viewWillDisappear:)
                    swizzledSelector:@selector(sui_viewWillDisappear:)];
        [self swizzleSelectorInClass:class originalSelector:@selector(viewDidDisappear:)
                    swizzledSelector:@selector(sui_viewDidDisappear:)];

    });
}

+ (void)swizzleSelectorInClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class, originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)sui_viewDidLoad {
    [self sui_viewDidLoad];
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewDidLoad byViewController:self];
}

- (void)sui_viewWillAppear:(BOOL)animated {
    [self sui_viewWillAppear:animated];
    if (![self didWillAppearFirstTime]) {
        [self setDidWillAppearFirstTime:YES];
        [self firstViewWillAppear:animated];
    }
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewWillAppear byViewController:self];
}

- (void)sui_viewDidAppear:(BOOL)animated {
    [self sui_viewDidAppear:animated];
    if (![self didDidAppearFirstTime]) {
        [self setDidDidAppearFirstTime:YES];
        [self firstViewDidAppear:animated];
    }
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewDidAppear byViewController:self];
}

- (void)sui_viewWillDisappear:(BOOL)animated {
    [self sui_viewWillDisappear:animated];
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewWillDisappear byViewController:self];
}

- (void)sui_viewDidDisappear:(BOOL)animated {
    [self sui_viewDidDisappear:animated];
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewDidDisappear byViewController:self];
}

- (void)firstViewWillAppear:(BOOL)animated {
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerFirstViewWillAppear byViewController:self];
}

- (void)firstViewDidAppear:(BOOL)animated {
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerFirstViewDidAppear byViewController:self];
}

#pragma mark - Get Set appear property

- (BOOL)didWillAppearFirstTime {
    NSNumber *value = objc_getAssociatedObject(self, @selector(didWillAppearFirstTime));
    return value.boolValue;
}

- (void)setDidWillAppearFirstTime:(BOOL)didWillAppearFirstTime {
    objc_setAssociatedObject(self, @selector(didWillAppearFirstTime), @(didWillAppearFirstTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)didDidAppearFirstTime {
    NSNumber *value = objc_getAssociatedObject(self, @selector(didDidAppearFirstTime));
    return value.boolValue;
}

- (void)setDidDidAppearFirstTime:(BOOL)didDidAppearFirstTime {
    objc_setAssociatedObject(self, @selector(didDidAppearFirstTime), @(didDidAppearFirstTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end