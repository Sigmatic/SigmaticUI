#import <Foundation/Foundation.h>

@protocol SUIControllerObserver;


@interface SUIControllerEventObservers : NSObject

///---------------------
/// @name Class Observers
///---------------------

/**
Class type being observed
*/
@property(nonatomic, readonly) Class observedClass;

/**
List of observers
*/
@property(nonatomic, readonly) NSArray *observers;

///---------------------
/// @name Initialization
///---------------------

/**
Create a new event observers holder object.
@param aClass the class the observers are observing.
*/
+ (instancetype)newWithClass:(Class)aClass;

///---------------------
/// @name Observers
///---------------------

/**
Add a new observer that adopts the SUIControllerObserver protocol.
@param observer the object that will be added as an observer.
*/
- (void)addObserver:(id <SUIControllerObserver>)observer;

/**
Remove an observer.
@param observer the object that will be removed from observing.
*/
- (void)removeObserver:(id <SUIControllerObserver>)observer;

@end