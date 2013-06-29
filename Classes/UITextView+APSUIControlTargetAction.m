#import "UITextView+APSUIControlTargetAction.h"

@implementation UITextView (APSUIControlTargetAction)

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
#warning TODO: Implement me
    // TODO: you know, add the target and action for the control events
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
#warning TODO: Implement me
}

- (NSSet *)allTargets
{
#warning TODO: Implement me
    return nil;
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

@end
