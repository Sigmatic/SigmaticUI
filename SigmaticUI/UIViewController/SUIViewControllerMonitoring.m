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
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewWillAppear byViewController:self];
}

- (void)sui_viewDidAppear:(BOOL)animated {
    [self sui_viewDidAppear:animated];
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

@end