

#import <UIKit/UIKit.h>

@interface UIControl (Utils)

- (void)handleControlEvents:(UIControlEvents)controlEvents actionBlock:(void(^)(id sender))actionBlock;
- (void)removeHandlerForEvents:(UIControlEvents)controlEvents;

@end
