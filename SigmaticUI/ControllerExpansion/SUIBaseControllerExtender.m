#import "SUIBaseControllerExtender.h"


@implementation SUIBaseControllerExtender

@synthesize hostViewController;

- (UIView *)view {
    return self.hostViewController.view;
}

- (Class)requiredHostClassType {
    return UIViewController.class;
}

- (void)handleAddedToViewController {

}

- (void)handleViewControllerWillDealloc {

}

- (void)viewDidLoad {

}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)firstViewWillAppear:(BOOL)animated {

}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)firstViewDidAppear:(BOOL)animated {

}

- (void)viewWillDisappear:(BOOL)animated {

}

- (void)viewDidDisappear:(BOOL)animated {

}


@end