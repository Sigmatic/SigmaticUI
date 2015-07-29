#import "SUISlideToDismissExtender.h"


@implementation SUISlideToDismissExtender {
    CGFloat firstX;
    CGFloat firstY;
}

- (Class)requiredHostClassType {
    return UINavigationController.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panRecognizer];
}

-(void)move:(id)sender {
    [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];

    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
    }

    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY);

    [[sender view] setCenter:translatedPoint];

    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        /*CGFloat velocityX = (0.2*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);*/
        CGFloat finalX = firstX;

        CGFloat velocityY = .35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y;
        CGFloat finalY = translatedPoint.y + velocityY;

        if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
            if (finalX < 0) {
                //finalX = 0;
            } else if (finalX > 768) {
                //finalX = 768;
            }

            if (finalY < 0) {
                finalY = 0;
            } else if (finalY > 1024) {
                finalY = 1024;
            }
        } else {
            if (finalX < 0) {
                //finalX = 0;
            } else if (finalX > 1024) {
                //finalX = 768;
            }

            if (finalY < 0) {
                finalY = 0;
            } else if (finalY > 768) {
                finalY = 1024;
            }
        }

        CGFloat animationDuration = (ABS(velocityY)*.0002)+.2;

        NSLog(@"the duration is: %f", animationDuration);

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
        [[sender view] setCenter:CGPointMake(finalX, finalY)];
        [UIView commitAnimations];
    }
}

- (void)animationDidFinish {

}

@end