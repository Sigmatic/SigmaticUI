// Copyright (c) 2015 Sigmatic
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


#import "SUIControllerEventObservers.h"
#import "SUIControllerObserver.h"
#import "SOCMutableArrayExtension.h"

@interface SUIControllerEventObservers ()
@property(nonatomic) NSMutableArray *innerObservers;
@property(nonatomic) Class innerObservedClass;
@end

@implementation SUIControllerEventObservers


+ (instancetype)newWithClass:(Class)aClass {
    SUIControllerEventObservers *observers = [SUIControllerEventObservers new];
    [observers setInnerObservedClass:aClass];
    return observers;
}

- (void)addObserver:(id <SUIControllerObserver>)observer {
    [self.innerObservers safeAddObjectIfNew:observer];
}

- (void)removeObserver:(id <SUIControllerObserver>)observer {
    [self.innerObservers removeObject:observer];
}

#pragma mark - Get Set

- (NSArray *)observers {
    return [self.innerObservers copy];
}

- (Class)observedClass {
    return self.innerObservedClass;
}

- (NSMutableArray *)innerObservers {
    if (!_innerObservers) {
        _innerObservers = [NSMutableArray new];
    }
    return _innerObservers;
}


@end