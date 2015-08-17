#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UINavigationController (SUIExtension)

@property(nonatomic, readonly) BOOL isOnRootViewController;

- (void)removeNavigationBarHairline;

+ (void)removeHairlineFromNavigationBar:(UINavigationBar *)navigationBar;

- (NSArray *)popToViewControllerWithClass:(Class)aClass animated:(BOOL)animated;

@end