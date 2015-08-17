#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableView (SUIExtension)

- (void)deselectAll;

- (void)deselectAll:(BOOL)animated;

- (void)insertRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)safeInsertRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)safeDeleteRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)safeReloadRow:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

@end