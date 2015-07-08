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

@interface SUIControllerEventManager : NSObject

/*Shared monitoring manager*/
+ (instancetype)sharedInstance;

/*Add observer for view controller events*/
- (void)registerObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass;

/*Remove observer from view controller events*/
- (void)removeObserver:(id <SUIControllerObserver>)observer fromEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass;

/*Remove observer from everything*/
- (void)removeObserver:(id <SUIControllerObserver>)observer;

/*NOT for manual use. Called by view controllers to register new events*/
- (void)registerEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)viewController;

@end