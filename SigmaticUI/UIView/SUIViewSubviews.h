#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (SUISubviews)

- (void)removeAllSubviews;

- (NSArray *)subviewsWithClass:(Class)aClass;

- (NSArray *)textInputSubviews;

@end