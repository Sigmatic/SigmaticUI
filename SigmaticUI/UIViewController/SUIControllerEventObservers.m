#import "SUIControllerEventObservers.h"
#import "SUIControllerObserver.h"

@interface SUIControllerEventObservers ()
@property(nonatomic) NSMutableArray *innerObservers;
@property(nonatomic) Class innerObservedClass;
@end

@implementation SUIControllerEventObservers


+ (instancetype)newWithClass:(Class)aClass {
    SUIControllerEventObservers *observers = [SUIControllerEventObservers new];
    [observers setInnerObservedClass:aClass];
    return observers;
}

- (void)addObserver:(id <SUIControllerObserver>)observer {
    if (observer == nil) {
        return;
    }
    if (![self.innerObservers containsObject:observer]) {
        [self.innerObservers addObject:observer];
    }
}

- (void)removeObserver:(id <SUIControllerObserver>)observer {
    [self.innerObservers removeObject:observer];
}

#pragma mark - Get Set

- (NSArray *)observers {
    return [self.innerObservers copy];
}

- (Class)observedClass {
    return self.innerObservedClass;
}

- (NSMutableArray *)innerObservers {
    if (!_innerObservers) {
        _innerObservers = [NSMutableArray new];
    }
    return _innerObservers;
}


@end