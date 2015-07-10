#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SUIViewSorting : NSObject

///---------------------
/// @name View Sorting
///---------------------


/**
Sort views based on their location on screen
*/
+ (NSArray *)sortViews:(NSArray *)views;

@end