#import <UIKit/UIKit.h>

/**
 * The handlful of UIControl properties to add on to UITextView.
 *
 * @discussion This is not an exhaustive collection of all of UIControl's
 * properties.
 */
@interface UITextView (APSUIControlStates)

/**
 * UIControl's enabled property:
 *
 *     @property(nonatomic,getter=isEnabled) BOOL enabled;
 *
 * I coudn't get the tests to pass when using the `@property` syntax -- perhaps
 * there's some peculiarity about class extensions and resolving properties to
 * their underlying method implementations that I am unaware of?
 */
- (BOOL)isEnabled;
- (void)setEnabled:(BOOL)enabled;

@end
