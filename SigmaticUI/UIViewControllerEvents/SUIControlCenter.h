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


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SUIControllerObserver;

typedef NS_OPTIONS(NSUInteger, SUIViewControllerEvent) {
    SUIViewControllerViewDidLoad = 1UL << 1,
    SUIViewControllerViewWillAppear = 1UL << 2,
    SUIViewControllerFirstViewWillAppear = 1UL << 3,
    SUIViewControllerViewDidAppear = 1UL << 4,
    SUIViewControllerFirstViewDidAppear = 1UL << 5,
    SUIViewControllerViewWillDisappear = 1UL << 6,
    SUIViewControllerViewDidDisappear = 1UL << 7,
    SUIViewControllerAllEvents = SUIViewControllerViewDidLoad | SUIViewControllerViewWillAppear | SUIViewControllerFirstViewWillAppear | SUIViewControllerViewDidAppear | SUIViewControllerFirstViewDidAppear | SUIViewControllerViewWillDisappear | SUIViewControllerViewDidDisappear
};

NS_ASSUME_NONNULL_BEGIN

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
@param events The events registering to receive notifications for.
@param viewControllerClass The class type to receive notifications for.
*/
- (void)registerObserver:(id <SUIControllerObserver>)observer forEvents:(SUIViewControllerEvent)events byClass:(Class)viewControllerClass;


/**
Remove observer from view controller events.
@param observer The events observer to remove.
@param events The events that the observer is no longer interested in.
@param viewControllerClass The class type to remove notifications for.
*/
- (void)removeObserver:(id <SUIControllerObserver>)observer fromEvents:(SUIViewControllerEvent)events byClass:(Class)viewControllerClass;

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

NS_ASSUME_NONNULL_END