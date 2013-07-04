#import "UITextView+APSUIControlTargetAction.h"
#import <objc/runtime.h>

static void *APSUIControlTargetActionEventsTargetActionsMapKey = &APSUIControlTargetActionEventsTargetActionsMapKey;

@implementation UITextView (APSUIControlTargetAction)

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    NSMutableSet *targetActions = self.aps_eventsTargetActionsMap[@(controlEvents)];
    if (targetActions == nil) {
        targetActions = [NSMutableSet set];
        self.aps_eventsTargetActionsMap[@(controlEvents)] = targetActions;
    }
    [targetActions addObject:@{ @"target": target, @"action": NSStringFromSelector(action) }];

    [self.aps_notificationCenter addObserver:self
                                    selector:@selector(aps_textViewDidBeginEditing:)
                                        name:UITextViewTextDidBeginEditingNotification
                                      object:self];
    [self.aps_notificationCenter addObserver:self
                                    selector:@selector(aps_textViewChanged:)
                                        name:UITextViewTextDidChangeNotification
                                      object:self];
    [self.aps_notificationCenter addObserver:self
                                    selector:@selector(aps_textViewDidEndEditing:)
                                        name:UITextViewTextDidEndEditingNotification
                                      object:self];
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    NSMutableSet *targetActions = self.aps_eventsTargetActionsMap[@(controlEvents)];
    NSDictionary *targetAction = nil;
    for (NSDictionary *ta in targetActions) {
        if (ta[@"target"] == target && [ta[@"action"] isEqualToString:NSStringFromSelector(action)]) {
            targetAction = ta;
            break;
        }
    }
    if (targetAction) {
        [targetActions removeObject:targetAction];
    }
}

- (NSSet *)allTargets
{
    NSMutableSet *targets = [NSMutableSet set];
    [self.aps_eventsTargetActionsMap enumerateKeysAndObjectsUsingBlock:^(id key, NSSet *targetActions, BOOL *stop) {
        for (NSDictionary *ta in targetActions) { [targets addObject:ta[@"target"]]; }
    }];
    return targets;
}

- (UIControlEvents)allControlEvents
{
    NSArray *arrayOfEvents = self.aps_eventsTargetActionsMap.allKeys;
    UIControlEvents allControlEvents = 0;
    for (NSNumber *e in arrayOfEvents) {
        allControlEvents = allControlEvents|e.unsignedIntegerValue;
    };
    return allControlEvents;
}

- (NSArray *)actionsForTarget:(id)target forControlEvent:(UIControlEvents)controlEvent
{
    NSMutableSet *targetActions = [NSMutableSet set];
    for (NSNumber *ce in self.aps_eventsTargetActionsMap.allKeys) {
        if (ce.unsignedIntegerValue & controlEvent) {
            [targetActions addObjectsFromArray:[self.aps_eventsTargetActionsMap[ce] allObjects]];
        }
    }

    NSMutableArray *actions = [NSMutableArray array];
    for (NSDictionary *ta in targetActions) {
        if (ta[@"target"] == target) [actions addObject:ta[@"action"]];
    }

    return actions.count ? actions : nil;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self.aps_application sendAction:action to:target from:self forEvent:event];
}

- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents
{
    for (id target in self.allTargets.allObjects) {
        NSArray *actions = [self actionsForTarget:target forControlEvent:controlEvents];
        for (NSString *action in actions) {
            [self sendAction:NSSelectorFromString(action) to:target forEvent:nil];
        }
    }
}

#pragma mark Notifications

- (void)aps_textViewDidBeginEditing:(NSNotification *)notification
{
    [self aps_forwardControlEvent:UIControlEventEditingDidBegin fromSender:notification.object];
}

- (void)aps_textViewChanged:(NSNotification *)notification
{
    [self aps_forwardControlEvent:UIControlEventEditingChanged fromSender:notification.object];
}

- (void)aps_textViewDidEndEditing:(NSNotification *)notification
{
    [self aps_forwardControlEvent:UIControlEventEditingDidEnd fromSender:notification.object];
}

- (void)aps_forwardControlEvent:(UIControlEvents)controlEvent fromSender:(id)sender
{
    NSArray *events = self.aps_eventsTargetActionsMap.allKeys;
    for (NSNumber *ce in events) {
        if (ce.unsignedIntegerValue & controlEvent) {
            NSMutableSet *targetActions = self.aps_eventsTargetActionsMap[ce];
            for (NSDictionary *ta in targetActions) {
                [ta[@"target"] performSelector:NSSelectorFromString(ta[@"action"])
                                    withObject:sender];
            }
        }
    }
}

#pragma mark Private

- (NSMutableDictionary *)aps_eventsTargetActionsMap
{
    NSMutableDictionary *eventsTargetActionsMap = objc_getAssociatedObject(self, APSUIControlTargetActionEventsTargetActionsMapKey);
    if (eventsTargetActionsMap == nil) {
        eventsTargetActionsMap = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(
            self,
            APSUIControlTargetActionEventsTargetActionsMapKey,
            eventsTargetActionsMap,
            OBJC_ASSOCIATION_RETAIN_NONATOMIC
        );
    }
    return eventsTargetActionsMap;
}

- (NSNotificationCenter *)aps_notificationCenter
{
    return [NSNotificationCenter defaultCenter];
}

- (UIApplication *)aps_application { return UIApplication.sharedApplication; }

@end
