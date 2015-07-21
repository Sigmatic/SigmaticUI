#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic) BOOL propertyInjected;
@property(nonatomic) IBOutlet UIView *resizingView;

- (IBAction)didTapResizeButton;

@end

