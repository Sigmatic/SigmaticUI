#import <Foundation/Foundation.h>
#import "SUIControlCenter.h"

@protocol SUIControllerObserver <NSObject>

@required
- (void)handleEvent:(SUIViewControllerEvent)event byViewController:(UIViewController *)controller;

@end