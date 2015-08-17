#import "SUITableViewExtension.h"


@implementation UITableView (SUIExtension)

- (void)deselectAll {
    [self deselectAll:NO];
}

- (void)deselectAll:(BOOL)animated {
    NSArray *selected = [self indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selected) {
        [self deselectRowAtIndexPath:indexPath animated:animated];
    }
}

- (void)insertRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)safeInsertRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPath) {
        [self insertRow:indexPath withRowAnimation:animation];
    }
}

- (void)deleteRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)safeDeleteRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPath) {
        [self deleteRow:indexPath withRowAnimation:animation];
    }
}

- (void)reloadRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)safeReloadRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPath) {
        [self reloadRow:indexPath withRowAnimation:animation];
    }
}

@end