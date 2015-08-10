#import "ViewController.h"
#import "SUIViewSubviews.h"
#import "SUIViewFrame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *textInputViews = [self.view textInputSubviews];
    NSLog(@"Count %zd", textInputViews.count);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (IBAction)didTapResizeButton {
    NSLog(@"Want to resize");
}

- (IBAction)didTapShowModalButton {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}


@end
