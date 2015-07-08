#import "SUIControllerEventManager.h"
#import "SUIControllerObserver.h"
#import "SUIControllerEventObservers.h"


@interface SUIControllerEventManager ()
@property(nonatomic) NSMutableDictionary *eventObservers;
@end

@implementation SUIControllerEventManager

+ (instancetype)sharedInstance {
    static SUIControllerEventManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SUIControllerEventManager alloc] init];
    });
    return sharedInstance;
}

- (void)registerObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass {
    SUIControllerEventObservers *observers = [self controllerEventObserverForEvent:event byClass:viewControllerClass];
    [observers addObserver:observer];
}

- (void)removeObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass {
    SUIControllerEventObservers *observers = [self controllerEventObserverForEvent:event byClass:viewControllerClass];
    [observers removeObserver:observer];
}

- (void)removeObserver:(id <SUIControllerObserver>)observer {
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

- (NSMutableDictionary *)eventObservers {
    if (!_eventObservers) {
        _eventObservers = [NSMutableDictionary new];
    }
    return _eventObservers;
}


@end