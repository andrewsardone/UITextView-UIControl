#import "UITextView+APSUIControlStates.h"

@implementation UITextView (APSUIControlStates)

- (BOOL)isEnabled { return self.isEditable; }

- (void)setEnabled:(BOOL)enabled { self.editable = enabled; }

@end
