#import "UITextView+APSUIControlTargetAction.h"
#import <objc/runtime.h>

static void *APSUIControlTargetActionTargetsKey = &APSUIControlTargetActionTargetsKey;

@implementation UITextView (APSUIControlTargetAction)

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.aps_mutableAllTargets addObject:target];
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
#warning TODO: Implement me
}

- (NSSet *)allTargets
{
    return self.aps_mutableAllTargets;
}

- (UIControlEvents)allControlEvents
{
#warning TODO: Implement me
    return UIControlEventAllEvents;
}

- (NSArray *)actionsForTarget:(id)target forControlEvent:(UIControlEvents)controlEven
{
#warning TODO: Implement me
    return nil;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
#warning TODO: Implement me
}

- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents
{
#warning TODO: Implement me
}

#pragma mark Private

- (NSMutableSet *)aps_mutableAllTargets
{
    NSMutableSet *mutableAllTargets = objc_getAssociatedObject(self, APSUIControlTargetActionTargetsKey);
    if (mutableAllTargets == nil) {
        mutableAllTargets = [NSMutableSet set];
        objc_setAssociatedObject(self, APSUIControlTargetActionTargetsKey, mutableAllTargets, OBJC_ASSOCIATION_RETAIN);
    }
    return mutableAllTargets;
}

@end
