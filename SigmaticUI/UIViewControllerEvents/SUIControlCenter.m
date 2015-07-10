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


#import "SUIControlCenter.h"
#import "SUIControllerObserver.h"
#import "SUIControllerEventObservers.h"
#import "SOCMutableArrayExtension.h"
#import "SOCArrayExtension.h"


@interface SUIControlCenter ()
@property(nonatomic) NSMutableDictionary *eventObservers;
@property(nonatomic) NSMutableArray *allViewControllers;
@end

@implementation SUIControlCenter

+ (instancetype)defaultCenter {
    static SUIControlCenter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SUIControlCenter alloc] init];
        NSLog(@"%@ started...", NSStringFromClass(self.class));
    });
    return sharedInstance;
}

- (void)registerObserver:(id <SUIControllerObserver>)observer forEvents:(SUIViewControllerEvent)events byClass:(Class)viewControllerClass {
    NSLog(@"Adding %@ for event %zd for controllers of class %@", NSStringFromClass([observer class]),
            events, NSStringFromClass(viewControllerClass));
    NSArray *eventObservers = [self controllerEventObserversForEvents:events controllerClass:viewControllerClass];
    for (SUIControllerEventObservers *eventObserver in eventObservers) {
        [eventObserver addObserver:observer];
    }
}

- (NSArray *)viewControllersWithClass:(Class)aClass {
    return [self.allViewControllers objectsWithClass:aClass];
}

- (void)removeObserver:(id <SUIControllerObserver>)observer fromEvents:(SUIViewControllerEvent)events byClass:(Class)viewControllerClass {
    NSLog(@"Removing %@ from event %zd for controllers of class %@", NSStringFromClass([observer class]),
            events, NSStringFromClass(viewControllerClass));
    NSArray *eventObservers = [self controllerEventObserversForEvents:events controllerClass:viewControllerClass];
    for (SUIControllerEventObservers *eventObserver in eventObservers) {
        [eventObserver removeObserver:observer];
    }
}

- (NSArray *)controllerEventObserversForEvents:(SUIViewControllerEvent)events controllerClass:(Class)controllerClass {
    NSMutableArray *observers = [NSMutableArray new];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerViewDidLoad forClass:controllerClass inArray:observers];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerViewWillAppear forClass:controllerClass inArray:observers];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerFirstViewWillAppear forClass:controllerClass inArray:observers];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerViewDidAppear forClass:controllerClass inArray:observers];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerFirstViewDidAppear forClass:controllerClass inArray:observers];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerViewWillDisappear forClass:controllerClass inArray:observers];
    [self addObserversIfEvents:events includesEvent:SUIViewControllerViewDidDisappear forClass:controllerClass inArray:observers];
    return observers;
}

- (void)addObserversIfEvents:(SUIViewControllerEvent)events includesEvent:(SUIViewControllerEvent)event forClass:(Class)controllerClass inArray:(NSMutableArray *)observers {
    if (events & event) {
        [observers addObject:[self controllerEventObserverForEvent:event byClass:controllerClass]];
    }
}


- (void)removeObserver:(id <SUIControllerObserver>)observer {
    NSLog(@"Removing %@ from all events for all classes", NSStringFromClass([observer class]));
    for (NSNumber *eventNumber in self.eventObservers.allKeys) {
        SUIViewControllerEvent event = (SUIViewControllerEvent) eventNumber.integerValue;
        NSMutableDictionary *allObserversForEvent = [self allObserversForEvent:event];
        for (NSString *observersClasses in allObserversForEvent.allKeys) {
            SUIControllerEventObservers *observers = allObserversForEvent[observersClasses];
            [observers removeObserver:observer];
        }
    }
}

- (void)registerEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)viewController {
    [self notifyObserversOfClass:viewController.class viewController:viewController encounteredEvent:event];
    Class classSuperClass = viewController.superclass;
    while (classSuperClass != UIResponder.class) {
        [self notifyObserversOfClass:classSuperClass viewController:viewController encounteredEvent:event];
        classSuperClass = [classSuperClass superclass];
    }
}

- (void)registerViewController:(UIViewController *)viewController {
    [self.allViewControllers addObjectIfNew:viewController];
}

- (void)removeViewController:(UIViewController *)viewController {
    [self.allViewControllers removeObject:viewController];
}

- (void)notifyObserversOfClass:(Class)aClass viewController:(UIViewController *)controller encounteredEvent:(SUIViewControllerEvent)event {
    SUIControllerEventObservers *observers = [self controllerEventObserverForEvent:event byClass:aClass];
    for (id <SUIControllerObserver> observer in observers.observers) {
        [observer handleEvent:event byViewController:controller];
    }
}

#pragma mark - Get and Set

- (SUIControllerEventObservers *)controllerEventObserverForEvent:(SUIViewControllerEvent)event byClass:(Class)aClass {
    NSMutableDictionary *allEventObservers = [self allObserversForEvent:event];
    NSString *classString = NSStringFromClass(aClass);
    SUIControllerEventObservers *observers = allEventObservers[classString];
    if (observers == nil) {
        observers = [SUIControllerEventObservers newWithClass:aClass];
        allEventObservers[classString] = observers;
    }
    return observers;
}

- (NSMutableDictionary *)allObserversForEvent:(SUIViewControllerEvent)event {
    NSNumber *eventNumber = @(event);
    NSMutableDictionary *eventClassObservers = self.eventObservers[eventNumber];
    if (eventClassObservers == nil) {
        eventClassObservers = [NSMutableDictionary new];
        self.eventObservers[eventNumber] = eventClassObservers;
    }
    return eventClassObservers;
}

#pragma mark - Lazy

- (NSMutableDictionary *)eventObservers {
    if (!_eventObservers) {
        _eventObservers = [NSMutableDictionary new];
    }
    return _eventObservers;
}

- (NSMutableArray *)allViewControllers {
    if (!_allViewControllers) {
        _allViewControllers = [NSMutableArray new];
    }
    return _allViewControllers;
}

@end