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
    CGRect siblingFrame = CGRectMake(45, 40, 10, 10);
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

@end