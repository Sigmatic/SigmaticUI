#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SUIControllerExtender <NSObject>

@property(nonatomic, weak) UIViewController *hostViewController;

@optional
- (Class)requiredHostClassType;

- (void)handleAddedToViewController;

- (void)handleViewControllerWillDealloc;

- (void)viewDidLoad;

- (void)viewWillAppear:(BOOL)animated;

- (void)firstViewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)firstViewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

@end