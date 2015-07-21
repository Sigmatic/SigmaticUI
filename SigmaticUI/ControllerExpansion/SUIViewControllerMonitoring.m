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


#import "SUIViewControllerMonitoring.h"
#import "SUIControlCenter.h"
#import "SUIControllerExtender.h"
#import "SOCMutableArrayExtension.h"
#import <objc/runtime.h>

@interface UIViewController (MonitoringPrivate)

@property(nonatomic) BOOL willAppearFirstTimeDone;
@property(nonatomic) BOOL didAppearFirstTimeDone;
@property(nonatomic) BOOL isVisibleToggle;
@property(nonatomic) NSMutableArray *extenders;

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
    [[SUIControlCenter defaultCenter] registerViewController:self];
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerViewDidLoad byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(viewDidLoad)]) {
            [extender viewDidLoad];
        }
    }
}

- (void)sui_viewWillAppear:(BOOL)animated {
    [self sui_viewWillAppear:animated];
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerViewWillAppear byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(viewWillAppear:)]) {
            [extender viewWillAppear:animated];
        }
    }
    if (![self willAppearFirstTimeDone]) {
        [self setWillAppearFirstTimeDone:YES];
        [self firstViewWillAppear:animated];
    }
}

- (void)sui_viewDidAppear:(BOOL)animated {
    [self sui_viewDidAppear:animated];
    [self setIsVisibleToggle:YES];
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerViewDidAppear byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(viewDidAppear:)]) {
            [extender viewDidAppear:animated];
        }
    }
    if (![self didAppearFirstTimeDone]) {
        [self setDidAppearFirstTimeDone:YES];
        [self firstViewDidAppear:animated];
    }
}

- (void)sui_viewWillDisappear:(BOOL)animated {
    [self sui_viewWillDisappear:animated];
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerViewWillDisappear byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(viewWillDisappear:)]) {
            [extender viewWillDisappear:animated];
        }
    }
}

- (void)sui_viewDidDisappear:(BOOL)animated {
    [self sui_viewDidDisappear:animated];
    [self setIsVisibleToggle:NO];
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerViewDidDisappear byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(viewDidDisappear:)]) {
            [extender viewDidDisappear:animated];
        }
    }
}

- (void)dealloc {
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(handleViewControllerWillDealloc)]) {
            [extender handleViewControllerWillDealloc];
        }
    }
    [[SUIControlCenter defaultCenter] removeViewController:self];
}

- (void)firstViewWillAppear:(BOOL)animated {
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerFirstViewWillAppear byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(firstViewWillAppear:)]) {
            [extender firstViewWillAppear:animated];
        }
    }
}

- (void)firstViewDidAppear:(BOOL)animated {
    [[SUIControlCenter defaultCenter] registerEvent:SUIViewControllerFirstViewDidAppear byViewController:self];
    for (id<SUIControllerExtender> extender in self.extenders) {
        if ([extender respondsToSelector:@selector(firstViewDidAppear:)]) {
            [extender firstViewDidAppear:animated];
        }
    }
}

- (BOOL)isVisible {
    return [self isVisibleToggle];
}

- (NSArray *)extendersList {
    return [[self extenders] copy];
}

- (void)addExtender:(id<SUIControllerExtender>)extender {
    if (extender == nil) {
        return;
    }
    NSMutableArray *extenders = self.extenders;
    if ([extenders containsObject:extender]) {
        return;
    }
    [extenders addObject:extender];
    [extender setHostViewController:self];
    [extender handleAddedToViewController];
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

- (NSMutableArray *)extenders {
    NSMutableArray *actualExtenders = objc_getAssociatedObject(self, @selector(extenders));
    if (actualExtenders == nil) {
        actualExtenders = [NSMutableArray new];
        [self setExtenders:actualExtenders];
    }
    return actualExtenders;
}

- (void)setExtenders:(NSMutableArray *)extenders {
    objc_setAssociatedObject(self, @selector(extenders), extenders, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end