#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (SUISubviews)

/*Clear all subviews*/
- (void)removeAllSubviews;

/*All subviews with the defined class. Recursive*/
- (NSArray *)subviewsWithClass:(Class)aClass;

/*All text input views that can be edited by the user. Sorted by their location on screen*/
- (NSArray *)textInputSubviews;

@end