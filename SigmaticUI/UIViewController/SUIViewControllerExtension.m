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

#import "SUIViewControllerExtension.h"
#import <objc/runtime.h>

@interface UIViewController (ExtensionPrivate)

@property(nonatomic) BOOL willAppearFirstTimeDone;
@property(nonatomic) BOOL didAppearFirstTimeDone;
@property(nonatomic) BOOL isVisibleToggle;

@end


@implementation UIViewController (SUIExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        [self swizzleSelectorInClass:class originalSelector:@selector(viewWillAppear:)
                    swizzledSelector:@selector(sui_viewWillAppear:)];
        [self swizzleSelectorInClass:class originalSelector:@selector(viewDidAppear:)
                    swizzledSelector:@selector(sui_viewDidAppear:)];
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

- (void)sui_viewWillAppear:(BOOL)animated {
    [self sui_viewWillAppear:animated];
    if (![self willAppearFirstTimeDone]) {
        [self setWillAppearFirstTimeDone:YES];
        [self firstViewWillAppear:animated];
    }
}

- (void)sui_viewDidAppear:(BOOL)animated {
    [self sui_viewDidAppear:animated];
    [self setIsVisibleToggle:YES];
    if (![self didAppearFirstTimeDone]) {
        [self setDidAppearFirstTimeDone:YES];
        [self firstViewDidAppear:animated];
    }
}

- (void)sui_viewDidDisappear:(BOOL)animated {
    [self sui_viewDidDisappear:animated];
    [self setIsVisibleToggle:NO];
}

- (void)firstViewWillAppear:(BOOL)animated {
    //Nothing to do
}

- (void)firstViewDidAppear:(BOOL)animated {
    //Nothing to do
}

- (BOOL)isVisible {
    return [self isVisibleToggle];
}

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