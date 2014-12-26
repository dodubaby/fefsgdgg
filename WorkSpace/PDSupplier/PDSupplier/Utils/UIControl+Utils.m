

#import "UIControl+Utils.h"
#import <objc/runtime.h>

@interface UIControlActionBlockWrapper : NSObject
@property (nonatomic, copy) void (^actionBlock)(id);
- (void) invokeBlock:(id)sender;
@end

@implementation UIControlActionBlockWrapper
@synthesize actionBlock;
- (void) dealloc {
    [self setActionBlock:nil];
}

- (void) invokeBlock:(id)sender {
    [self actionBlock](sender);
}
@end


@implementation UIControl (Utils)

const char *UIControlBlocks;

- (void)handleControlEvents:(UIControlEvents)controlEvents actionBlock:(void(^)(id sender))actionBlock{
    
    NSMutableDictionary *blockActions = objc_getAssociatedObject(self, &UIControlBlocks);
    if (blockActions == nil) {
        blockActions = [NSMutableDictionary dictionaryWithCapacity:1];
        objc_setAssociatedObject(self, &UIControlBlocks, blockActions, OBJC_ASSOCIATION_RETAIN);
    }
    
    UIControlActionBlockWrapper *target = [[UIControlActionBlockWrapper alloc] init];
    [target setActionBlock:actionBlock];
    
    NSNumber *key = [NSNumber numberWithInt:controlEvents];
    NSMutableArray *actionsForControlEvents = [blockActions objectForKey:key];
    if (!actionsForControlEvents) {
        actionsForControlEvents = [NSMutableArray arrayWithCapacity:1];
        [blockActions setObject:actionsForControlEvents forKey:key];
    }
    
    [actionsForControlEvents addObject:target];
    
    [self addTarget:target action:@selector(invokeBlock:) forControlEvents:controlEvents];
}

- (void)removeHandlerForEvents:(UIControlEvents)controlEvents{
    NSMutableDictionary *blockActions = objc_getAssociatedObject(self, &UIControlBlocks);
    if (blockActions) {
        NSMutableArray *actionsForControlEvents = [blockActions objectForKey:[NSNumber numberWithInt:controlEvents]];
        if (actionsForControlEvents) {
            for (NSUInteger i = [actionsForControlEvents count]; i > 0; i--) {
                UIControlActionBlockWrapper *target = (UIControlActionBlockWrapper *)[actionsForControlEvents objectAtIndex:i];
                [self removeTarget:target action:@selector(invokeBlock:) forControlEvents:controlEvents];
                [actionsForControlEvents removeObjectAtIndex:i];
            }
        }
    }
}

@end
