#import <Foundation/Foundation.h>
#import "SUIControlCenter.h"

@protocol SUIControllerObserver <NSObject>

///---------------------
/// @name Observation
///---------------------

/**
Receive and handle event from the requested event types to view controllers.
@param event The event that occurred to the view controller.
@param controller The view controller instance that the event occurred on.
*/
@required
- (void)handleEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)controller;

@end