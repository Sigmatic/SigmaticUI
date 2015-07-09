#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SUIViewFrame.h"

@interface SUIViewFrameTests : XCTestCase

@property(nonatomic) UIView *superview;
@property(nonatomic) UIView *subject;
@property(nonatomic) UIView *sibling;

@end

@implementation SUIViewFrameTests

- (void)setUp {
    [super setUp];
    CGRect superviewFrame = CGRectMake(0, 0, 100, 100);
    self.superview = [[UIView alloc] initWithFrame:superviewFrame];
    CGRect mainViewFrame = CGRectMake(10, 10, 10, 10);
    self.subject = [[UIView alloc] initWithFrame:mainViewFrame];
    [self.superview addSubview:self.subject];
    CGRect siblingFrame = CGRectMake(45, 45, 10, 10);
    self.sibling = [[UIView alloc] initWithFrame:siblingFrame];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFrameGetters {
    XCTAssertEqual(self.subject.frame.origin.x, self.subject.x);
    XCTAssertEqual(self.subject.frame.origin.y, self.subject.y);
    XCTAssertEqual(self.subject.frame.size.width, self.subject.width);
    XCTAssertEqual(self.subject.frame.size.height, self.subject.height);
}

- (void)testFrameSetters {
    [self.subject setX:5.f];
    [self.subject setY:-5.f];
    [self.subject setWidth:20.f];
    [self.subject setHeight:10.f];
    XCTAssertEqual(5.f, self.subject.frame.origin.x);
    XCTAssertEqual(-5.f, self.subject.frame.origin.y);
    XCTAssertEqual(20.f, self.subject.frame.size.width);
    XCTAssertEqual(10.f, self.subject.frame.size.height);
}

- (void)testAlignsLeft {
    [self.subject alignLeft];
    XCTAssertEqual(0.f, self.subject.frame.origin.x);
    [self.subject alignLeft:3.f];
    XCTAssertEqual(3.f, self.subject.frame.origin.x);
}

- (void)testAlignsTop {
    [self.subject alignTop];
    XCTAssertEqual(0.f, self.subject.frame.origin.y);
    [self.subject alignTop:3.f];
    XCTAssertEqual(3.f, self.subject.frame.origin.y);
}

- (void)testAlignsRight {
    [self.subject alignRight];
    XCTAssertEqual(90.f, self.subject.frame.origin.x);
    [self.subject alignRight:3.f];
    XCTAssertEqual(87.f, self.subject.frame.origin.x);
}

- (void)testAlignsBottom {
    [self.subject alignBottom];
    XCTAssertEqual(90.f, self.subject.frame.origin.y);
    [self.subject alignBottom:3.f];
    XCTAssertEqual(87.f, self.subject.frame.origin.y);
}

//Subject at CGRectMake(10, 10, 10, 10);
//Sibling is at CGRectMake(45, 45, 10, 10);
- (void)testAlignsLeftOfView {
    [self.subject alignLeftOfView:self.sibling];
    XCTAssertEqual(35.f, self.subject.frame.origin.x);
    [self.subject alignLeftOfView:self.sibling margin:3.f];
    XCTAssertEqual(32.f, self.subject.frame.origin.x);
}

- (void)testAlignsAboveView {
    [self.subject alignAboveView:self.sibling];
    XCTAssertEqual(35.f, self.subject.frame.origin.y);
    [self.subject alignAboveView:self.sibling margin:3.f];
    XCTAssertEqual(32.f, self.subject.frame.origin.y);
}

- (void)testAlignsRightOfView {
    [self.subject alignRightOfView:self.sibling];
    XCTAssertEqual(55.f, self.subject.frame.origin.x);
    [self.subject alignRightOfView:self.sibling margin:3.f];
    XCTAssertEqual(58.f, self.subject.frame.origin.x);
}

- (void)testAlignsBelowView {
    [self.subject alignBelowView:self.sibling];
    XCTAssertEqual(55.f, self.subject.frame.origin.y);
    [self.subject alignBelowView:self.sibling margin:3.f];
    XCTAssertEqual(58.f, self.subject.frame.origin.y);
}

- (void)testMovesLeft {
    [self.subject moveLeft:4.f];
    XCTAssertEqual(6.f, self.subject.frame.origin.x);
}

- (void)testMovesUp {
    [self.subject moveUp:4.f];
    XCTAssertEqual(6.f, self.subject.frame.origin.y);
}

- (void)testMovesRight {
    [self.subject moveRight:4.f];
    XCTAssertEqual(14.f, self.subject.frame.origin.x);
}

- (void)testMovesDown {
    [self.subject moveDown:4.f];
    XCTAssertEqual(14.f, self.subject.frame.origin.y);
}

- (void)testCentersInSuperview {
    [self.subject centerInSuperview];
    XCTAssertEqual(50.f, self.subject.center.x);
    XCTAssertEqual(50.f, self.subject.center.y);
}

- (void)testCentersHorizontally {
    [self.subject centerHorizontally];
    XCTAssertEqual(50.f, self.subject.center.x);
    XCTAssertEqual(10.f, self.subject.frame.origin.y); //No change
}

- (void)testCentersVertically {
    [self.subject centerVertically];
    XCTAssertEqual(50.f, self.subject.center.y);
    XCTAssertEqual(10.f, self.subject.frame.origin.x); //No change
}

- (void)testScales {
    [self.subject scale:2.f];
    XCTAssertEqual(20.f, self.subject.frame.size.width);
    XCTAssertEqual(20.f, self.subject.frame.size.height);
    XCTAssertEqual(5.f, self.subject.frame.origin.x);
    XCTAssertEqual(5.f, self.subject.frame.origin.y);
}

- (void)testScaleAvoidsMinus {
    [self.subject scale:-2.f];
    XCTAssertEqual(20.f, self.subject.frame.size.width);
    XCTAssertEqual(20.f, self.subject.frame.size.height);
    XCTAssertEqual(5.f, self.subject.frame.origin.x);
    XCTAssertEqual(5.f, self.subject.frame.origin.y);
}

- (void)testScalesToZero {
    [self.subject scale:0];
    XCTAssertEqual(0.f, self.subject.frame.size.width);
    XCTAssertEqual(0.f, self.subject.frame.size.height);
    XCTAssertEqual(15.f, self.subject.frame.origin.x);
    XCTAssertEqual(15.f, self.subject.frame.origin.y);
}

@end