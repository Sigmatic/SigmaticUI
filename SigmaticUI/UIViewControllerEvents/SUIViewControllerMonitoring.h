#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIViewController(Monitoring)

/*Updated property to maintain whether view is visible*/
@property(nonatomic, readonly) BOOL isVisible;

/*Callback for only the first view will appear*/
- (void)firstViewWillAppear:(BOOL)animated;

/*Callback for only the first view did appear*/
- (void)firstViewDidAppear:(BOOL)animated;

@end