#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIViewController (Monitoring)

/**
Updated property to maintain whether view is visible
*/
@property(nonatomic, readonly) BOOL isVisible;

///---------------------
/// @name First Appearance
///---------------------

/**
Callback for only the first view will appear
@param animated Whether the view is presented with animation
*/
- (void)firstViewWillAppear:(BOOL)animated;

/**
Callback for only the first view did appear
@param animated Whether the view is presented with animation
*/
- (void)firstViewDidAppear:(BOOL)animated;

@end