#import "SUIViewControllerMonitoring.h"
#import "SUIControllerEventManager.h"
#import <objc/runtime.h>

@interface UIViewController (MonitoringPrivate)

@property(nonatomic) BOOL willAppearFirstTimeDone;
@property(nonatomic) BOOL didAppearFirstTimeDone;
@property(nonatomic) BOOL isVisibleToggle;

@end

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
    if (![self willAppearFirstTimeDone]) {
        [self setWillAppearFirstTimeDone:YES];
        [self firstViewWillAppear:animated];
    }
}

- (void)sui_viewDidAppear:(BOOL)animated {
    [self sui_viewDidAppear:animated];
    [self setIsVisibleToggle:YES];
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewDidAppear byViewController:self];
    if (![self didAppearFirstTimeDone]) {
        [self setDidAppearFirstTimeDone:YES];
        [self firstViewDidAppear:animated];
    }
}

- (void)sui_viewWillDisappear:(BOOL)animated {
    [self sui_viewWillDisappear:animated];
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewWillDisappear byViewController:self];
}

- (void)sui_viewDidDisappear:(BOOL)animated {
    [self sui_viewDidDisappear:animated];
    [self setIsVisibleToggle:NO];
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerViewDidDisappear byViewController:self];
}

- (void)firstViewWillAppear:(BOOL)animated {
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerFirstViewWillAppear byViewController:self];
}

- (void)firstViewDidAppear:(BOOL)animated {
    [[SUIControllerEventManager sharedInstance] registerEvent:SUIViewControllerFirstViewDidAppear byViewController:self];
}

- (BOOL)isVisible {
    return [self isVisibleToggle];
}


#pragma mark - Get Set appear property

- (BOOL)willAppearFirstTimeDone {
    NSNumber *value = objc_getAssociatedObject(self, @selector(willAppearFirstTimeDone));
    return value.boolValue;
}

- (void)setWillAppearFirstTimeDone:(BOOL)willAppearFirstTimeDone {
    objc_setAssociatedObject(self, @selector(willAppearFirstTimeDone), @(willAppearFirstTimeDone), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)didAppearFirstTimeDone {
    NSNumber *value = objc_getAssociatedObject(self, @selector(didAppearFirstTimeDone));
    return value.boolValue;
}

- (void)setDidAppearFirstTimeDone:(BOOL)didAppearFirstTimeDone {
    objc_setAssociatedObject(self, @selector(didAppearFirstTimeDone), @(didAppearFirstTimeDone), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isVisibleToggle {
    NSNumber *value = objc_getAssociatedObject(self, @selector(isVisibleToggle));
    return value.boolValue;
}

- (void)setIsVisibleToggle:(BOOL)isVisibleToggle {
    objc_setAssociatedObject(self, @selector(isVisibleToggle), @(isVisibleToggle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end