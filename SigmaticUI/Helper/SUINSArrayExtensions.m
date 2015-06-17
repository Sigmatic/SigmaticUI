#import "SUINSArrayExtensions.h"


@implementation NSArray (Extensions)

- (NSArray *)objectsWithClass:(Class)aClass {
    NSMutableArray *results = [NSMutableArray new];
    for (id object in self) {
        if ([object isKindOfClass:aClass]) {
            [results addObject:object];
        }
    }
    return [results copy];
}


@end