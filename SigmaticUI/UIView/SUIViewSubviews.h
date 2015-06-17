#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Subviews)

- (void)removeAllSubviews;

- (NSArray *)subviewsWithClass:(Class)aClass;

- (NSArray *)textInputSubviews;

@end