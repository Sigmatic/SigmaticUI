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

+ (instancetype)sharedInstance;

- (void)registerObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass;

- (void)removeObserver:(id <SUIControllerObserver>)observer forEvent:(SUIViewControllerEvent)event byClass:(Class)viewControllerClass;

- (void)removeObserver:(id <SUIControllerObserver>)observer;

- (void)registerEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)viewController;

@end