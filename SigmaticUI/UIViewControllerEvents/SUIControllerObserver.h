#import <Foundation/Foundation.h>
#import "SUIControllerEventManager.h"

@protocol SUIControllerObserver <NSObject>

@required
- (void)handleEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)controller;

@end