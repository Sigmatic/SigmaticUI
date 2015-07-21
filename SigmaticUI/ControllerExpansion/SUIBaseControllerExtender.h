#import <Foundation/Foundation.h>
#import "SUIControllerExtender.h"


@interface SUIBaseControllerExtender : NSObject <SUIControllerExtender>

@property(nonatomic, readonly) UIView *view;

@end