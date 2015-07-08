#import <Foundation/Foundation.h>

@protocol SUIControllerObserver;


@interface SUIControllerEventObservers : NSObject

//So that no one can change these.
@property(nonatomic, readonly) Class observedClass;
@property(nonatomic, readonly) NSArray *observers;

+ (instancetype)newWithClass:(Class)aClass;

- (void)addObserver:(id<SUIControllerObserver>)observer;
- (void)removeObserver:(id<SUIControllerObserver>)observer;

@end