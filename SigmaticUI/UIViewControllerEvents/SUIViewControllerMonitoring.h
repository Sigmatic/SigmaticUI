#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIViewController(Monitoring)

@property(nonatomic) BOOL didWillAppearFirstTime;
@property(nonatomic) BOOL didDidAppearFirstTime;

- (void)firstViewWillAppear:(BOOL)animated;

- (void)firstViewDidAppear:(BOOL)animated;

@end