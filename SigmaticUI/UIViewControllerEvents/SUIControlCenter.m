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

- (void)registerObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass {
    NSLog(@"Adding %@ for event %zd for controllers of class %@", NSStringFromClass([observer class]),
            event, NSStringFromClass(viewControllerClass));
    SUIControllerEventObservers *observers = [self controllerEventObserverForEvent:event byClass:viewControllerClass];
    [observers addObserver:observer];
}

- (NSArray *)viewControllersWithClass:(Class)aClass {
    return [self.allViewControllers objectsWithClass:aClass];
}

- (void)removeObserver:(id <SUIControllerObserver>)observer fromEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass {
    NSLog(@"Removing %@ from event %zd for controllers of class %@", NSStringFromClass([observer class]),
            event, NSStringFromClass(viewControllerClass));
    SUIControllerEventObservers *observers = [self controllerEventObserverForEvent:event byClass:viewControllerClass];
    [observers removeObserver:observer];
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
    while(classSuperClass != UIResponder.class) {
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