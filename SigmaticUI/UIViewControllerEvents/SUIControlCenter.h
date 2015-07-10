#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SUIControllerObserver;

typedef NS_ENUM(NSInteger , SUIViewControllerEvent) {
    SUIViewControllerViewDidLoad,
    SUIViewControllerViewWillAppear,
    SUIViewControllerFirstViewWillAppear,
    SUIViewControllerViewDidAppear,
    SUIViewControllerFirstViewDidAppear,
    SUIViewControllerViewWillDisappear,
    SUIViewControllerViewDidDisappear,
};

@interface SUIControlCenter : NSObject

///---------------------
/// @name Initialization
///---------------------

/**
Creates and returns the default `SUIControlCenter` object.
*/
+ (instancetype)defaultCenter;


///---------------------
/// @name Observation
///---------------------

/**
Add observer for view controller events.
@param observer The events observer that adopts the SUIControllerObserver protocol.
@param event The event registering to receive notifications for.
@param viewControllerClass The class type to receive notifications for.
*/
- (void)registerObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass;


/**
Remove observer from view controller events.
@param observer The events observer to remove.
@param event The event that the observer is no longer interested int.
@param viewControllerClass The class type to remove notifications for.
*/
- (void)removeObserver:(id <SUIControllerObserver>)observer fromEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass;

/**
Remove observer from everything.
@param observer The events observer to remove.
*/
- (void)removeObserver:(id <SUIControllerObserver>)observer;

/**
Get all view controller instances of a class type.
@param aClass The class type to filter.
*/
- (NSArray *)viewControllersWithClass:(Class)aClass;

/*NOT for manual use. Called by view controllers to register new events*/
- (void)registerEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)viewController;

/*NOT for manual use. Called by view controllers to register themselves*/
- (void)registerViewController:(UIViewController *)viewController;

/*NOT for manual use. Called by view controllers to un-register themselves*/
- (void)removeViewController:(UIViewController *)viewController;


@end