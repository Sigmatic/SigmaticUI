#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SUICenterControllerHolder : NSObject

@property(nonatomic, weak) UIViewController *viewController;

+ (instancetype)newWithController:(UIViewController *)controller;

@end