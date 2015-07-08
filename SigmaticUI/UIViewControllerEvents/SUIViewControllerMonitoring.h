#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIViewController(Monitoring)

@property(nonatomic, readonly) BOOL isVisible;

- (void)firstViewWillAppear:(BOOL)animated;

- (void)firstViewDidAppear:(BOOL)animated;

@end